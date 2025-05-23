//call input_lib

//set col and row of input
lda #15
sta SCREEN_INPUT_ROW_POS
sta INPUT_CURSOR_ROW

lda #5
sta SCREEN_INPUT_COL_POS
sta INPUT_CURSOR_COL

lda #5
sta INPUT_STR_LIMIT

lda #YELLOW
sta SCREEN_INPUT_COLOR


push_regs_to_stack()
jsr INPUT_LIB.input_keyboard


fin_keyboard_demo:
jsr PRINT_LIB.clean_location_screen
    locate_text(5,0,WHITE)
    print_text(bye)

    pull_regs_from_stack()

    rts

