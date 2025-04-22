
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



//Prepare result to print in screen
//We need save this value on a division by 10


//N1
lda sum_res_0
sta div_num1_0

lda sum_res_1
sta div_num1_1

lda sum_res_2
sta div_num1_2

lda sum_res_3
sta div_num1_3

//N2
lda #10
sta div_num2_0
lda #0
sta div_num2_1
sta div_num2_2
sta div_num2_3


/*
iterations: .byte 0

get_modules:

    jsr MATH_LIB.division_32

    // Save remainder BEFORE overwriting div_num1
    lda div_num1_0


    ldx iterations
    sta NUMBER_TO_PRINT_TABLE,x
    inc iterations

    // Now overwrite with new quotient
    lda div_res_0
    sta div_num1_0

    lda div_res_1
    sta div_num1_1

    lda div_res_2
    sta div_num1_2

    lda div_res_3
    sta div_num1_3
    
    lda div_num1_0
    cmp #0
    bne get_modules
    */



    //print text 4
    jsr PRINT_LIB.clean_location_screen
    locate_text(5,0,WHITE)
    print_text(bye)    



/*

Normal result values

.break
lda sum_res_0
lda sum_res_1
lda sum_res_2
lda sum_res_3
*/


