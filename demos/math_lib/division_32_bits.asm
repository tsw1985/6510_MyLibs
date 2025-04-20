//call here the division rutine
// 8734 / 3454 = 59,84 ( $003B )
// Meter en macro !!!


//divide 89586 / 42 = 2133 ( $00000855)
//89586:  $00015DF2 / 

// dividendo = 89586 = $00015DF2
lda #$f2
sta div_num1_0
lda #$5d
sta div_num1_1
lda #$01
sta div_num1_2
lda #$00
sta div_num1_3

// divisor = 42 = $0000002A
lda #$2a
sta div_num2_0
lda #$00
sta div_num2_1
sta div_num2_2
sta div_num2_3

// limpiar resultado
lda #$00
sta div_res_0
sta div_res_1
sta div_res_2
sta div_res_3


//division result
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

