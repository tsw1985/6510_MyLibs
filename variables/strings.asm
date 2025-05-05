// -------------- ALL STRINGS TEXT TO SHOW ---------------------
// string text must be wrotten in lowercase
// DO NOT FORGET ADD \$00 at the end of the string
number_to_print_str: 
.byte 0 
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0

number_to_print_clean_str: 
.byte 0 
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0

keys_buffer_to_str:
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0 // do not override , this is the end of string
stars_line:       .text @"****************************************\$00"
message:          .text @"this is a message\$00"
bye:              .text @"bye byeee show sum\$00"
math_lib_string:  .text @"this is the math lib\$00"
end_div_string:   .text @"end division\$00"
end_div_32_str:   .text @"end 32 bits division\$00"
end_mul_string:   .text @"end multiplication\$00"
end_mul_32_str:   .text @"end multiplication 32 bits\$00"
sum_result_str:   .text @"resultado de la suma es:\$00"
sub_result_str:   .text @"resultado de la resta es:\$00"
result_str:       .text @"resultado:\$00"
division_n1_str:  .text @"la division de:\$00"
division_n2_str:  .text @"entre:\$00"
multipli_n1_str:  .text @"la multiplicacion de:\$00"
mult_times_str:   .text @"por:\$00"
end_keyboard_str: .text @"end keyboard testing:\$00"
hello_keyb_str:   .text @"hello keyboard. press a key\$00"
coor_y_str:       .text @"y:\$00"
coor_x_str:       .text @"x:\$00"
table_offset_str: .text @"offset\$00"
cmb_pressed_str:  .text @"cbm pressed\$00"
end_print_row_str:.text @"end row\$00"

