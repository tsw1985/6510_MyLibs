//call input_lib

//set col and row of input
lda #15
sta SCREEN_INPUT_ROW_POS
sta INPUT_CURSOR_ROW
sta INPUT_CURSOR_ROW_CLS

lda #5
sta SCREEN_INPUT_COL_POS
sta INPUT_CURSOR_COL
sta INPUT_CURSOR_COL_CLS

lda #13
// set limit . STR_LIMIT = COL + STR_LEN
lda INPUT_STR_LIMIT
clc
adc INPUT_CURSOR_COL_CLS
sta INPUT_STR_LIMIT_CLS
sta INPUT_STR_LIMIT


lda #YELLOW
sta SCREEN_INPUT_COLOR


push_regs_to_stack()
jsr INPUT_LIB.input_keyboard
//jsr INPUT_LIB.reset_bit_7_to_0_in_chars



fin_keyboard_demo:
jsr PRINT_LIB.clean_location_screen
    locate_text(5,0,WHITE)
    print_text(bye)

    pull_regs_from_stack()

    rts

