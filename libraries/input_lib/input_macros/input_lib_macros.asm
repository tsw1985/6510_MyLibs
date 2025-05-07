// set the variables x,y,color
// later are used on print text functions
.macro locate_input(){

    // move the coords set on demo file
    // and change the values

    lda SCREEN_INPUT_ROW_POS
    sta SCREEN_ROW_POS
    
    lda SCREEN_INPUT_COL_POS
    sta SCREEN_COL_POS
    
    lda SCREEN_INPUT_COLOR
    sta SCREEN_CHAR_COLOR
}