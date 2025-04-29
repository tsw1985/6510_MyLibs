read_key:

    //reset Y col Counter

    .break

    //Count rows
    ldx TABLE_KEY_ROW_INDEX    // 0 to 7 count rows
    lda TABLE_KEY_BOARD_ROW,x  // get a row from table
    sta $DC01                  // and save it on port


        




                            // read again 
    inc TABLE_KEY_ROW_INDEX // next row on table ...
    lda TABLE_KEY_ROW_INDEX //
    cmp #7                  // if ROW index is 7 
    beq reset_key_row_index // reset to 0
    jmp read_key            // and go to read all again

reset_key_row_index:

    lda #0
    sta TABLE_KEY_ROW_INDEX
    jmp read_key
    //rts


/*
key_pressed:

    //get the key from 8x8 table keys
    //save the key on other KEY_PRESSED_LIST
    .break
    lda TABLE_KEY_ROW_INDEX
    lda TABLE_KEY_COL_INDEX
    rts    */

//print text 4
/*
jsr PRINT_LIB.clean_location_screen
locate_text(5,0,WHITE)
print_text(end_keyboard_str)    
*/


