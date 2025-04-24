/* ------------------- PRINT VARIABLES ----------------------
    Variables related with print functions
*/

SCREEN_ROW_COLOR_POS: .byte 0
SCREEN_COL_COLOR_POS: .byte 0
SCREEN_ROW_POS:       .byte 0
SCREEN_COL_POS:       .byte 0
SCREEN_CHAR:          .byte 0
SCREEN_CHAR_COLOR:    .byte 0
SCREEN_CHAR_INDEX:    .byte 0


//10 digits to print 32 bits
NUMBER_TO_PRINT_TABLE: 
.byte $0
.byte $0
.byte $0
.byte $0
.byte $0
.byte $0
.byte $0
.byte $0
.byte $0
.byte $0

//start table from tail
counter_table: .byte 10
counter_str:   .byte 0
total_digits:  .byte 0