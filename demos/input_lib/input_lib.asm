//call input_lib

//set col and row of input
lda #15
sta SCREEN_INPUT_ROW_POS
sta INPUT_CURSOR_ROW

lda #10
sta SCREEN_INPUT_COL_POS
sta INPUT_CURSOR_COL

lda #15
sta INPUT_STR_LIMIT

lda #GREEN
sta SCREEN_INPUT_COLOR

jsr INPUT_LIB.input_keyboard