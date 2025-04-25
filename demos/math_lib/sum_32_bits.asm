
// 65765 + 89927 = 155692

lda #$0A
sta sum_num1_0

lda #$00
sta sum_num1_1

lda #$00
sta sum_num1_2

lda #$00
sta sum_num1_3


lda #$00
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


//----------------------------------
// Mete de aqui para abajo, todo esto
// en la rutina print digit...
// el resultado de cualquier operacion
// es lo que ira en las variables div_nu...
// que luego sacará los modulos y todo el
// rollo así que hay que mover todo esto
// a la librería print number ...
//-----------------------------------


//Prepare result to print in screen
//We need save this value on a division by 10

//N1
//Load the result of operation ... + - / *
//to the DIV_num1_result
lda sum_res_0
sta div_num1_0

lda sum_res_1
sta div_num1_1

lda sum_res_2
sta div_num1_2

lda sum_res_3
sta div_num1_3


// Imprimir mensaje
    jsr PRINT_LIB.clean_location_screen
    locate_text(5,0,WHITE)
    print_text(sum_result_str)

    jsr PRINT_LIB.print_number



/*

Normal result values

.break
lda sum_res_0
lda sum_res_1
lda sum_res_2
lda sum_res_3
*/


