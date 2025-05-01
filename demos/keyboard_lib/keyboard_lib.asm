// Puerto A de entrada
/*
lda #$00   
sta $DC02 // ---> $DC00

// Puerto B de salida
lda #$ff
sta $DC03 // ---> $DC01
*/

read_key:

    


    // Puerto A de entrada
    lda #$00   
    sta $DC02 // ---> $DC00

    // Puerto B de salida
    lda #$ff
    sta $DC03 // ---> $DC01


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

            //increment COL_INDEX to check next value
            inc TABLE_KEY_COL_INDEX
            lda TABLE_KEY_COL_INDEX
            cmp #8    
            bne check_cols           // if col index is 8, 
                                     // go to read next col row
        


                            // read a next row again 
    inc TABLE_KEY_ROW_INDEX // next row on table ...
    lda TABLE_KEY_ROW_INDEX //
    cmp #8                  // if ROW index is 7 
    beq reset_key_row_index // reset to 0
    jmp read_key            // and go to read all again

reset_key_row_index:

    lda #0
    sta TABLE_KEY_ROW_INDEX
    jmp read_key

key_pressed:

    jsr PRINT_LIB.clean_screen


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


    //char = row * 8 + col
    // show table offset
    jsr PRINT_LIB.clean_location_screen
    locate_text(7,0,WHITE)
    print_text(table_offset_str)

    //calculate offset for table
    lda TABLE_KEY_ROW_INDEX
    asl
    asl
    asl  
    clc
    adc TABLE_KEY_COL_INDEX
    sta TABLE_KEY_ASCII_X //save offset value

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

    
    //print char
    //lda contains the char to show
    .break
    ldx TABLE_KEY_ASCII_X
    lda TABLE_KEY_ASCII,x
    sta SCREEN_CHAR
    locate_text(9,4,PINK)
    jsr PRINT_LIB.print_char  // print single char
    
    jmp read_key
    //rts
