#import "print_macros/print_lib_macros.asm"

PRINT_LIB:
{

    clean_screen:
        jsr $e544 //clear screen
        rts


    /*
        Def   : clean ROW - COL coords
        Input : none
    */
    clean_location_screen:    

        pha  // save A on stack
        txa  // transfer X to A
        pha  // push A (X) on stack
        tya  // transfer Y to A
        pha  // push A (Y) to stack

        lda #0
        sta SCREEN_CHAR_INDEX
        sta SCREEN_ROW_POS
        sta SCREEN_COL_POS             // col 15

        
        pla // pull A from stack (Y)
        tay // transfer A to Y
        pla // pull A from stack (X)
        tax // transfer A to X
        pla // pull A from Stack

        rts

    /*
        Def   : print text
        Input : load the pointer in ZERO_PAGE_PRINT_TEXT_LO 
    */
    print_text:

        pha  // save A on stack
        txa  // transfer X to A
        pha  // push A (X) on stack
        tya  // transfer Y to A
        pha  // push A (Y) to stack

        ldy #0
        continue_writing:
            lda (ZERO_PAGE_PRINT_TEXT_LO),y
            beq end_writing    //si A == 0 flag Z active
            sta SCREEN_CHAR    //load char to show
            jsr print_char
            iny
            inc SCREEN_COL_POS
            jmp continue_writing

        end_writing:


        pla // pull A from stack (Y)
        tay // transfer A to Y
        pla // pull A from stack (X)
        tax // transfer A to X
        pla // pull A from Stack

        rts    



    /*
        Def   : print a char on a custom ROW - COL
        Input : SCREEN_ROW_POS ( X position)
                SCREEN_COL_POS ( Y position)
                SCREEN_CHAR ( char to show )
    */
    print_char:    

        pha  // save A on stack
        txa  // transfer X to A
        pha  // push A (X) on stack
        tya  // transfer Y to A
        pha  // push A (Y) to stack

        //set color on color ram
        ldx SCREEN_ROW_POS       
        lda Row_Color_LO,x
        sta ZERO_PAGE_ROW_COLOR_LOW_BYTE

        lda Row_Color_HI,x
        sta ZERO_PAGE_ROW_COLOR_HIGHT_BYTE

        ldy SCREEN_COL_POS             
        lda SCREEN_CHAR_COLOR
        sta (ZERO_PAGE_ROW_COLOR_LOW_BYTE),y

        //set coords on Screen
        ldx SCREEN_ROW_POS       // Row 22
        lda Row_LO,x
        sta ZERO_PAGE_ROW_LOW_BYTE
        lda Row_HI,x
        sta ZERO_PAGE_ROW_HIGHT_BYTE

        ldy SCREEN_COL_POS             // col 15
        lda SCREEN_CHAR                // char E
        sta (ZERO_PAGE_ROW_LOW_BYTE),y


        pla // pull A from stack (Y)
        tay // transfer A to Y
        pla // pull A from stack (X)
        tax // transfer A to X
        pla // pull A from Stack

        rts


/*
    Print a number from 
    NUMBER_TO_PRINT_TABLE
*/
print_number:
    //copy digits save to "number_to_print_str"

    //todo clean number_to_print_str to all 00000000

    pha  // save A on stack
    txa  // transfer X to A
    pha  // push A (X) on stack
    tya  // transfer Y to A
    pha  // push A (Y) to stack


 
    
   
    read_tail:
        dec counter_table
        ldx counter_table
        lda NUMBER_TO_PRINT_TABLE,x
        beq read_tail
        //when do not found a 0 ... the number started
    
    
    //.break
    ldy #0
    copy_number:
        ldx counter_table
        lda NUMBER_TO_PRINT_TABLE,x
        clc
        adc $30
        dec counter_table
        sta number_to_print_str,y
        inc counter_str
        ldy counter_table
        bne copy_number

        .break

        // Print number
        jsr PRINT_LIB.clean_location_screen
        locate_text(6,0,WHITE)
        print_text(number_to_print_str)

        pla // pull A from stack (Y)
        tay // transfer A to Y
        pla // pull A from stack (X)
        tax // transfer A to X
        pla // pull A from Stack

    rts

}    