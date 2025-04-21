/*lda #$fa
sta div_num1_0  // Dividendo = $0006F8FA (456,954)
lda #$f8
sta div_num1_1
lda #$06
sta div_num1_2
lda #$00
sta div_num1_3

lda #$02
sta div_num2_0  // Divisor = $00000002 (2)
lda #$00
sta div_num2_1
sta div_num2_2
sta div_num2_3*/








jsr MATH_LIB.division_32

/*
lda div_res_0
.break
lda div_res_1
.break
lda div_res_2
.break
lda div_res_3
.break
*/


jsr PRINT_LIB.clean_location_screen
locate_text(7,10,YELLOW)
print_text(end_div_32_str)

