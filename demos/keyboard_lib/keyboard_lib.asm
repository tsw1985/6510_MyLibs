read_key:


    // Puerto A de entrada
    lda #$00   
    sta $DC02 // ---> $DC00

    // Puerto B de salida
    lda #$ff
    sta $DC03 // ---> $DC01

    //key flags to 0
    lda #0
    sta KEY_FLAGS

    //reset Y col Counter
    ldy #0
    sty TABLE_KEY_COL_INDEX

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
        //print current buffer
        jsr PRINT_LIB.clean_location_screen
        locate_text(19,0,YELLOW)
        print_text(keys_buffer_to_str)

    //end row message for testing
    jsr PRINT_LIB.clean_location_screen
    locate_text(20,20,YELLOW)
    print_text(end_print_row_str)


    jmp read_key            // and go to read all again

reset_key_row_index:

    lda #0
    sta TABLE_KEY_ROW_INDEX
    jmp process_buffer

key_pressed:

    //wait a little bit
    jsr sleep_key
        
    //jsr PRINT_LIB.clean_screen

    // show ROW INDEX
    jsr PRINT_LIB.clean_location_screen
    locate_text(5,0,WHITE)
    print_text(coor_x_str)
    lda TABLE_KEY_ROW_INDEX
    sta div_res_0
    lda #0
    sta div_res_1
    sta div_res_2
    sta div_res_3

    // Print the result of calculation on screen
    print_calculation_result(5,3,YELLOW,div_res_0,div_res_1,div_res_2,div_res_3)

    // show COL INDEX
    jsr PRINT_LIB.clean_location_screen
    locate_text(6,0,WHITE)
    print_text(coor_y_str)

    lda TABLE_KEY_COL_INDEX
    sta div_res_0
    lda #0
    sta div_res_1
    sta div_res_2
    sta div_res_3
    // Print the result of calculation on screen
    print_calculation_result(6,3,YELLOW,div_res_0,div_res_1,div_res_2,div_res_3)



    // show table offset
    jsr PRINT_LIB.clean_location_screen
    locate_text(7,0,WHITE)
    print_text(table_offset_str)

    //calculate offset for table
    //char = row * 8 + col
    lda TABLE_KEY_ROW_INDEX
    asl
    asl
    asl  
    clc
    adc TABLE_KEY_COL_INDEX
    sta TABLE_KEY_ASCII_X_OFFSET //save offset value

    //show offset result
    //in A is the last calculation
    sta div_res_0
    lda #0
    sta div_res_1
    sta div_res_2
    sta div_res_3
    jsr PRINT_LIB.clean_location_screen
    // Print the result of calculation on screen
    print_calculation_result(7,8,YELLOW,div_res_0,div_res_1,div_res_2,div_res_3)

    //get char from table to print it on screen
    ldx TABLE_KEY_ASCII_X_OFFSET
    lda TABLE_KEY_ASCII,x
    sta SCREEN_CHAR
    locate_text(9,4,YELLOW)
    jsr PRINT_LIB.print_char  // print single char

    // get SCREEN_CHAR
    lda SCREEN_CHAR
    ldy KEYS_BUFFER_COUNTER
    sta keys_buffer_to_str,y

    //here we can use this like a LIMIT , like text length !!
    cpy #3  //if KEYS_BUFFER_COUNTER == 4 , reset to 0
    beq reset_key_buffer_counter

    increment_buffer_counter:
    inc KEYS_BUFFER_COUNTER
    //jmp read_key  
    jmp continue_reading // continue reading all rows

reset_key_buffer_counter:

    // reset counter
    lda #-1 
    sta KEYS_BUFFER_COUNTER

    lda #0
    ldx #0
    sta KEYS_BUFFER,x
    ldx #1
    sta KEYS_BUFFER,x
    ldx #2
    sta KEYS_BUFFER,x
    ldx #3
    sta KEYS_BUFFER,x
    ldx #4
    sta KEYS_BUFFER,x

    jmp increment_buffer_counter

sleep_key:

    //wait a microsencods between keys press
    ldx #120         // 255
    outer_loop:
        ldy #120          // 255
        inner_loop:
            nop               // 1 ciclo
            dey               // 2 ciclos
            bne inner_loop    // 2 o 3 ciclos (promedio 2)
            dex               // 2 ciclos
    bne outer_loop    // 2 o 3 ciclos
    //end wait a microsencods between keys press

rts