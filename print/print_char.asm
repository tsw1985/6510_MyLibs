#import "variables/print_variables.asm"
#import "screen_table.asm"

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
    rts    