// ------------------ MACROS FOR PRINT FUNCTIONS ----------------
//set the variables x,y,color
//later are used on print text functions
.macro locate_text(x,y,color){
    lda #x
    sta SCREEN_ROW_POS
    lda #y 
    sta SCREEN_COL_POS
    lda #color
    sta SCREEN_CHAR_COLOR

}

// Save in ZERO_PAGE the low hight byte
// of a label . This create a pointer
.macro print_text(string){
    lda #<string
    sta ZERO_PAGE_PRINT_TEXT_LO
    lda #>string
    sta ZERO_PAGE_PRINT_TEXT_HI
    jsr PRINT_LIB.print_text
}


.macro clear_get_digits(){

    // reset all for next print digit
    //reset total_digits for next print number

    .break
    lda #0
    sta total_digits
    sta counter_str

    lda #10
    sta counter_table

    lda #0
    ldx #0
    sta NUMBER_TO_PRINT_TABLE,x
    inx
    sta NUMBER_TO_PRINT_TABLE,x
    inx
    sta NUMBER_TO_PRINT_TABLE,x
    inx
    sta NUMBER_TO_PRINT_TABLE,x
    inx
    sta NUMBER_TO_PRINT_TABLE,x
    inx
    sta NUMBER_TO_PRINT_TABLE,x
    inx
    sta NUMBER_TO_PRINT_TABLE,x
    inx
    sta NUMBER_TO_PRINT_TABLE,x
    inx
    sta NUMBER_TO_PRINT_TABLE,x
    inx
    sta NUMBER_TO_PRINT_TABLE,x
}


// Print result of SUM
.macro load_sum_result_to_print(){
    //N1
    //Load the result of operation ... + - / *
    //to the DIV_num1_result
    lda sum_res_0
    sta div_num1_0

    lda sum_res_1
    sta div_num1_1

    lda sum_res_2
    sta div_num1_2

    lda sum_res_3
    sta div_num1_3

}
