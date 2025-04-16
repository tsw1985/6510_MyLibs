// ------------------ MACROS FOR PRINT FUNCTIONS ----------------
.macro locate_text(x,y,color){
    lda #x
    sta SCREEN_ROW_POS
    lda #y 
    sta SCREEN_COL_POS
}

.macro load_text(string){
    lda #<string
    sta ZERO_PAGE_PRINT_TEXT_LO
    lda #>string
    sta ZERO_PAGE_PRINT_TEXT_HI
    jsr print_text
}