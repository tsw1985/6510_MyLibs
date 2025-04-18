//call multiplication function
// 1250 * 13 = 16250 ( $3F7A )

    lda #0
    sta multiplication_result_lo
    sta multiplication_result_hi

    lda #$E2
    sta multiplication_number_lo

    lda #$04
    sta multiplication_number_hi

    lda #$0D
    sta multiplication_multiplicator_lo

    lda #$00
    sta multiplication_multiplicator_hi


jsr multiplication    

jsr clean_location_screen
locate_text(6,0,YELLOW)
print_text(end_mul_string)