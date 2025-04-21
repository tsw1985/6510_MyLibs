//Variables for division 16 bits

div_result_16_lo:  .byte 0
div_result_16_hi:  .byte 0

div_number_16_lo:  .byte 0 
div_number_16_hi:  .byte 0

div_divisor_16_lo: .byte 0
div_divisor_16_hi: .byte 0
//end Variables for division 16 bits

//Variables for multiplication 16 bits

mul_result_16_lo: .byte 0
mul_result_16_hi: .byte 0

mul_number_16_lo: .byte 0
mul_number_16_hi: .byte 0

mul_multiplicator_16_lo: .byte 0
mul_multiplicator_16_hi: .byte 0



//Variables for division 32 bits
// Bytes order . 1 is LBS
// 00 00 00 00 
// 4  3  2  1

div_num1_0: .byte 0
div_num1_1: .byte 0
div_num1_2: .byte 0
div_num1_3: .byte 0


div_num2_0: .byte 0
div_num2_1: .byte 0
div_num2_2: .byte 0
div_num2_3: .byte 0


div_res_0: .byte 0
div_res_1: .byte 0
div_res_2: .byte 0
div_res_3: .byte 0

// TEST

//; A = 78564 = $0001338C
A1:     .byte $8C
A2:     .byte $33
A3:     .byte $01
A4:     .byte $00

//; B = 2546 = $000009F2
B1:     .byte $F2
B2:     .byte $09
B3:     .byte $00
B4:     .byte $00

//; C = 0
C1:     .byte 0
C2:     .byte 0
C3:     .byte 0
C4:     .byte 0











//end Variables for division 32 bits