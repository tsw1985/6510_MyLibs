INPUT_LIB:
{
    #import "input_macros/input_lib_macros.asm"

    input_keyboard:
    jsr print_cursor

    read_key:

        // Port A = enter
        lda #$00
        sta $DC02 // ---> $DC00

        // Port B = exit
        lda #$ff
        sta $DC03 // ---> $DC01

        //key flags to 0
        lda #0
        sta KEY_FLAGS

        //reset Y col Counter
        ldy #0
        sty TABLE_KEY_COL_INDEX

        //clear key pressed table
        //jsr clear_key_pressed_table

        //Count rows
        ldx TABLE_KEY_ROW_INDEX    // 0 to 7 count rows
        lda TABLE_KEY_BOARD_ROW,x  // get a row from table
        sta $DC01                  // and save it on port


            //get now KEY PRESSED . Reading COLS
            lda $DC00
            eor #%11111111           // get bit key pressed and reverse it
            sta KEY_PRESSED          // save this reversed value ( key pressed )
                                    // and now we need to know wich key was pressed

            check_cols:

                ldy TABLE_KEY_COL_INDEX   // now check cols, load Y index
                lda KEY_PRESSED           // load the key_pressed
                and TABLE_KEY_BOARD_COL,y // and know wich key was pressed
                                        // if the ANd result is diferent to
                                        // 00000000 , the flag Z is set to 0

                                        // then use BNE ( Branch Not Equals )
                                        // because this jump is Z=0

                bne key_pressed           //if a key was pressed , save it
                continue_reading:

                    //increment COL_INDEX to check next value
                    inc TABLE_KEY_COL_INDEX
                    lda TABLE_KEY_COL_INDEX
                    cmp #8
                    bne check_cols       // if col index is 8,
                                        // go to read next col row

                                // read a next row again
        inc TABLE_KEY_ROW_INDEX // next row on table ...
        lda TABLE_KEY_ROW_INDEX //
        cmp #8                  // if ROW index is 7
        beq reset_key_row_index // reset to 0

        process_buffer:

            //clear key pressed table
            jsr clear_key_pressed_table

            //print keys pressed            
            jsr print_keys_pressed

        jmp read_key            // and go to read all again

        //TODO
        //rts //return when keypress is enter

    reset_key_row_index:

        lda #0
        sta TABLE_KEY_ROW_INDEX
        jmp process_buffer

    key_pressed:

        //wait a little bit
        jsr sleep_key

        // show ROW INDEX
        jsr print_x_coord

        // show COL INDEX
        jsr print_y_coord

        // calculate offset for table
        jsr calculate_offset_for_ascii_table

        //save in run time the pressed keys on keypressed_table
        ldx TABLE_KEY_ASCII_X_OFFSET
        lda #1  //set a 1 , it means key pressed on table
        sta PRESSED_KEY_TABLE,x // set to 1 current key pressed

        // print cursor index
        jsr print_cursor_index
        
        //check combo keys
        jsr check_combo_keys
        
        continue_normal:

            //show offset result
            jsr print_offset_result

            //get char from table to print it on screen
            jsr print_current_pressed_char
            

            //check if current char is CMB, then skip to print
            lda SCREEN_CHAR
            cmp #$FF //cmb key
            beq skip_print_input // if is , then ignore
            // save the char on keys_to_screen_buffer
            // to print it on screen

            pha // save on stack the current CHAR to PRINT
            lda INPUT_INDEX_COUNTER
            cmp INPUT_STR_LIMIT
            bcc continue_print_input // < a INPUT_STR_LIMIT
            beq continue_print_input // == INPUT_STR_LIMIT
            jmp skip_print_input

        continue_print_input:

            pla // get from STACK the current CHAR to PRINT
            ldy INPUT_INDEX_COUNTER
            sta KEYS_TO_SCREEN_STR,y
            inc INPUT_INDEX_COUNTER

            inc INPUT_CURSOR_COL
            jsr print_cursor

        skip_print_input:

        jmp continue_reading // continue reading all rows

    sleep_key:

        ldx #120
        outer_loop:
            ldy #120
            inner_loop:
                nop
                dey
                bne inner_loop
                dex
        bne outer_loop
        rts


    clear_key_pressed_table:
        //empty full real time keys pressed table
        ldx #0
        clear_pressed:
        lda #0
        sta PRESSED_KEY_TABLE,x
        inx
        cpx #64
        bne clear_pressed
        rts

    move_cursor_left:

        jsr PRINT_LIB.clean_location_screen
        locate_text(7,0,YELLOW)
        print_text(move_left_str)

        dec INPUT_CURSOR_COL
        
        //invert char color
        // calcula fila y columna
        lda INPUT_CURSOR_ROW
        sta SCREEN_ROW_POS

        lda INPUT_CURSOR_COL
        sta SCREEN_COL_POS

        // calcular dirección en $0400 (pantalla)
        ldx SCREEN_ROW_POS
        lda Row_LO,x
        sta ZERO_PAGE_ROW_LOW_BYTE

        lda Row_HI,x
        sta ZERO_PAGE_ROW_HIGHT_BYTE

        ldy SCREEN_COL_POS
        lda (ZERO_PAGE_ROW_LOW_BYTE),y
        ora #%10000000
        sta (ZERO_PAGE_ROW_LOW_BYTE),y

        jmp read_key
        //invert char color

        jmp read_key
        //rts

    move_cursor_right:
        
        jsr PRINT_LIB.clean_location_screen
        locate_text(7,0,YELLOW)
        print_text(move_right_str)

        inc INPUT_CURSOR_COL
        //jsr print_cursor

        rts

    check_combo_keys:
        ldx #23  //CMB OFFSET !! not value
        lda PRESSED_KEY_TABLE,x
        beq skip // A value is 0 ? skip

        ldx #16 //Cursor key
        lda PRESSED_KEY_TABLE,x
        beq skip // A value is 0 ? skip

        // If not skip , means CMB + Cursor is pressed, move to left cursor
        jsr move_cursor_left

        skip:
            ldx #16 //check again cursor key . Here is only cursor key
            lda PRESSED_KEY_TABLE,x
            bne is_only_cursor_key // A value is == 1 ?

        jmp continue_normal

        is_only_cursor_key:
            jsr move_cursor_right
        jmp read_key

    
    print_cursor:

        lda #224 // Space white inverted  . + 128 , is the current char on inverted color
        sta SCREEN_CHAR

        lda INPUT_CURSOR_ROW
        sta SCREEN_ROW_POS

        lda INPUT_CURSOR_COL
        sta SCREEN_COL_POS

        //set color on color ram
        ldx SCREEN_ROW_POS       
        lda Row_Color_LO,x
        sta ZERO_PAGE_ROW_COLOR_LOW_BYTE

        lda Row_Color_HI,x
        sta ZERO_PAGE_ROW_COLOR_HIGHT_BYTE

        ldy SCREEN_COL_POS             
        lda #WHITE //SCREEN_CHAR_COLOR
        sta (ZERO_PAGE_ROW_COLOR_LOW_BYTE),y

        //set coords on Screen
        ldx SCREEN_ROW_POS       // Row 22
        lda Row_LO,x
        sta ZERO_PAGE_ROW_LOW_BYTE
        lda Row_HI,x
        sta ZERO_PAGE_ROW_HIGHT_BYTE

        ldy SCREEN_COL_POS             // col 15
        lda SCREEN_CHAR                // char " "
        sta (ZERO_PAGE_ROW_LOW_BYTE),y
        
        //check buffer to know if CMB key is pressed
        //to increment or decrement the cursor COL

        //inc INPUT_CURSOR_COL
        rts        

    print_x_coord:
        jsr PRINT_LIB.clean_location_screen
        locate_text(2,0,WHITE)
        print_text(coor_x_str)
        lda TABLE_KEY_ROW_INDEX
        sta div_res_0
        lda #0
        sta div_res_1
        sta div_res_2
        sta div_res_3

        // Print the result of calculation on screen
        print_calculation_result(2,3,YELLOW,div_res_0,div_res_1,div_res_2,div_res_3)
        rts

    print_y_coord:
        jsr PRINT_LIB.clean_location_screen
        locate_text(3,0,WHITE)
        print_text(coor_y_str)

        lda TABLE_KEY_COL_INDEX
        sta div_res_0
        lda #0
        sta div_res_1
        sta div_res_2
        sta div_res_3
        // Print the result of calculation on screen
        print_calculation_result(3,3,YELLOW,div_res_0,div_res_1,div_res_2,div_res_3)
        rts

    print_offset_result:

        jsr PRINT_LIB.clean_location_screen
        locate_text(4,0,WHITE)
        print_text(calc_offset_str)


        lda TABLE_KEY_ASCII_X_OFFSET //load again the offset value on A to send it to the calculation
                                     //in A is the last calculation
        sta div_res_0
        lda #0
        sta div_res_1
        sta div_res_2
        sta div_res_3
        jsr PRINT_LIB.clean_location_screen
        // Print the result of calculation on screen
        print_calculation_result(4,8,YELLOW,div_res_0,div_res_1,div_res_2,div_res_3)
        rts

    print_current_pressed_char:

        jsr PRINT_LIB.clean_location_screen
        locate_text(5,0,WHITE)
        print_text(current_char_str)

        ldx TABLE_KEY_ASCII_X_OFFSET
        lda TABLE_KEY_ASCII,x
        sta SCREEN_CHAR
        locate_text(5,5,YELLOW)
        jsr PRINT_LIB.print_char  // print single char
        rts

    print_keys_pressed:

        jsr PRINT_LIB.clean_location_screen
        locate_text(2,12,GREEN)
        locate_input()
        print_text(KEYS_TO_SCREEN_STR)
        rts

    print_cursor_index:

        jsr PRINT_LIB.clean_location_screen
        locate_text(6,0,WHITE)
        print_text(cursor_index_str)

        //put on A the value to print
        lda INPUT_CURSOR_COL
        sta div_res_0
        lda #0
        sta div_res_1
        sta div_res_2
        sta div_res_3
        jsr PRINT_LIB.clean_location_screen
        
        // Print the result of calculation on screen
        print_calculation_result(6,7,YELLOW,div_res_0,div_res_1,div_res_2,div_res_3)
        rts

    calculate_offset_for_ascii_table:
        //char = row * 8 + col
        lda TABLE_KEY_ROW_INDEX
        asl
        asl
        asl
        clc
        adc TABLE_KEY_COL_INDEX
        sta TABLE_KEY_ASCII_X_OFFSET //save offset value
        rts        
        

}
