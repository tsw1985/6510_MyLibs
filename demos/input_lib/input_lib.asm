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

// set limit . STR_LIMIT = COL + STR_LEN
lda #13
clc
adc INPUT_CURSOR_COL
sta INPUT_STR_LIMIT
sta INPUT_STR_LIMIT_CLS
.break

lda #YELLOW
sta SCREEN_INPUT_COLOR

lda #0
sta INPUT_INDEX_COUNTER

push_regs_to_stack()
jsr INPUT_LIB.input_keyboard

//jsr INPUT_LIB.reset_bit_7_to_0_in_chars
//jsr INPUT_LIB.print_cursor



fin_keyboard_demo:
jsr PRINT_LIB.clean_location_screen
    locate_text(5,0,WHITE)
    print_text(bye)

    pull_regs_from_stack()

    rts

