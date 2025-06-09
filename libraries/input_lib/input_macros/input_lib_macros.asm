/* This macro insert the INPUT in the coords y,x with limit and color */
.macro input_text(y,x,limit,color){

    /* SCREEN_INPUT_ROW_POS = Row position of input on the screen */
    lda #y // 19
    sta SCREEN_INPUT_ROW_POS
    sta INPUT_CURSOR_ROW

    /* SCREEN_INPUT_COL_POS = Col position of input on the screen */
    lda #x //5
    sta SCREEN_INPUT_COL_POS
    sta INPUT_CURSOR_COL


    /* INPUT_STR_LIMIT = Lenght of the text of input */
    lda #limit //13
    sta INPUT_STR_LIMIT

    /* SCREEN_INPUT_COLOR : Color of the text input */
    lda #color //BLACK
    sta SCREEN_INPUT_COLOR

    

    /* call the rutine */
    jsr INPUT_LIB.input_keyboard


}