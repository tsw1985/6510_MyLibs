// 65765 + 89927 = 155692

// -----------------------------------------
// Steps to print a number:
//

//load N1
lda #$E5
sta sum_num1_0

lda #$00
sta sum_num1_1

lda #$01
sta sum_num1_2

lda #$00
sta sum_num1_3

//load N2
lda #$47
sta sum_num2_0

lda #$5F
sta sum_num2_1

lda #$01
sta sum_num2_2

lda #$00
sta sum_num2_3

//set to 0 result
lda #0
sta sum_res_0
sta sum_res_1
sta sum_res_2
sta sum_res_3

//calculate sum
jsr MATH_LIB.sum_32
print_calculation_result(10,3,YELLOW,sum_res_0,sum_res_1,sum_res_2,sum_res_3)



// Print a simple number without calculation :
// Example: 32786 ($00 $00 $80 $12)
// set to 0 result
lda #$12
sta sum_res_0
lda #$80
sta sum_res_1
lda #$00
sta sum_res_2
lda #$00
sta sum_res_3
print_calculation_result(15,5,YELLOW,sum_res_0,sum_res_1,sum_res_2,sum_res_3)