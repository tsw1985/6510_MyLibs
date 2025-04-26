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

// This macro clean all variables related
// to show the digits numbers
.macro clear_get_digits(){

    // reset all for next print digit
    //reset total_digits for next print number

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


// Print result of SUM. This macro load the result
// of a SUM in the variables related to show the
// digits.
.macro load_result_of_calculation_to_print(res_0,res_1,res_2,res_3){
    //N1
    //Load the result of operation ... + - / *
    //to the DIV_num1_result
    lda res_0
    sta div_num1_0

    lda res_1
    sta div_num1_1

    lda res_2
    sta div_num1_2

    lda res_3
    sta div_num1_3
}

//This macro print the result of a calculation by:
//Row 
//Column
//Color
//To low to hight bytes: 0 - 1 - 2 - 3 ( 4 bytes , 32 bits)
.macro print_calculation_result(y,x,color,res_0,res_1,res_2,res_3){

    //----------- PRINT A NUMBER -----------
    // load the result of SUM
    // to process the printing number
    load_result_of_calculation_to_print(res_0,res_1,res_2,res_3)
    jsr PRINT_LIB.print_get_string_digits

    // Print number
    jsr PRINT_LIB.clean_location_screen
    locate_text(y,x,color)
    print_text(number_to_print_str)

    //reset all
    clear_get_digits()
    //----------- END PRINT A NUMBER -----------


}
