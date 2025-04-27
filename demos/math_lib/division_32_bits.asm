//First : show all text

//print first string
jsr PRINT_LIB.clean_location_screen
locate_text(6,0,YELLOW)
print_text(division_n1_str) //La division de  ...


//print first string
jsr PRINT_LIB.clean_location_screen
locate_text(10,0,YELLOW)
print_text(division_n2_str) // ENTRE


//print result string
jsr PRINT_LIB.clean_location_screen
locate_text(15,0,YELLOW)
print_text(result_str) //resultado

//Print N1
lda #$40
sta sum_res_0
lda #$6A
sta sum_res_1
lda #$02
sta sum_res_2
lda #$00
sta sum_res_3
print_calculation_result(8,5,WHITE,sum_res_0,sum_res_1,sum_res_2,sum_res_3)


//Print N2
//81
lda #$51   //51 = 81
sta sum_res_0
lda #$00
sta sum_res_1
lda #$00
sta sum_res_2
lda #$00
sta sum_res_3
print_calculation_result(12,5,WHITE,sum_res_0,
                                    sum_res_1,
                                    sum_res_2,
                                    sum_res_3)


// Now do division
//-------------------
//Low byte to hight byte
// 158272 / 81 = 1953
//N1
lda #$40
sta div_num1_0 
lda #$6A
sta div_num1_1
lda #$02
sta div_num1_2
lda #$00
sta div_num1_3

//N2
lda #$51
sta div_num2_0
lda #$00
sta div_num2_1
lda #$00
sta div_num2_2
lda #$00
sta div_num2_3

//Set result to 0
lda #$00
sta div_res_0
sta div_res_1
sta div_res_2
sta div_res_3

//calculate division
jsr MATH_LIB.division_32

// Print the result of calculation on screen
print_calculation_result(17,5,PINK,div_res_0,div_res_1,div_res_2,div_res_3)




//Print end text
jsr PRINT_LIB.clean_location_screen
locate_text(20,10,GREEN)
print_text(end_div_32_str) //end div


