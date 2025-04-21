//call multiplication function

// 9547 x 13 = 122941


    lda #$f1
    sta mul_num1_0 
    lda #$24
    sta mul_num1_1
    lda #$00
    sta mul_num1_2
    lda #$00
    sta mul_num1_3

    lda #$0D
    sta mul_num2_0
    lda #$00
    sta mul_num2_1
    lda #$00
    sta mul_num2_2
    lda #$00
    sta mul_num2_3

    //set to 0 result
    lda #$00
    sta mul_res_0
    sta mul_res_1
    sta mul_res_2
    sta mul_res_3



jsr MATH_LIB.multiplication_32    
jsr PRINT_LIB.clean_location_screen
locate_text(6,0,WHITE)
print_text(end_mul_32_str)