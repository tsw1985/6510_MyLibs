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
        jsr reset_bit_7_to_0_in_chars
        jsr print_cursor

    read_key:

        //jsr PRINT_LIB.clean_location_screen
        //locate_text(10,0,WHITE)
        //print_text(space_5_str)

        jsr scan_all_keys           // scan all keyboard matrix to get the
                                    // pressed keys and save them in the table
        
        jsr process_pressed_keys    // finally , process all keys to do the
                                    // target actions

        

        jsr clear_key_pressed_table // clear the table where are save the keys 
                                    // pressed before save the keys again

        jmp continue_read_key   // exit function

    // ***** Keep this check in last position ******
    continue_read_key:
        lda #0
        sta KEY_FLAGS
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
                jsr sleep_key          // sleep half second between keys presses

                // calculation of offset
                jsr calculate_offset_for_ascii_table

                /* Normal approach */
                // save the offset result in the table
                jsr save_key_pressed_in_table

               
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
        //jsr check_combo_keys    // First action is check the combinations keys
        

        pull_regs_from_stack()
    rts

    /*
        Function: 
            
            Set to 1 in the table PRESSED_KEY_TABLE . Each key have a offset
            value with the formula Offset = ( Rows x 8 ) + Cols. Because the
            keyboard have a matrix 8x8.
    */
    save_key_pressed_in_table:

        push_regs_to_stack()   
        ldy TABLE_KEY_ASCII_X_OFFSET  //load in Y the offset
        lda #1
        sta PRESSED_KEY_TABLE,y    // set a 1 in this offset position table
        pull_regs_from_stack()
        rts

    /* Function:
        Check if enter key is pressed
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
        /* COMBO : C= + CURSOR KEY ( move cursor to left) */
        ldx #47 // CMB OFFSET
        lda PRESSED_KEY_TABLE,x
        beq skip // A value is 0 ? skip


        ldx #16 //Cursor key
        lda PRESSED_KEY_TABLE,x
        beq skip // A value is 0 ? skip

        // If not skip , means CMB + Cursor is pressed, move to left cursor
        lda KEY_FLAGS
        ora #%00001000
        sta KEY_FLAGS
        
        // check single keys
        skip:

            // Only Cursor key. Must move to right
            ldx #16                   
            lda PRESSED_KEY_TABLE,x
            beq check_next_key_1
            lda KEY_FLAGS
            ora #%00000100            // set bit flag only cursor key is pressed
            sta KEY_FLAGS

            check_next_key_1:
            ldx #0             
            lda PRESSED_KEY_TABLE,x
            beq check_next_key_2
            lda KEY_FLAGS
            ora #%00010000            // set ON bit flag DELETE key is pressed
            sta KEY_FLAGS
            
            check_next_key_2:            
            

        continue_skip:
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
        jsr set_bit_7_to_1_in_char
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

        Debugging function to see the current index position
    */
    print_cursor_index_pos:
        
        push_regs_to_stack()
        jsr PRINT_LIB.clean_location_screen
        locate_text(6,0,WHITE)
        print_text(cursor_index_str)

        lda INPUT_INDEX_COUNTER
        sta div_res_0
        lda #0
        sta div_res_1
        sta div_res_2
        sta div_res_3
        // Print the result of calculation on screen
        print_calculation_result(6,10,YELLOW,div_res_0,div_res_1,div_res_2,div_res_3)
        pull_regs_from_stack()
    rts


    print_cursor_col_pos:
        
        push_regs_to_stack()
        jsr PRINT_LIB.clean_location_screen
        locate_text(7,0,WHITE)
        print_text(cursor_col_str)

        lda INPUT_CURSOR_COL
        sta div_res_0
        lda #0
        sta div_res_1
        sta div_res_2
        sta div_res_3
        // Print the result of calculation on screen
        print_calculation_result(7,8,YELLOW,div_res_0,div_res_1,div_res_2,div_res_3)
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

    decrement_current_cursor_of_screen:
        push_regs_to_stack()
        dec INPUT_CURSOR_COL
        pull_regs_from_stack()
        rts

    increment_current_cursor_of_screen:
        push_regs_to_stack()
        inc INPUT_CURSOR_COL
        pull_regs_from_stack()
        rts

    increment_input_index_counter:
        push_regs_to_stack()
        inc INPUT_INDEX_COUNTER
        pull_regs_from_stack()
        rts

    decrement_input_index_counter:
        push_regs_to_stack()
        dec INPUT_INDEX_COUNTER
        pull_regs_from_stack()
        rts

    move_cursor_to_left_on_string_screen:
        push_regs_to_stack()

        lda KEY_FLAGS
        ora #%10000000 // set bit show cursor on screen
        sta KEY_FLAGS


        dec INPUT_INDEX_COUNTER // decrement index of string to write the char
                                // on screen str


        lda INPUT_CURSOR_ROW
        sta SCREEN_ROW_POS

        lda INPUT_CURSOR_COL
        sta SCREEN_COL_POS

        //set coords on Screen
        ldx SCREEN_ROW_POS       // Row 22
        lda Row_LO,x
        sta ZERO_PAGE_ROW_LOW_BYTE
        lda Row_HI,x
        sta ZERO_PAGE_ROW_HIGHT_BYTE

        ldy SCREEN_COL_POS             // col 15
        lda (ZERO_PAGE_ROW_LOW_BYTE),y
        
        lda (ZERO_PAGE_ROW_LOW_BYTE),y
        clc
        adc #128
        sta (ZERO_PAGE_ROW_LOW_BYTE),y

        pull_regs_from_stack()
        rts

    move_cursor_to_right_on_string_screen:

        push_regs_to_stack()

        lda KEY_FLAGS
        ora #%10000000 // set bit show cursor on screen
        sta KEY_FLAGS

        lda INPUT_CURSOR_ROW
        sta SCREEN_ROW_POS

        lda INPUT_CURSOR_COL
        sta SCREEN_COL_POS

        // set coords on Screen
        ldx SCREEN_ROW_POS       // Row 22
        lda Row_LO,x
        sta ZERO_PAGE_ROW_LOW_BYTE
        lda Row_HI,x
        sta ZERO_PAGE_ROW_HIGHT_BYTE

        ldy SCREEN_COL_POS             // col 15
        lda (ZERO_PAGE_ROW_LOW_BYTE),y
        ora #%01111111
        sta (ZERO_PAGE_ROW_LOW_BYTE),y

        pull_regs_from_stack()
        rts

    restore_char_with_current_cursor:
        push_regs_to_stack()

        lda INPUT_CURSOR_ROW
        sta SCREEN_ROW_POS

        lda INPUT_CURSOR_COL
        sta SCREEN_COL_POS

        // set coords on Screen
        ldx SCREEN_ROW_POS       // Row 22
        lda Row_LO,x
        sta ZERO_PAGE_ROW_LOW_BYTE
        lda Row_HI,x
        sta ZERO_PAGE_ROW_HIGHT_BYTE

        ldy SCREEN_COL_POS             // col 15
        lda (ZERO_PAGE_ROW_LOW_BYTE),y

        and #%01111111
        sta (ZERO_PAGE_ROW_LOW_BYTE),y

        pull_regs_from_stack()
        rts

    remove_char_screen_str_by_key:

        push_regs_to_stack()

        lda INPUT_INDEX_COUNTER  // load current cursor position
        sta CHAR_INDEX_1      // set index1 with this value
        sta CHAR_INDEX_2      // set index2 with this value
        dec CHAR_INDEX_2      // decrement index2 by 1
        
        continue_swap:
            ldx CHAR_INDEX_1      // load offset X with index1
            ldy CHAR_INDEX_2      // load offset Y with index2
            lda KEYS_TO_SCREEN_STR,x  // swap chars ... 1 to 0 , 2 to 1 ... 3 to 2..
            sta KEYS_TO_SCREEN_STR,y

            inc CHAR_INDEX_1      // increment index to go to next char
            inc CHAR_INDEX_2      // increment index to go to next char

            lda INPUT_STR_LIMIT
            cmp CHAR_INDEX_2
            bne continue_swap

        pull_regs_from_stack()
    rts


    clean_str_screen:

        push_regs_to_stack()

        continue_cleaning:

        //set coords on Screen
        lda INPUT_CURSOR_ROW_CLS
        sta SCREEN_ROW_POS

        lda INPUT_CURSOR_COL_CLS
        sta SCREEN_COL_POS

        ldx SCREEN_ROW_POS       // Row 22
        lda Row_LO,x
        sta ZERO_PAGE_ROW_LOW_BYTE
        lda Row_HI,x
        sta ZERO_PAGE_ROW_HIGHT_BYTE

        ldy SCREEN_COL_POS             // col 15
        lda #96                // char E
        sta (ZERO_PAGE_ROW_LOW_BYTE),y

        inc INPUT_CURSOR_COL_CLS
        lda INPUT_STR_LIMIT_CLS
        cmp INPUT_CURSOR_COL_CLS
        bne continue_cleaning


        pull_regs_from_stack()
        rts

    reset_bit_7_to_0_in_chars:

        push_regs_to_stack()

        // coor Y for input row
        lda SCREEN_INPUT_ROW_POS
        sta INPUT_CURSOR_ROW_CLS

        // coor X for input col
        lda SCREEN_INPUT_COL_POS
        sta INPUT_CURSOR_COL_CLS

        ldy INPUT_CURSOR_COL_CLS

        //set coords on Screen
        lda INPUT_CURSOR_ROW_CLS
        sta SCREEN_ROW_POS

        lda INPUT_CURSOR_COL_CLS
        sta SCREEN_COL_POS

        ldx SCREEN_ROW_POS       // Row 22
        lda Row_LO,x
        sta ZERO_PAGE_ROW_LOW_BYTE
        lda Row_HI,x
        sta ZERO_PAGE_ROW_HIGHT_BYTE

        continue_reset:
            ldy INPUT_CURSOR_COL_CLS             // col 15
            lda (ZERO_PAGE_ROW_LOW_BYTE),y
            and #%01111111
            sta (ZERO_PAGE_ROW_LOW_BYTE),y
            inc INPUT_CURSOR_COL_CLS
            lda INPUT_STR_LIMIT_CLS
            cmp INPUT_CURSOR_COL_CLS
        bne continue_reset

        pull_regs_from_stack()
        rts

    set_bit_7_to_1_in_char:

        push_regs_to_stack()

        //set coords on Screen
        lda INPUT_CURSOR_ROW_CLS
        sta SCREEN_ROW_POS

        lda INPUT_CURSOR_COL_CLS
        sta SCREEN_COL_POS

        ldx SCREEN_ROW_POS       // Row 22
        lda Row_LO,x
        sta ZERO_PAGE_ROW_LOW_BYTE
        lda Row_HI,x
        sta ZERO_PAGE_ROW_HIGHT_BYTE

        ldy INPUT_CURSOR_COL             // col 15
        lda (ZERO_PAGE_ROW_LOW_BYTE),y
        //and #%01111111
        ora #%10000000
        sta (ZERO_PAGE_ROW_LOW_BYTE),y
        
        pull_regs_from_stack()
        rts

}
