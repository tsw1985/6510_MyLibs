//First : show all text

//print first string
insert_text(6,0,division_n1_str,YELLOW)
insert_text(10,0,division_n2_str,YELLOW)


//print result string
insert_text(15,0,result_str,YELLOW)


//Print N1
print_digits_str(8,5,WHITE,$40,$6A,$02,$00)

//Print N2
//81
print_digits_str(12,5,WHITE,$51,$00,$00,$00)



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
insert_text(20,10,end_div_32_str,GREEN)