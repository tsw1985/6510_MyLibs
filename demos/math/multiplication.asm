//call multiplication function
// 1250 * 13 = 16250 ( $3F7A )

    lda #0
    sta multiplication_result_lo
    sta multiplication_result_hi

    lda #$D2 // E2
    sta multiplication_number_lo

    lda #$05 // 04
    sta multiplication_number_hi

    lda #$0E // 0D
    sta multiplication_multiplicator_lo

    lda #$00
    sta multiplication_multiplicator_hi


jsr multiplication    

// show results
lda multiplication_result_hi // ver el resultado hi
.break
lda multiplication_result_lo // ver el resultado lo
.break



jsr clean_location_screen
locate_text(6,0,YELLOW)
print_text(end_mul_string)