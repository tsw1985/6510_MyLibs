INPUT_LIB:
{

    #import "input_macros/input_lib_macros.asm"

    input_keyboard:

        // Port A = enter
        lda #$00
        sta $DC02 //; ---> $DC00

        // Port B = exit
        lda #$ff
        sta $DC03 //; ---> $DC01


        jsr print_cursor


    read_key:

        jsr clear_key_pressed_table // clear the table where are save the keys 
                                    // pressed before save the keys again
        
        jsr scan_all_keys           // scan all keyboard matrix to get the
                                    // pressed keys and save them in the table
        
        jsr process_pressed_keys    // finally , process all keys to do the
                                    // target actions
        
        jsr sleep_key               // sleep half second between keys presses
    
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

                // do the calculation ...
                jsr calculate_offset_for_ascii_table

                // save the offset result in the table
                jsr save_key_pressed

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

    check_combo_keys:

        push_regs_to_stack()

        ldx #47  //CMB OFFSET !! not value
        lda PRESSED_KEY_TABLE,x
        beq skip // A value is 0 ? skip

        ldx #16 //Cursor key
        lda PRESSED_KEY_TABLE,x
        beq skip // A value is 0 ? skip

        // If not skip , means CMB + Cursor is pressed, move to left cursor
        .break
        pull_regs_from_stack()
        rts

        skip:
            //ldx #16 //check again cursor key . Here is only cursor key
            //lda PRESSED_KEY_TABLE,x
            //bne is_only_cursor_key // A value is == 1 ?
            pull_regs_from_stack()
        rts
        
    

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

    sleep_key:

        push_regs_to_stack()
        ldx #120
        outer_loop:
            ldy #120
        inner_loop:
            nop
            dey
            bne inner_loop
            dex
            bne outer_loop
            
            pull_regs_from_stack()
            rts

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

    calculate_offset_for_ascii_table:

        // offset = (row * 8 ) + col
        push_regs_to_stack()

        txa
        asl   // x 2
        asl   // x 4
        asl   // x 8
        sta temp_offset // save 
        tya
        clc
        adc temp_offset // add y, where is the col value
        sta TABLE_KEY_ASCII_X_OFFSET  //save it here

        pull_regs_from_stack()

        rts

}
