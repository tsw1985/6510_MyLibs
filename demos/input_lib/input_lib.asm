//call input_lib

//set col and row of input
lda #15
sta SCREEN_INPUT_ROW_POS
sta INPUT_CURSOR_ROW

lda #5
sta SCREEN_INPUT_COL_POS
sta INPUT_CURSOR_COL

lda #30
sta INPUT_STR_LIMIT

lda #YELLOW
sta SCREEN_INPUT_COLOR

jsr INPUT_LIB.input_keyboard