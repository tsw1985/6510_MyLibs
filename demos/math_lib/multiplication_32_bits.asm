//call multiplication function

//print first string
insert_text(4,0,multipli_n1_str,YELLOW)


//print first string
insert_text(10,0,mult_times_str,YELLOW)

//print result string
insert_text(15,0,result_str,YELLOW)


//Print N1
print_digits_str(6,5,WHITE,$f1,$24,$00,$00)

//Print N2
print_digits_str(12,5,WHITE,$0D,$00,$00,$00)

// do the multiplication
// 9547 x 13 = 122941

lda #$f1
sta mul_num1_0 
lda #$24
sta mul_num1_1
lda #$00
sta mul_num1_2
lda #$00
sta mul_num1_3

lda #$0D
sta mul_num2_0
lda #$00
sta mul_num2_1
lda #$00
sta mul_num2_2
lda #$00
sta mul_num2_3

//set to 0 result
lda #$00
sta mul_res_0
sta mul_res_1
sta mul_res_2
sta mul_res_3

jsr MATH_LIB.multiplication_32    

// Print the result of calculation on screen
print_calculation_result(17,5,PINK,mul_res_0,
                                   mul_res_1,
                                   mul_res_2,
                                   mul_res_3)

//Print end text
insert_text(20,10,end_mul_32_str,GREEN)