
//Low byte to hight byte

lda #$40
sta div_num1_0 
lda #$6A
sta div_num1_1
lda #$02
sta div_num1_2
lda #$00
sta div_num1_3

lda #$51
sta div_num2_0
lda #$00
sta div_num2_1
lda #$00
sta div_num2_2
lda #$00
sta div_num2_3

jsr MATH_LIB.division_32


.break
lda div_res_0
lda div_res_1
lda div_res_2
lda div_res_3




jsr PRINT_LIB.clean_location_screen
locate_text(7,10,YELLOW)
print_text(end_div_32_str)

