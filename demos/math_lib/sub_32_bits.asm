//  89927 - 65765 = 24162

// N1
lda #$47
sta sub_num1_0
lda #$5F
sta sub_num1_1
lda #$01
sta sub_num1_2
lda #$00
sta sub_num1_3

// N2
lda #$E5
sta sub_num2_0
lda #$00
sta sub_num2_1
lda #$01
sta sub_num2_2
lda #$00
sta sub_num2_3

// Result
lda #0
sta sub_res_0
sta sub_res_1
sta sub_res_2
sta sub_res_3

// Do the calculation
jsr MATH_LIB.sub_32

//Print the result
print_calculation_result(10,3,YELLOW,sub_res_0,sub_res_1,sub_res_2,sub_res_3)
insert_text(6,0,sub_result_str,YELLOW)

