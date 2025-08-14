#import "print_macros/print_lib_macros.asm"

PRINT_LIB:
{

    /* Function to clean screen. Call a KERNAL function */
    clean_screen:
        push_regs_to_stack()
        jsr $e544 //clear screen
        pull_regs_from_stack()
        rts


    /*
        Def   : clean ROW - COL coords . This function clean the char, row and
                col variables.
        Input : none
    */
    clean_location_screen:    

        push_regs_to_stack()

        lda #0
        sta SCREEN_CHAR_INDEX
        sta SCREEN_ROW_POS
        sta SCREEN_COL_POS             // col 15

        pull_regs_from_stack()
        rts

    /*
        Def   : print text
        Input : load the pointer in ZERO_PAGE_PRINT_TEXT_LO 
    */
    print_text:

        push_regs_to_stack()

        ldy #0


        /* This function read the value in in ZP. If this found a 0, this mean
           end screen */
        continue_writing:
            lda (ZERO_PAGE_PRINT_TEXT_LO),y
            beq end_writing    // if found the 0 , this means end string
            sta SCREEN_CHAR    // load char to show in screen calling print_char
            jsr print_char
            iny
            inc SCREEN_COL_POS
            jmp continue_writing

        end_writing:
        pull_regs_from_stack()
        rts    

    /*
        Function:
            
           Print the text of the input . We must print until the value ( lenght)
           of INPUT_STR_LIMIT
    */
    print_input_text:

        push_regs_to_stack()

        ldy #0
        continue_input_writing:
            lda (ZERO_PAGE_PRINT_TEXT_LO),y
            sta SCREEN_CHAR    //load char to show
            jsr print_char
            /* increment SCREEN_COL_POS */
            //inc SCREEN_COL_POS
            lda SCREEN_COL_POS
            clc
            adc #1
            sta SCREEN_COL_POS

            iny
            cpy INPUT_STR_LIMIT
        bne continue_input_writing

        pull_regs_from_stack()
        rts



    /*
        Def   : print a char on a custom ROW - COL
        Input : SCREEN_ROW_POS ( X position)
                SCREEN_COL_POS ( Y position)
                SCREEN_CHAR ( char to show )

        The coords are in the variables SCREEN_ROW_POS . To get the memory
        position of the screen , we use a system. Exists a table in /tables
        called screen_table.asm .
        
        There are 2 variables Row_LO and Row_HI . Here we calc the start byte
        of a ROW in the screen . This is calculated using the formula:

            SCREEN_RAM + ( SCREEN_WIDTH * row_number) .

            Then we get the HIGHT byte and LOW_BYTE of this address and we save
            this values in the ZERO PAGE. We create a pointer. Finally we use
            the Y register to access to the column and we save the value ( char) 
            to print in the ZERO_PAGE_ROW_LOW_BYTE:

            sta (ZERO_PAGE_ROW_LOW_BYTE),y

            See the ZP values of the project.
    */
    print_char:    

        push_regs_to_stack()

        // Set color on color ram
        ldx SCREEN_ROW_POS       
        lda Row_Color_LO,x
        sta ZERO_PAGE_ROW_COLOR_LOW_BYTE

        lda Row_Color_HI,x
        sta ZERO_PAGE_ROW_COLOR_HIGHT_BYTE

        ldy SCREEN_COL_POS             
        lda SCREEN_CHAR_COLOR
        sta (ZERO_PAGE_ROW_COLOR_LOW_BYTE),y

        /* Set char in row - col */
        ldx SCREEN_ROW_POS
        lda Row_LO,x                 // example: $5020 => $20
        sta ZERO_PAGE_ROW_LOW_BYTE   // save $20
        lda Row_HI,x                 // example: $5020 => $50
        sta ZERO_PAGE_ROW_HIGHT_BYTE // save $50

        ldy SCREEN_COL_POS             // col = 15 
        lda SCREEN_CHAR                // char E
        sta (ZERO_PAGE_ROW_LOW_BYTE),y // $2005  ($0520) , 15(f) = $052F .
                                       /* 
                                          The calculation found the ROW and then
                                          we add the Y to move to the right
                                          int the screen memory. REMEMBER :
                                          The address is in LITTLE ENDIAN, that
                                          is why you see a bytes in reverse 
                                          order
                                       */

        pull_regs_from_stack()
        rts


/*
    Print a number from 
    NUMBER_TO_PRINT_TABLE
*/
print_move_modules_in_table_to_number_to_print_str:

    //----------------------------------------------
    //copy digits save to "number_to_print_str"

    push_regs_to_stack()

    // Prepare N2 . Set number to 10
    // because it is need it to get 
    // the modules, ( digits )
    lda #10
    sta div_num2_0
    lda #0
    sta div_num2_1
    sta div_num2_2
    sta div_num2_3

    //set to 0 the div_resX
    sta div_res_0
    sta div_res_1
    sta div_res_2
    sta div_res_3

    // set to 0 X , it is the index to save
    // each digit ( module ) on the table
    ldx #0              
    loop_digits:

        //clean result in each loop
        lda #0
        sta div_res_0
        sta div_res_1
        sta div_res_2
        sta div_res_3

        // divide by 10
        jsr MATH_LIB.division_32 

        //save module
        lda div_num1_0
        sta NUMBER_TO_PRINT_TABLE,x
        inx // increment X to prepare the next position 
            // on table

        inc total_digits // increment the max available digits

        inc last_total_digits //save the total digits in the current
                              //call . Why ? because the next print ,
                              //we need print empty spaces to remove
                              //all digits


        // update quotient for next loop
        // update the result of the division
        // for the next iteration
        lda div_res_0
        sta div_num1_0

        lda div_res_1
        sta div_num1_1

        lda div_res_2
        sta div_num1_2

        lda div_res_3
        sta div_num1_3

        lda div_res_0
        bne loop_digits

    // when all modules are saved its time 
    // to show the digits

    // start from the tail of the TABLE because
    // the number are ordered on reverse.
    // where we read the tail from right to left
    // until see the first digits.
    // the NUMBER_TO_PRINT_TABLE can be like:
    // 04 05 06 03 05 00 00 00 00
    read_tail:
        
        dec counter_table   // counter--
        ldx counter_table   // load X with new counter value
        lda NUMBER_TO_PRINT_TABLE,x //get next module to show
        beq read_tail //
        //when do not found a 0 ... the number started

    // when the first number appears
    // its time to put the digits on the
    // varaible "number_to_print_str".
    // this variable it is used for
    // save the numbers.

    // start counter_str 0
    lda #0
    sta counter_str
    ldy counter_str
    copy_number:

        // we continue reading where now are numbers
        lda NUMBER_TO_PRINT_TABLE,x
        clc
        adc #$30 //add $30 to get the CHAR_CODE to see the digit
        sta number_to_print_str,y // and save the char on the varible
        
        inc counter_str  // increment counter_str
        ldy counter_str  // load the new value on Y

        dec counter_table // decrement counter table
        ldx counter_table // update X with new counter value

        dec total_digits  // this value contains the total of real digits
                          // without 0 digits
        lda total_digits  // load the current value of total digits
        bne copy_number   // if not is 0 , continue

        pull_regs_from_stack()

    rts

}    