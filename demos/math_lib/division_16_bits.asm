//call here the division rutine
// 45784 / 765 = 59,84 ( $003B )
// Meter en macro !!!

lda #$D8
sta div_number_16_lo

lda #$B2
sta div_number_16_hi

lda #$FD
sta div_divisor_16_lo

lda #$02
sta div_divisor_16_hi

//division result
lda #$0
sta div_result_16_lo
sta div_result_16_hi

jsr MATH_LIB.division_16

lda div_result_16_hi // ver el cociente
lda div_result_16_lo // ver el cociente

//modulos
//lda div_number_16_hi // ver el modulo 
//.break
//lda div_number_16_lo // ver el modulo 
//.break
//jsr clean_location_screen
//locate_text(7,10,YELLOW)
//print_text(end_div_string)