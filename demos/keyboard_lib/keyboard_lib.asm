// Puerto A de salida
lda #$ff   
sta $DC02 // ---> $DC00

// Puerto B de entrada
lda #$00
sta $DC03 // ---> $DC01



read_key:

    //reset Y col Counter
    ldy #0
    sty TABLE_KEY_COL_INDEX

    //Count rows
    ldx TABLE_KEY_ROW_INDEX    // 0 to 7 count rows
    lda TABLE_KEY_BOARD_ROW,x  // get a row from table
    sta $DC00                  // and save it on port

    
        //get now KEY PRESSED . Reading COLS
        lda $DC01
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

    .break
    //lda TABLE_KEY_ROW_INDEX
    //lda TABLE_KEY_COL_INDEX
    jsr PRINT_LIB.clean_location_screen
    locate_text(8,0,WHITE)
    print_text(end_keyboard_str)

    /*jsr PRINT_LIB.clean_location_screen
    locate_text(5,0,WHITE)
    print_text(end_keyboard_str)*/

    //.break
    //jmp read_key
    rts