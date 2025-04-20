//call multiplication function
// 1250 * 13 = 16250 ( $3F7A )

    lda #0
    sta mul_result_16_lo
    sta mul_result_16_hi

    lda #$E2 // E2
    sta mul_number_16_lo

    lda #$04 // 04
    sta mul_number_16_hi

    lda #$0D // 0D
    sta mul_multiplicator_16_lo

    lda #$00
    sta mul_multiplicator_16_hi


jsr MATH_LIB.multiplication_16    

// show results
lda mul_result_16_hi // ver el resultado hi
.break
lda mul_result_16_lo // ver el resultado lo
.break



jsr PRINT_LIB.clean_location_screen
locate_text(6,0,YELLOW)
print_text(end_mul_string)