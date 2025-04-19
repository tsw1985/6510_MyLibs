// ------------------ MACROS FOR PRINT FUNCTIONS ----------------
//set the variables x,y,color
//later are used on print text functions
.macro locate_text(x,y,color){
    lda #x
    sta SCREEN_ROW_POS
    lda #y 
    sta SCREEN_COL_POS
    lda #color
    sta SCREEN_CHAR_COLOR

}

// Save in ZERO_PAGE the low hight byte
// of a label . This create a pointer
.macro print_text(string){
    lda #<string
    sta ZERO_PAGE_PRINT_TEXT_LO
    lda #>string
    sta ZERO_PAGE_PRINT_TEXT_HI
    jsr PRINT_LIB.print_text
}