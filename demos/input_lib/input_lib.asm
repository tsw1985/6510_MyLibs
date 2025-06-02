//call input_lib

lda #0
sta INPUT_STR_LIMIT_CLS
sta INPUT_STR_LIMIT

//set col and row of input
lda #15
sta SCREEN_INPUT_ROW_POS
sta INPUT_CURSOR_ROW
sta INPUT_CURSOR_ROW_CLS

lda #5
sta SCREEN_INPUT_COL_POS
sta INPUT_CURSOR_COL
sta INPUT_CURSOR_COL_CLS

// set limit . STR_LIMIT = COL + STR_LEN
lda #5
sta INPUT_STR_LIMIT
sta INPUT_STR_LIMIT_CLS

lda #YELLOW
sta SCREEN_INPUT_COLOR

lda #0
sta INPUT_INDEX_COUNTER

jsr INPUT_LIB.input_keyboard

//-----------


lda #0
sta INPUT_STR_LIMIT_CLS
sta INPUT_STR_LIMIT

lda #19
sta SCREEN_INPUT_ROW_POS
sta INPUT_CURSOR_ROW
sta INPUT_CURSOR_ROW_CLS

lda #5
sta SCREEN_INPUT_COL_POS
sta INPUT_CURSOR_COL
sta INPUT_CURSOR_COL_CLS

// set limit . STR_LIMIT = COL + STR_LEN
lda #13
sta INPUT_STR_LIMIT
sta INPUT_STR_LIMIT_CLS

lda #BLACK
sta SCREEN_INPUT_COLOR

lda #0
sta INPUT_INDEX_COUNTER
jsr INPUT_LIB.input_keyboard

//--------------------------------------------
lda #0
sta INPUT_STR_LIMIT_CLS
sta INPUT_STR_LIMIT

lda #21
sta SCREEN_INPUT_ROW_POS
sta INPUT_CURSOR_ROW
sta INPUT_CURSOR_ROW_CLS

lda #1
sta SCREEN_INPUT_COL_POS
sta INPUT_CURSOR_COL
sta INPUT_CURSOR_COL_CLS

// set limit . STR_LIMIT = COL + STR_LEN
lda #17
sta INPUT_STR_LIMIT
sta INPUT_STR_LIMIT_CLS

lda #PINK
sta SCREEN_INPUT_COLOR

lda #0
sta INPUT_INDEX_COUNTER
jsr INPUT_LIB.input_keyboard

jsr PRINT_LIB.clean_location_screen
locate_text(5,0,WHITE)
print_text(bye)