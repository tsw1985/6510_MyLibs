// 65765 - 89927 = 155692
lda #$47
sta sub_num1_0

lda #$5F
sta sub_num1_1

lda #$01
sta sub_num1_2

lda #$00
sta sub_num1_3




lda #$E5
sta sub_num2_0

lda #$00
sta sub_num2_1

lda #$01
sta sub_num2_2

lda #$00
sta sub_num2_3


lda #0
sta sub_res_0
sta sub_res_1
sta sub_res_2
sta sub_res_3

jsr MATH_LIB.sub_32