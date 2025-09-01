// ------------------ MACROS FOR PRINT FUNCTIONS ----------------

// set the variables x,y,color
// later are used on print text functions
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

// Print a string in the screen
.macro insert_text(y,x,string,color){

    jsr PRINT_LIB.clean_location_screen
    locate_text(y,x,color)
    print_text(string)

}

.macro print_input_text(string){
    lda #<string
    sta ZERO_PAGE_PRINT_TEXT_LO
    lda #>string
    sta ZERO_PAGE_PRINT_TEXT_HI
    jsr PRINT_LIB.print_input_text
}

// This macro clean all variables related
// to show the digits numbers
.macro clear_NUMBER_TO_PRINT_TABLE(){

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
    sta number_to_print_str,x
    
    ldx #1
    sta NUMBER_TO_PRINT_TABLE,x
    sta number_to_print_str,x
    
    ldx #2
    sta NUMBER_TO_PRINT_TABLE,x
    sta number_to_print_str,x

    ldx #3
    sta NUMBER_TO_PRINT_TABLE,x
    sta number_to_print_str,x

    ldx #4
    sta NUMBER_TO_PRINT_TABLE,x
    sta number_to_print_str,x
    
    ldx #5
    sta NUMBER_TO_PRINT_TABLE,x
    sta number_to_print_str,x
    
    ldx #6
    sta NUMBER_TO_PRINT_TABLE,x
    sta number_to_print_str,x
    
    ldx #7
    sta NUMBER_TO_PRINT_TABLE,x
    sta number_to_print_str,x
    
    ldx #8
    sta NUMBER_TO_PRINT_TABLE,x
    sta number_to_print_str,x
    
    ldx #9
    sta NUMBER_TO_PRINT_TABLE,x
    sta number_to_print_str,x

    lda #0
    sta div_res_0
    sta div_res_1
    sta div_res_2
    sta div_res_3

}


// Print result of SUM. This macro load the result
// of a SUM in the variables related to show the
// digits.
// Each byte of result is saved in div_num1_0 to 1_3
// because this will be the N1 to do the division by 10
// to save the digits ( modules ).
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
    jsr PRINT_LIB.print_move_modules_in_table_to_number_to_print_str


    // Before print the number, print empty values
    insert_text(y,x,space_4_str,color)

    // Print number
    insert_text(y,x,number_to_print_str,color)

    //reset all
    clear_NUMBER_TO_PRINT_TABLE()
    //----------- END PRINT A NUMBER -----------
}

.macro print_digits_str(y,x,color,n_0,n_1,n_2,n_3){

    lda #n_0
    sta sum_res_0
    lda #n_1
    sta sum_res_1
    lda #n_2
    sta sum_res_2
    lda #n_3
    sta sum_res_3
    print_calculation_result(y,x,color,sum_res_0,sum_res_1,sum_res_2,sum_res_3)

}