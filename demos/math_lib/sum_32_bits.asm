
// 65765 + 89927 = 155692

lda #$E5
sta sum_num1_0

lda #$00
sta sum_num1_1

lda #$01
sta sum_num1_2

lda #$00
sta sum_num1_3



lda #$47
sta sum_num2_0

lda #$5F
sta sum_num2_1

lda #$01
sta sum_num2_2

lda #$00
sta sum_num2_3

lda #0
sta sum_res_0
sta sum_res_1
sta sum_res_2
sta sum_res_3

jsr MATH_LIB.sum_32



