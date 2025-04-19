//call here the division rutine

// 45784 / 765 = 59,84 ( $003B )
// Meter en macro !!!

lda #$D8
sta division_number_1_lo

lda #$B2
sta division_number_1_hi

lda #$FD
sta division_divisor_lo

lda #$02
sta division_divisor_hi

//division result
lda #$0
sta division_result_lo
sta division_result_hi

jsr division

lda division_result_hi // ver el cociente
lda division_result_lo // ver el cociente

//modulos
//lda division_number_1_hi // ver el modulo 
//.break
//lda division_number_1_lo // ver el modulo 
//.break
//jsr clean_location_screen
//locate_text(7,10,YELLOW)
//print_text(end_div_string)