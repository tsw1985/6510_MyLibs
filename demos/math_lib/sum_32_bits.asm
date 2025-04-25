// 65765 + 89927 = 155692

//load N1
lda #$0C
sta sum_num1_0

lda #$00
sta sum_num1_1

lda #$00
sta sum_num1_2

lda #$00
sta sum_num1_3

//load N2
lda #$00
sta sum_num2_0

lda #$00
sta sum_num2_1

lda #$00
sta sum_num2_2

lda #$00
sta sum_num2_3

//set to 0 result
lda #0
sta sum_res_0
sta sum_res_1
sta sum_res_2
sta sum_res_3

//calculate sum
jsr MATH_LIB.sum_32

//----------- PRINT A NUMBER -----------
// load the result of SUM
// to process the printing number
load_sum_result_to_print()
jsr PRINT_LIB.print_get_string_digits
// Print number
jsr PRINT_LIB.clean_location_screen
locate_text(8,0,YELLOW)
print_text(number_to_print_str)
//reset all
clear_get_digits()
//----------- END PRINT A NUMBER -----------


//load N1
lda #$0D
sta sum_num1_0

lda #$00
sta sum_num1_1

lda #$00
sta sum_num1_2

lda #$00
sta sum_num1_3

//load N2
lda #$01
sta sum_num2_0

lda #$00
sta sum_num2_1

lda #$00
sta sum_num2_2

lda #$00
sta sum_num2_3

//set to 0 result
lda #0
sta sum_res_0
sta sum_res_1
sta sum_res_2
sta sum_res_3

//calculate sum
jsr MATH_LIB.sum_32


//----------- PRINT A NUMBER -----------
// load the result of SUM
// to process the printing number
load_sum_result_to_print()
jsr PRINT_LIB.print_get_string_digits
// Print number
jsr PRINT_LIB.clean_location_screen
locate_text(9,0,GREEN)
print_text(number_to_print_str)
//reset all
clear_get_digits()
//----------- END PRINT A NUMBER -----------

// Imprimir end mensaje
jsr PRINT_LIB.clean_location_screen
locate_text(3,0,YELLOW)
print_text(sum_result_str)