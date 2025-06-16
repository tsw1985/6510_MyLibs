INPUT_LIB:
{

#import "input_macros/input_lib_macros.asm"

/* Function:

    This is a input function. The user write and when the user press enter
    the returned value is the variable "KEYS_TO_SCREEN_STR" .

*/

input_keyboard:

    push_regs_to_stack()

    /* Reset INPUT_INDEX_COUNTER Index counter cursor */
    lda #0
    sta INPUT_INDEX_COUNTER

    /*Save original values*/
    lda $DC02
    sta ORIGINAL_DC_02
    
    lda $DC03  
    sta ORIGINAL_DC_03

    // Port A = enter
    lda #$00
    sta $DC02 //; ---> $DC00

    // Port B = exit
    lda #$ff
    sta $DC03 //; ---> $DC01

    /* init timer for cursor blinking */
    jsr init_irq_timer

    /* print init cursor in selected position */
    jsr print_cursor

    /* reset screem str  Fill spaces */ 
    jsr reset_screen_str

    /* reset key flags */
    jsr reset_key_flags

    /* reset table key pressed */
    jsr clear_key_pressed_table         

    /* Init read keys loop */
    jsr read_key

    pull_regs_from_stack()
rts

read_key:

    push_regs_to_stack()
    init_reading:


    /* 
       scan all keyboard matrix to get the
       pressed keys and save them in the table
    */
    jsr scan_all_keys

    /* 
       When the table of all keys pressed is filled , we read each position. If
       a position match with a special offset, this means this can be a LEFT ,
       RIGHT, DELETE or ENTER.
       
       Here is set the bits of KEY_FLAGS for the execute the target actions
    */
    jsr detect_specials_keys_and_set_actions_flags
    
    /* Check if bit ENTER is enabled to exit.
       Do NOT MOVE this code. Must be here because the last function set the
       KEY_FLAGS if the enter key was pressed.
     */
    lda KEY_FLAGS
    and #%00000010
    bne finish_reading_keys
    
    /* execute key actions (left, right,del ...) */
    jsr execute_actions_key

    /* detect if last position of SCREEN STRING if empty. If it is empty, we
    allow scan and write keys */
    ldy INPUT_STR_LIMIT
    dey
    lda KEYS_TO_SCREEN_STR,y
    cmp #96
    bne skip_print_string_and_cursor

    /* add key pressed to screen string */
    jsr add_scanned_keys_to_screen_str

    

    /* 
        To avoid a screen flikering, we check if the bit 5 is enable . This bit
        is set to 1 if the user press a new normal key and the SCREEN_STR is
        updated, then , print the string updated.

        This bit is set to 1 in function "add_scanend_keys_to_screen_str"
    */
    lda KEY_FLAGS
    and #%00100000
    beq skip_print_string_and_cursor

    jsr block_because_is_printing
        /* print main string on screen */
        jsr print_keys_pressed
    jsr unblock_because_is_not_printing

    jsr block_because_is_printing
        /* print cursor */
        jsr print_cursor
    jsr unblock_because_is_not_printing


    /***********************/
    /* Only for  debugging */
    /***********************/
    jsr print_debug_params
  
    
    skip_print_string_and_cursor:

    /* clear the table where are save the keys pressed before save the keys 
       again */
    jsr clear_key_pressed_table 

    /* reset the flags to next iteration */
    jsr reset_key_flags         
    jmp init_reading                    // read keyboard again

    finish_reading_keys:

    /* when the enter key is pressed, we finish the execution, so we need
    reset the KEY_FLAGS and reset the pressed key table */
    jsr clear_key_pressed_table         
    jsr reset_key_flags
    jsr destroy_irq_timer



    /* this insert a 0 in the limit of string, to avoid print garbage in the
    return string */
    jsr insert_end_line_in_screen_str


    // RESTAURAR al final
    lda ORIGINAL_DC_02
    sta $DC02
    lda ORIGINAL_DC_03
    sta $DC03

    pull_regs_from_stack()
rts

block_because_is_printing:
    push_regs_to_stack()
    lda #1
    sta PRINTING_FLAG
    pull_regs_from_stack()
rts

unblock_because_is_not_printing:
    push_regs_to_stack()
    lda #0
    sta PRINTING_FLAG
    pull_regs_from_stack()
rts


print_debug_params:
    push_regs_to_stack()
    // debug: print offset result

    jsr block_because_is_printing
        jsr print_offset_result
    jsr unblock_because_is_not_printing

    // debug : show current pressed char
    jsr block_because_is_printing
        jsr print_current_pressed_char
    jsr unblock_because_is_not_printing

    // debug : // see X row value of keyboard
    jsr block_because_is_printing
        jsr print_x_coord
    jsr unblock_because_is_not_printing

    // debug : // see Y row value of keyboard
    jsr block_because_is_printing
        jsr print_y_coord
    jsr unblock_because_is_not_printing

    // debug : print current index position
    jsr block_because_is_printing
        jsr print_cursor_index_pos
    jsr unblock_because_is_not_printing

    // debug : print current col position
    jsr block_because_is_printing
        jsr print_cursor_col_pos
    jsr unblock_because_is_not_printing

    pull_regs_from_stack()
rts

reset_key_flags:
    push_regs_to_stack()
    lda #0
    sta KEY_FLAGS
    pull_regs_from_stack()
rts


execute_actions_key:

    push_regs_to_stack()

    /* MOVE CURSOR TO LEFT */
    lda KEY_FLAGS
    and #%00001000
    bne cursor_to_left

    /* MOVE CURSOR TO RIGHT */
    lda KEY_FLAGS
    and #%00000100            // set bit flag only cursor key is pressed
    bne cursor_to_right

    /* DELETE MOVE CURSOR TO RIGHT */
    lda KEY_FLAGS
    and #%00010000            // set bit flag only DELETE key is pressed
    bne delete_key
    
    /* if is not set any action, exit of function */
    jmp exit_actions

    cursor_to_left:
        /* Check limit to left. INPUT_CURSOR_COL 
        must be >= SCREEN_INPUT_COL_POS */
        lda SCREEN_INPUT_COL_POS  // LOAD LIMIT TO LEFT
        cmp INPUT_CURSOR_COL      // Compare current cursor index
        beq exit_actions          // if equal to limit , ignore
        bcs allow_move_to_left    // if not, move to left
        allow_move_to_left:
            jsr restore_char_with_current_cursor
            jsr decrement_current_cursor_of_screen
            jsr move_cursor_to_left_on_string_screen
            jmp exit_actions  // exit function

    cursor_to_right:
            /* check cursor limit to right */
            lda INPUT_STR_LIMIT      // LOAD LIMIT TO RIGHT
            cmp INPUT_INDEX_COUNTER  // Compare current cursor index
            beq exit_actions    // if equal to limit , ignore

            jsr restore_char_with_current_cursor
            jsr increment_current_cursor_of_screen
            jsr move_cursor_to_right_on_string_screen
            jmp exit_actions   // exit function

    delete_key:
        /* Check limit to left. INPUT_CURSOR_COL 
        must be >= SCREEN_INPUT_COL_POS */
        lda SCREEN_INPUT_COL_POS  // LOAD LIMIT TO LEFT
        cmp INPUT_CURSOR_COL      // Compare current cursor index
        beq exit_actions     // if equal to limit , ignore
        bcs allow_delete_to_left    // if not, move to left
        allow_delete_to_left:

            jsr remove_char_screen_str_by_key
            
            jsr block_because_is_printing
                jsr print_keys_pressed
            jsr unblock_because_is_not_printing
            jsr restore_char_with_current_cursor
            jsr decrement_current_cursor_of_screen
            jsr move_cursor_to_left_on_string_screen
            jmp exit_actions   // exit function

    exit_actions:
    pull_regs_from_stack()
rts


/* Function:
    
    This function scan the keyboard matrix and save all matchs
*/
scan_all_keys:
    
    push_regs_to_stack()
    ldx #0
    scan_rows_loop:

        lda TABLE_KEY_BOARD_ROW,x   // get keyboard row to explore
        cli
        sta $DC01                   // and set it on PORT B

        lda $DC00                   // get keyboard col to explore if some
        
                                    // key is pressed
        eor #%11111111              // invert values of rows cols ( 0 to 1)
        sta KEY_PRESSED             // save the inverted value on A
                                    // once we have the result of the pressed
        sei                            // keys, we go to retrieve the COL ROW
                                    // table

        ldy #0                    // we start to retrieve all cols ( 0 to 7)
        scan_cols_loop:

            lda KEY_PRESSED        //load current key pressed ( bits with 1)
            and TABLE_KEY_BOARD_COL,y  // match some bit with some col row?
            beq no_key_detected     // if does not match, continue with next
                                 // column 

            // if some bit match, we calculate his offter and we save it in
            // the table : "current keys pressed"
            jsr sleep_key             // sleep half second between keys presses

            // calculation of offset
            jsr calculate_offset_for_ascii_table

            /* Normal approach */
            // save the offset result in the table
            jsr save_key_pressed

            //jsr sleep_key

        no_key_detected:


            iny                // increment Y ( columns )
            cpy #8             // 8 cols ?
            bne scan_cols_loop // if not , continue retrieving cols

            inx                // increment X ( rows)
            cpx #8             // are 8 rows ???
            bne scan_rows_loop // not ?? continue retrieving rows

    pull_regs_from_stack()
rts   // finish function


/* Main function :
    
    This is the main function. This means, once all keys were pressed, we
    need launch the custom actions on each combination.

*/
detect_specials_keys_and_set_actions_flags:
    
    push_regs_to_stack()
    /* COMBO : C= + CURSOR KEY ( move cursor to left) */
    ldx #47                // CMB OFFSET
    lda PRESSED_KEY_TABLE,x
    beq skip               // A value is 0 ? skip

    ldx #16 //Cursor key
    lda PRESSED_KEY_TABLE,x
    beq skip // A value is 0 ? skip

    // If not skip , means CMB + Cursor is pressed, move to left cursor
    lda KEY_FLAGS
    ora #%00001000
    sta KEY_FLAGS
    
    // check single keys
    skip:

        /* Detect only cursor to right */
        ldx #16                   
        lda PRESSED_KEY_TABLE,x
        beq check_if_is_delete_key
        lda KEY_FLAGS
        ora #%00000100            // set bit flag only cursor key is pressed
        sta KEY_FLAGS
        jmp exit_set_flags

        /* Detect if is Delete key */
        check_if_is_delete_key:
        ldx #0             
        lda PRESSED_KEY_TABLE,x
        beq check_if_is_enter_key
        lda KEY_FLAGS
        ora #%00010000            // set ON bit flag DELETE key is pressed
        sta KEY_FLAGS
        jmp exit_set_flags
        
        check_if_is_enter_key:
        ldx #8                   // KEY ENTER
        lda PRESSED_KEY_TABLE,x
        beq exit_set_flags
        lda KEY_FLAGS
        ora #%00000010
        sta KEY_FLAGS
        jmp exit_set_flags


    exit_set_flags:
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

/* 
    Function:
        This is a function for debugging, to see the offset value of each
        key press . Must be commented. Remember we have 38911 bytes :( 
*/
print_offset_result:

    push_regs_to_stack()
    insert_text(4,0,calc_offset_str,WHITE)

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
    ldx #130
    outer_loop:
        ldy #130
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

    /* set coords col and row */
    sei
    lda INPUT_CURSOR_ROW
    sta SCREEN_ROW_POS

    lda INPUT_CURSOR_COL
    sta SCREEN_COL_POS
    cli

    //set coords on Screen
    sei
    ldx SCREEN_ROW_POS       // Row 22
    lda Row_LO,x
    sta ZERO_PAGE_ROW_LOW_BYTE
    lda Row_HI,x
    sta ZERO_PAGE_ROW_HIGHT_BYTE
    cli

    ldy SCREEN_COL_POS             // col 15
    lda SCREEN_CHAR                // char " "
    lda (ZERO_PAGE_ROW_LOW_BYTE),y // get the char and invert his color
    ora #%10000000                 // to invert we need set the bit 7 to 0
    sta (ZERO_PAGE_ROW_LOW_BYTE),y // save the bit inverted

    pull_regs_from_stack()
    rts


/* Function:

        This is a debuggin function . To know the X value of the keyboard
        matrix.
*/
print_x_coord:

    push_regs_to_stack()
    insert_text(2,0,coor_x_str,WHITE)

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
    insert_text(3,0,coor_y_str,WHITE)

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
print_cursor_pos:
    
    push_regs_to_stack()
    insert_text(6,0,cursor_index_str,WHITE)

    lda INPUT_CURSOR_COL
    sta div_res_0
    lda #0
    sta div_res_1
    sta div_res_2
    sta div_res_3
    // Print the result of calculation on screen
    print_calculation_result(6,8,YELLOW,div_res_0,div_res_1,div_res_2,div_res_3)
    pull_regs_from_stack()
rts


/* Function:

    Debugging function to see the current pressed key
*/
print_current_pressed_char:

    push_regs_to_stack()
    insert_text(5,0,current_char_str,WHITE)


    ldx TABLE_KEY_ASCII_X_OFFSET
    lda TABLE_KEY_ASCII,x
    sta SCREEN_CHAR
    locate_text(5,5,YELLOW)
    jsr PRINT_LIB.print_char  // print single char

    pull_regs_from_stack()
    rts

/* Function:

    Debugging function to see the current index position
*/
print_cursor_index_pos:

    push_regs_to_stack()
    insert_text(6,0,cursor_index_str,WHITE)

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

/* Function:

    Debugging function to see the current col position
*/
print_cursor_col_pos:

    push_regs_to_stack()
    insert_text(7,0,cursor_col_str,WHITE)

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

/*
    Function:

        Save pressed key on string KEYS_TO_STRING_STR. This is the string
        that will appear on the screen.

*/
add_scanned_keys_to_screen_str:

    push_regs_to_stack()

    /* if enter was pressed, then set action ENTER to finish the rutine */
    ldx #8
    lda PRESSED_KEY_TABLE,x      // start processing
    /* if enter ( #8 offset ) is 1 , this means ENTER KEY WAS PRESSED , then
    we must set the flag and exit */
    beq init_scan_keys           // if is 1 , process
    lda KEY_FLAGS   
    ora #%00000010  // set the flag
    sta KEY_FLAGS
    jmp finish_scan // exit function

    init_scan_keys:

    ldy #0
    /* retrieve the PRESSED_KEY_TABLE searching the values with 1 . Y will
    contains the offset number, this will be the char to search it in the
    table TABLE_KEY_ASCII */
    continue_check_pressed_table:

        /* We need to check if the str is not on length limit */
        /* check if string is <= str_length */
        lda INPUT_STR_LIMIT            // LOAD LIMIT TO RIGHT
        cmp INPUT_INDEX_COUNTER        // Compare current cursor index
        beq not_add_key_to_screen_str  // if equal to limit , ignore

        lda PRESSED_KEY_TABLE,y          // start processing
        bne process_key                  // if is 1 , process
        jmp not_add_key_to_screen_str    // if is 0 , skip

        /* if is 1 ... */
        process_key:

            /* Ignore special keys. We want do not print them*/
            cpy #0 /* delete key */
            beq not_add_key_to_screen_str

            cpy #47 /* C= key */
            beq not_add_key_to_screen_str

            cpy #16 /*cursor key */
            beq not_add_key_to_screen_str

            /* rotate chars . This is to insert chars in the middle 
            of the string */
            jsr rotate_right_str_string

            /* Enable bit 5 = SCREEN_STR Updated */
            lda KEY_FLAGS
            ora #%00100000
            sta KEY_FLAGS

            /* Process normal table */
            lda TABLE_KEY_ASCII,y     // get the ascii code from chars table
            sta SCREEN_CHAR           // save the char on SCREEN_CHAR
            ldx INPUT_INDEX_COUNTER
            sta KEYS_TO_SCREEN_STR,x  // in y is the index. the limit is 80

            jsr increment_index_cursor_index
            jsr increment_current_cursor_of_screen

        not_add_key_to_screen_str:
        iny
        cpy #62
        bne continue_check_pressed_table

    finish_scan:
    pull_regs_from_stack()
rts

/*
    Function:
        
        Print current text pressing the keys

*/
print_keys_pressed:

    push_regs_to_stack()
    jsr PRINT_LIB.clean_location_screen
    
    /* Get the coords.This coords were set in the macro "insert_input" */
    sei
    lda SCREEN_INPUT_ROW_POS
    sta SCREEN_ROW_POS
    
    lda SCREEN_INPUT_COL_POS
    sta SCREEN_COL_POS
    
    lda SCREEN_INPUT_COLOR
    sta SCREEN_CHAR_COLOR
    cli

    print_input_text(KEYS_TO_SCREEN_STR)
    pull_regs_from_stack()
    rts

decrement_current_cursor_of_screen:
    push_regs_to_stack()
    sei
    dec INPUT_CURSOR_COL
    cli
    pull_regs_from_stack()
    rts

increment_current_cursor_of_screen:
    push_regs_to_stack()
    sei
    inc INPUT_CURSOR_COL
    cli
    pull_regs_from_stack()
    rts

increment_index_cursor_index:
    push_regs_to_stack()
    sei
    inc INPUT_INDEX_COUNTER
    cli
    pull_regs_from_stack()
rts

decrement_index_cursor_index:
    push_regs_to_stack()
    sei
    dec INPUT_INDEX_COUNTER
    cli
    pull_regs_from_stack()
rts


move_cursor_to_left_on_string_screen:
    push_regs_to_stack()

    lda KEY_FLAGS
    ora #%10000000 // set bit show cursor on screen
    sta KEY_FLAGS

    jsr decrement_index_cursor_index // decrement index of string to write the 
                                     // char on screen str


    /* The variables SCREEN_ROW_POS and SCREEN_ROW_COL are IMPORTANT . Those are
       the variables to get the position of ROW and COL in the SCREEN TABLE */
    sei
    lda INPUT_CURSOR_ROW
    sta SCREEN_ROW_POS

    lda INPUT_CURSOR_COL
    sta SCREEN_COL_POS
    cli

    //set coords on Screen
    sei
    ldx SCREEN_ROW_POS       // Row 22
    lda Row_LO,x
    sta ZERO_PAGE_ROW_LOW_BYTE
    lda Row_HI,x
    sta ZERO_PAGE_ROW_HIGHT_BYTE
    cli

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

    jsr increment_index_cursor_index

    sei
    lda INPUT_CURSOR_ROW
    sta SCREEN_ROW_POS

    lda INPUT_CURSOR_COL
    sta SCREEN_COL_POS
    cli

    //set coords on Screen
    sei
    ldx SCREEN_ROW_POS       // Row 22
    lda Row_LO,x
    sta ZERO_PAGE_ROW_LOW_BYTE
    lda Row_HI,x
    sta ZERO_PAGE_ROW_HIGHT_BYTE
    cli

    ldy SCREEN_COL_POS             // col 15
    lda (ZERO_PAGE_ROW_LOW_BYTE),y
    
    lda (ZERO_PAGE_ROW_LOW_BYTE),y
    clc
    adc #128
    sta (ZERO_PAGE_ROW_LOW_BYTE),y

    pull_regs_from_stack()
    rts

restore_char_with_current_cursor:
    push_regs_to_stack()

    sei
    lda INPUT_CURSOR_ROW
    sta SCREEN_ROW_POS

    lda INPUT_CURSOR_COL
    sta SCREEN_COL_POS
    cli

    // set coords on Screen
    sei
    ldx SCREEN_ROW_POS       // Row 22
    lda Row_LO,x
    sta ZERO_PAGE_ROW_LOW_BYTE
    lda Row_HI,x
    sta ZERO_PAGE_ROW_HIGHT_BYTE
    cli

    ldy SCREEN_COL_POS             // col 15
    lda (ZERO_PAGE_ROW_LOW_BYTE),y

    and #%01111111
    sta (ZERO_PAGE_ROW_LOW_BYTE),y

    pull_regs_from_stack()
    rts

remove_char_screen_str_by_key:
    push_regs_to_stack()

    lda INPUT_INDEX_COUNTER       // load current cursor position
    sta CHAR_INDEX_1              // set index1 with this value
    sta CHAR_INDEX_2              // set index2 with this value
    dec CHAR_INDEX_2              // decrement index2 by 1
    
    continue_swap:
        ldx CHAR_INDEX_1          // load offset X with index1
        ldy CHAR_INDEX_2          // load offset Y with index2
        lda KEYS_TO_SCREEN_STR,x  // swap chars ... 1 to 0 , 2 to 1 ... 3 to 2..
        sta KEYS_TO_SCREEN_STR,y

        inc CHAR_INDEX_1          // increment index to go to next char
        inc CHAR_INDEX_2          // increment index to go to next char

        lda INPUT_STR_LIMIT
        cmp CHAR_INDEX_2
        bne continue_swap

    pull_regs_from_stack()
rts

rotate_right_str_string:

    push_regs_to_stack()

    /* Load Y with string LENGTH */
    ldy INPUT_STR_LIMIT      

    /* load A with STR LIMIT */
    lda INPUT_STR_LIMIT
    sta ROTATE_INDEX  // save the LENGTH value in ROTATE_INDEX
    dec ROTATE_INDEX  // substract -1 to lenght
    lda ROTATE_INDEX  // load in A this new value
    sta ROTATE_INDEX  // save this this new updated value to ROTATE_INDEX
                      // ( last char )

    dey               // Y = decrement Y ( last valid index ) remember the
                      // system start from 0 ... So , if the LENGTH is 10 , we
                      // must start by 9.
    
continue_rotation:

    cpy INPUT_INDEX_COUNTER // check if Y is in cursor
    beq end_rotate          //  Y == It is Y in cursor position ?
    bcc end_rotate          // it is Y < cursor ?
    
    /* Decrement ROTATE_INDEX */
    dec ROTATE_INDEX

    /* load X with this new value */
    ldx ROTATE_INDEX
    
    /* Rotate chars 1 position to right */
    lda KEYS_TO_SCREEN_STR,x   // Load backward char
    sta KEYS_TO_SCREEN_STR,y   // and save it in current position of Y
    
    dey                        // Decrement Y to go to next position
    jmp continue_rotation

end_rotate:
    pull_regs_from_stack()
rts


reset_screen_str:
    push_regs_to_stack()

    lda #96 // empty space
    ldx #0
    continue_reset_screen:
        sta KEYS_TO_SCREEN_STR,x
        inx
        cpx #80
        bne continue_reset_screen

    pull_regs_from_stack()
    rts

init_irq_timer:

    push_regs_to_stack()
    sei  // stop interruptions

    /* SAVE ORIGINAL VECTOR. 
    When the rutine is finished , we must kill the timer and restore the old
    vector address
    */
    lda $0314
    sta OLD_IRQ_LOW
    lda $0315  
    sta OLD_IRQ_HIGH

    // Set up address of our code to execute
    lda #<blink_cursor       // LOW byte function
    sta $0314                // Set where is the low byte
    lda #>blink_cursor       // HI Byte function
    sta $0315                // Set where is the hight byte

    // Count from 12500 to 0 +z0.5 sec
    lda #<12500             // Low byte value
    sta $DC04               // Timer A Low
    lda #>12500             // Hight byte value
    sta $DC05               // Timer A High
    
    // Enable IRQ Timer
    lda #%10000001          // Bit 7=1 (set), Bit 0=1 (Timer A)
    sta $DC0D               // CIA1 Interrupt Control
    
    // Star IRQ Timer loop mode . When is 0 , it start again
    lda #%00000001          // Start Timer A, continuous
    sta $DC0E               // CIA1 Control Register A

    cli  // restore interruptions

    pull_regs_from_stack()
    rts


blink_cursor:
    push_regs_to_stack()
    
    /* We need read the CIA1 ICR to clean the flags . Also we can ask wich INT
    was launched */
    lda $DC0D 

    /* The system is printing text ???? */
    lda PRINTING_FLAG
    bne irq_timer_exit   // If it is busy, ignore interruption code
    
    /* Each 0,5 second this code is executed , so , in each iteration , we 
    increment the IRQ COUNTER , if it is not 60 , we execute the code*/
    inc IRQ_COUNTER
    lda IRQ_COUNTER
    cmp #60              // +- 2 seconds   
    bne irq_timer_exit
    
    /* If we execute the code, first step is reset the counter */
    lda #0
    sta IRQ_COUNTER
    
    /* Toggle cursor state */
    lda CURSOR_STATE        // Toggle the bit . 1 to 0 , 0 to 1 ....
    eor #1                  // toggle the bit
    sta CURSOR_STATE        // Save the new toggle state
    beq cursor_off          // if Z flag is 0,turn off the cursor,if not,turn on
    
cursor_on:
    jsr block_because_is_printing
        jsr enable_current_cursor
    jsr unblock_because_is_not_printing
    jmp irq_timer_exit
    
cursor_off:
    jsr block_because_is_printing
        jsr disable_current_cursor
    jsr unblock_because_is_not_printing
    
irq_timer_exit:
    pull_regs_from_stack()
    jmp $EA31 // finish IRQ function. 
    /* do not use RTI . The JMP $EA31 is the best approach to return from a 
    interrupt function . With RTI the system CRASH if we want return to basic */
    //rti


destroy_irq_timer:
    push_regs_to_stack()
    sei                     // Disable interruptions
    
    // Stop timer
    lda #%00000000          // Stop Timer A
    sta $DC0E               // CIA1 Control Register A
    
    // Disable IRQ Timer A
    lda #%01111111          // Bit 7=0 (clear), rest to 1 
    sta $DC0D               // Disable the IRQ on CIA1
    
    // Restore IRQ OLD Address vector
    lda OLD_IRQ_LOW         // Low address
    sta $0314
    lda OLD_IRQ_HIGH        // High address vector
    sta $0315
    
    cli                     // Restore interruptions
    pull_regs_from_stack()
rts    


disable_current_cursor:
    push_regs_to_stack()

    sei
    lda INPUT_CURSOR_ROW
    sta SCREEN_ROW_POS

    lda INPUT_CURSOR_COL
    sta SCREEN_COL_POS
    cli

    // set coords on Screen
    sei
    ldx SCREEN_ROW_POS       // Row 22
    lda Row_LO,x
    sta ZERO_PAGE_ROW_LOW_BYTE
    lda Row_HI,x
    sta ZERO_PAGE_ROW_HIGHT_BYTE
    cli

    ldy SCREEN_COL_POS             // col 15
    lda (ZERO_PAGE_ROW_LOW_BYTE),y
    and #%01111111
    sta (ZERO_PAGE_ROW_LOW_BYTE),y

    pull_regs_from_stack()
    rts

enable_current_cursor:
    push_regs_to_stack()

    sei
    lda INPUT_CURSOR_ROW
    sta SCREEN_ROW_POS

    lda INPUT_CURSOR_COL
    sta SCREEN_COL_POS
    cli

    // set coords on Screen
    sei
    ldx SCREEN_ROW_POS       // Row 22
    lda Row_LO,x
    sta ZERO_PAGE_ROW_LOW_BYTE
    lda Row_HI,x
    sta ZERO_PAGE_ROW_HIGHT_BYTE
    cli

    ldy SCREEN_COL_POS             // col 15
    lda (ZERO_PAGE_ROW_LOW_BYTE),y
    ora #%10000000
    sta (ZERO_PAGE_ROW_LOW_BYTE),y

    pull_regs_from_stack()
    rts


insert_end_line_in_screen_str:
    push_regs_to_stack()
    ldy INPUT_STR_LIMIT
    lda #0
    sta KEYS_TO_SCREEN_STR,y
    pull_regs_from_stack()
rts



}
