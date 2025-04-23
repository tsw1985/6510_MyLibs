
// 65765 + 89927 = 155692

lda #$05
sta sum_num1_0

lda #$10
sta sum_num1_1

lda #$00
sta sum_num1_2

lda #$00
sta sum_num1_3


lda #$02
sta sum_num2_0

lda #$00
sta sum_num2_1

lda #$00
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

//.break
//N1
lda sum_res_0
sta div_num1_0

lda sum_res_1
sta div_num1_1

lda sum_res_2
sta div_num1_2

lda sum_res_3
sta div_num1_3


.break
lda div_num1_0
lda div_num1_1
lda div_num1_2
lda div_num1_3


//N2
lda #10
sta div_num2_0
lda #0
sta div_num2_1
sta div_num2_2
sta div_num2_3

sta div_res_0
sta div_res_1
sta div_res_2
sta div_res_3


ldx #0              // índice para guardar restos en la tabla

loop_digits:

    //clean result in each loop
    lda #0
    sta div_res_0
    sta div_res_1
    sta div_res_2
    sta div_res_3

    jsr MATH_LIB.division_32 

    //; guardar el byte menos significativo del resto
    lda div_num1_0
    //.break
    sta NUMBER_TO_PRINT_TABLE,x
    inx

    lda div_res_0
    sta div_num1_0

    lda div_res_1
    sta div_num1_1

    lda div_res_2
    sta div_num1_2

    lda div_res_3
    sta div_num1_3

    lda div_res_0
    bne loop_digits             //; si no es cero, repetir


    // Imprimir mensaje
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


