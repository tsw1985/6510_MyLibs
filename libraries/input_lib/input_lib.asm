INPUT_LIB:
{
    #import "input_macros/input_lib_macros.asm"

    input_keyboard:

        push_regs_to_stack()

        // Port A = enter
        lda #$00
        sta $DC02 //; ---> $DC00

        // Port B = exit
        lda #$ff
        sta $DC03 //; ---> $DC01

        // print cursor on selected position
        jsr print_cursor


    read_key:

        jsr clear_key_pressed_table // clear the table where are save the keys 
                                    // pressed before save the keys again
        
        jsr scan_all_keys           // scan all keyboard matrix to get the
                                    // pressed keys and save them in the table
        
        jsr process_pressed_keys    // finally , process all keys to do the
                                    // target actions


    
    lda KEY_FLAGS    //check if enter is pressed
    and #%00000010
    beq continue_read_key 

    .break
    pull_regs_from_stack()
    jmp fin_keyboard_demo

    continue_read_key:
        jmp read_key                    // read keyboard again


    /* ------------------------------------------------------------------------
                         FUNCTIONS
       ------------------------------------------------------------------------
    */
    scan_all_keys:
        
        ldx #0
        scan_rows_loop:

            lda TABLE_KEY_BOARD_ROW,x   // get keyboard row to explore
            sta $DC01                   // and set it on PORT B

            lda $DC00                   // get keyboard col to explore if some
                                        // key is pressed
            
            eor #%11111111              // invert values of rows cols ( 0 to 1)
            sta KEY_PRESSED             // save the inverted value on A

                                       // once we have the result of the pressed
                                       // keys, we go to retrieve the COL ROW
                                       // table

            ldy #0                    // we start to retrieve all cols ( 0 to 7)
            scan_cols_loop:

                lda KEY_PRESSED        //load current key pressed ( bits with 1)
                and TABLE_KEY_BOARD_COL,y  // match some bit with some col row?
                beq no_key_detected     // if does not match, continue with next
                                        // column 

                // if some bit match, we calculate his offter and we save it in
                // the table : "current keys pressed"


                jsr sleep_key               // sleep half second between keys presses

                // calculation of offset
                jsr calculate_offset_for_ascii_table 

                // save the offset result in the table
                jsr save_key_pressed

                // debug: print offset result
                //jsr print_offset_result              

                // add key pressed to screen string
                jsr add_key_to_screen_str

                // print main string on screen
                jsr print_keys_pressed

                // print cursor
                inc INPUT_CURSOR_COL
                jsr print_cursor

                //check if enter is pressed
                jsr check_if_key_is_enter


                /* Debug */
                // debug : show current pressed char
                jsr print_current_pressed_char  

                // debug : // see X row value of keyboard
                jsr print_x_coord
                
                // debug : // see Y row value of keyboard
                jsr print_y_coord

                // debug: print offset result
                jsr print_offset_result              

            no_key_detected:

                iny     // increment Y ( columns )
                cpy #8  // 8 cols ?
                bne scan_cols_loop // if not , continue retrieving cols

                inx     // increment X ( rows)
                cpx #8  // are 8 rows ???
                bne scan_rows_loop // not ?? continue retrieving rows
    
    rts   // finish function


    /* Main function :
        
        This is the main function. This means, once all keys were pressed, we
        need launch the custom actions on each combination.

    */
    process_pressed_keys:
        
        push_regs_to_stack()

        jsr check_combo_keys     // First action is check the combinations keys

        pull_regs_from_stack()
    rts

    /*
        Function: 
            
            Set to 1 in the table PRESSED_KEY_TABLE . Each key have a offset
            value with the formula Offset = ( Rows x 8 ) + Cols. Because the
            keyboard have a matrix 8x8.
    */
    save_key_pressed:

        push_regs_to_stack()   
          ldy TABLE_KEY_ASCII_X_OFFSET  //load in Y the offset
          lda #1
          sta PRESSED_KEY_TABLE,y    // set a 1 in this offset position table

        pull_regs_from_stack()
        rts

    /* Function:
        Check if key is enter
    */
    check_if_key_is_enter:

        push_regs_to_stack()
        ldx #8 // KEY ENTER
        lda PRESSED_KEY_TABLE,x
        bne enter_pressed
        jmp enter_not_pressed
        enter_pressed:
            lda KEY_FLAGS
            eor #%00000010
            sta KEY_FLAGS

        enter_not_pressed:
            pull_regs_from_stack()
        rts



    /*
        Function:

            This function check the combination keys. To check each combination
            we need to know the offset of the target keys
    */
    check_combo_keys:

        push_regs_to_stack()

        ldx #47 // CMB OFFSET
        lda PRESSED_KEY_TABLE,x
        beq skip // A value is 0 ? skip

        ldx #16 //Cursor key
        lda PRESSED_KEY_TABLE,x
        beq skip // A value is 0 ? skip

        // If not skip , means CMB + Cursor is pressed, move to left cursor
        .break
        lda KEY_FLAGS
        eor #%00000001
        sta KEY_FLAGS
        
        skip:

            ldx #16 //Cursor key
            lda PRESSED_KEY_TABLE,x

        pull_regs_from_stack()
        rts
        
    /* 
        Function:
            This is a function for debugging, to see the offset value of each
            key press . Must be commented. Remember we have 38911 bytes :( 
    */
    print_offset_result:

        push_regs_to_stack()

        jsr PRINT_LIB.clean_location_screen
        locate_text(4,0,WHITE)
        print_text(calc_offset_str)

        lda TABLE_KEY_ASCII_X_OFFSET
        sta div_res_0
        lda #0
        sta div_res_1
        sta div_res_2
        sta div_res_3

        jsr PRINT_LIB.clean_location_screen
        print_calculation_result(4,8,YELLOW,div_res_0,div_res_1,div_res_2,div_res_3)

        pull_regs_from_stack()
        rts

    /*
        Function: This function do a small delay of half second
    */
    sleep_key:

        push_regs_to_stack()
        ldx #140
        outer_loop:
            ldy #140
        inner_loop:
            nop
            dey
            bne inner_loop
            dex
            bne outer_loop
            
            pull_regs_from_stack()
            rts

    /* 
        Function:
            This function set to 0 each position offset on the table
            PRESSED_KEY_TABLE
    */
    clear_key_pressed_table:
        
        push_regs_to_stack()

            ldx #0
        clear_pressed:
            lda #0
            sta PRESSED_KEY_TABLE,x
            inx
            cpx #64
            bne clear_pressed

        pull_regs_from_stack()

        rts

    /*
        Function:

            This function calculate the offset, following the next formula:
            
             offset = (row * 8 ) + col

            In this case, the X registers is the current ROW. We shift the bits
            6 times. This is like do row * 8 . Finally we add the value of Y
            register who contains the current column
    */
    calculate_offset_for_ascii_table:

        push_regs_to_stack()

        txa
        asl   // x 2
        asl   // x 4
        asl   // x 8
        sta temp_offset  // save this value in a temp_offset variable
        tya
        clc
        adc temp_offset // add y, where is the col value
        sta TABLE_KEY_ASCII_X_OFFSET  //save it here
        pull_regs_from_stack()
        rts

    /* Function:

            This function print the cursor on the selected position

    */
    print_cursor:

        push_regs_to_stack()

        lda #224 // Space white inverted  . + 128 , is the current char on inverted color
        sta SCREEN_CHAR

        lda INPUT_CURSOR_ROW
        sta SCREEN_ROW_POS

        //inc INPUT_CURSOR_COL
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
        

        pull_regs_from_stack()
        rts


    /* Function:

            This is a debuggin function . To know the X value of the keyboard
            matrix.
    */
    print_x_coord:

        push_regs_to_stack()

        jsr PRINT_LIB.clean_location_screen
        locate_text(2,0,WHITE)
        print_text(coor_x_str)
        //lda TABLE_KEY_ROW_INDEX
        txa // the current row value is in X register
        sta div_res_0
        lda #0
        sta div_res_1
        sta div_res_2
        sta div_res_3

        // Print the result of calculation on screen
        print_calculation_result(2,3,YELLOW,div_res_0,div_res_1,div_res_2,div_res_3)

        pull_regs_from_stack()
        rts


    /* Function:

            This is a debuggin function . To know the Y value of the keyboard
            matrix.
    */
    print_y_coord:

        push_regs_to_stack()

        jsr PRINT_LIB.clean_location_screen
        locate_text(3,0,WHITE)
        print_text(coor_y_str)

        //lda TABLE_KEY_COL_INDEX
        tya  // the Y col value is in Y register
        sta div_res_0
        lda #0
        sta div_res_1
        sta div_res_2
        sta div_res_3
        // Print the result of calculation on screen
        print_calculation_result(3,3,YELLOW,div_res_0,div_res_1,div_res_2,div_res_3)

        pull_regs_from_stack()

        rts


    /* Function:

        Debugging function to see the current pressed key
    */
    print_current_pressed_char:

        push_regs_to_stack()

        jsr PRINT_LIB.clean_location_screen
        locate_text(5,0,WHITE)
        print_text(current_char_str)

        ldx TABLE_KEY_ASCII_X_OFFSET
        lda TABLE_KEY_ASCII,x
        sta SCREEN_CHAR
        locate_text(5,5,YELLOW)
        jsr PRINT_LIB.print_char  // print single char

        pull_regs_from_stack()

        rts

    /*
        Function:

            Save pressed key on string KEYS_TO_STRING_STR. This is the string
            that will appear on the screen.

    */
    add_key_to_screen_str:

        push_regs_to_stack()


        ldx TABLE_KEY_ASCII_X_OFFSET  // load offset
        lda TABLE_KEY_ASCII,x         // get the ascii code from chars table
        sta SCREEN_CHAR               // save the char on SCREEN_CHAR 
        
        ldy INPUT_INDEX_COUNTER       // store SCREEN_CHAR on KEYS_TO_STRING_STR
        sta KEYS_TO_SCREEN_STR,y      // in y is the index. the limit is 80
        inc INPUT_INDEX_COUNTER       // increment INPUT_INDEX_COUNTER to next
                                      // keypress

        pull_regs_from_stack()
        rts



    /*
        Function:
            
            Print current text pressing the keys

    */
    print_keys_pressed:

        push_regs_to_stack()

        jsr PRINT_LIB.clean_location_screen
        locate_text(2,12,GREEN)
        locate_input()
        print_text(KEYS_TO_SCREEN_STR)

        pull_regs_from_stack()

        rts


    end_keyboard_demo:

    jsr PRINT_LIB.clean_location_screen
    locate_text(0,0,RED)
    print_text(stars_line)
    pull_regs_from_stack()
rts


}
