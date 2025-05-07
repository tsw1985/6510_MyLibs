//call input_lib

//set col and row of input
lda #3
sta SCREEN_INPUT_ROW_POS

lda #5
sta SCREEN_INPUT_COL_POS

lda #7
sta INPUT_STR_LIMIT

lda #BLACK
sta SCREEN_INPUT_COLOR

jsr INPUT_LIB.input_keyboard