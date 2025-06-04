/* This macro insert the INPUT in the coords y,x with limit and color */
.macro input_text(y,x,limit,color){

    lda #0
    sta INPUT_STR_LIMIT_CLS
    sta INPUT_STR_LIMIT

    lda #y // 19
    sta SCREEN_INPUT_ROW_POS
    sta INPUT_CURSOR_ROW
    sta INPUT_CURSOR_ROW_CLS

    lda #x //5
    sta SCREEN_INPUT_COL_POS
    sta INPUT_CURSOR_COL
    sta INPUT_CURSOR_COL_CLS

    // set limit . STR_LIMIT = COL + STR_LEN
    lda #limit //13
    sta INPUT_STR_LIMIT
    sta INPUT_STR_LIMIT_CLS

    lda #color //BLACK
    sta SCREEN_INPUT_COLOR

    lda #0
    sta INPUT_INDEX_COUNTER

    /* call the rutine */
    jsr INPUT_LIB.input_keyboard


}