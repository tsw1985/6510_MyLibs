// ------------------------- Keyboard Variables -------------------------------
/* Save byte key pressed */
KEY_PRESSED:         .byte 0

/* KEY_FLAS BITS POSITION */
/*
    0 = C= KEY
    1 = ENTER KEY
    2 = ONLY CURSOR KEY ( go to right )
    3 = C= + CURSOR ( move cursor to left )
    4 = DELETE KEY
    5 = Screen String UPDATED ( to avoid screen flikering . Print in loop)
    6 = Cursor enabled
    7 = Show cursor on screen
*/
KEY_FLAGS:     .byte 0

/* Variable to allow or block the IRQ action. If it is 1 means the system
is printing in screen */
PRINTING_FLAG: .byte 0


/* MATRIX on ROW keys */
TABLE_KEY_BOARD_ROW:
    .byte %11111110  // 0
    .byte %11111101  // 1
    .byte %11111011  // 2
    .byte %11110111  // 3
    .byte %11101111  // 4
    .byte %11011111  // 5
    .byte %10111111  // 6
    .byte %01111111  // 7

/* MATRIX on COL keys */
TABLE_KEY_BOARD_COL: // keys pressed
    .byte %00000001  // 0
    .byte %00000010  // 1
    .byte %00000100  // 2
    .byte %00001000  // 3
    .byte %00010000  // 4
    .byte %00100000  // 5
    .byte %01000000  // 6
    .byte %10000000  // 7

/* Variable to save the calc of ROW and COL value of the keyboard MATRIX */
TABLE_KEY_ASCII_X_OFFSET: .byte 1

/* The table ASCII is where are the ASCII codes. This table is related with 
the TABLE_KEY_ASCII_X_OFFSET.  */
TABLE_KEY_ASCII:
    .byte $00,$33,$35,$37,$39,$00,$00,$31
    .byte $00,$17,$12,$19,$09,$10,$00,$00
    .byte $FE,$01,$04,$07,$0A,$0C,$00,$FF // <--- CMB offset 23 . Cursor offset 16
    .byte $00,$34,$36,$38,$30,$2D,$00,$32
    .byte $00,$1A,$03,$02,$0D,$2E,$00,$60
    .byte $00,$13,$06,$08,$0B,$00,$00,$00
    .byte $00,$05,$14,$15,$0F,$00,$00,$11
    .byte $00,$00,$18,$16,$0E,$2C,$00,$00

/* INPUT_CURSOR: This is to know where is the cursor in the input */
INPUT_CURSOR:        .byte 0  // This is to check the limit

/* INPUT_STR_LIMIT: this is the length of the input */
INPUT_STR_LIMIT:     .byte 0  // Lenght of str

/* ROTATE_INDEX : This is used when the user press DELETE key. It is used to
move the chars in the string  */
ROTATE_INDEX:           .byte 0

/* INPUT_INDEX_COUNTER: Used to know the position index in the string */
INPUT_INDEX_COUNTER: .byte 0 // control string index

//Set row and col
SCREEN_INPUT_ROW_POS:   .byte 0
SCREEN_INPUT_COL_POS:   .byte 0

SCREEN_INPUT_ROW_POS_CLS: .byte 0
SCREEN_INPUT_COL_POS_CLS: .byte 0
SCREEN_INPUT_COLOR:     .byte 0
PRESSED_KEY_TABLE:      .fill 64,0 // he we save with 1 where the offset says.
INPUT_CURSOR_ROW:       .byte 0
INPUT_CURSOR_COL:       .byte 0

SCREEN_CHAR_COLOR_OLD:  .byte 0
temp_offset:            .byte 0
TEMP_X_REG:             .byte 0
TEMP_Y_REG:             .byte 0
//This is the string buffer to print the chars on screen
KEYS_TO_SCREEN_STR:     .fill 80,96 // save 80 bytes with 0
CHAR_INDEX_1:           .byte 0
CHAR_INDEX_2:           .byte 0

IRQ_COUNTER: .byte 0
CURSOR_STATE: .byte 0

OLD_IRQ_LOW:  .byte 0
OLD_IRQ_HIGH: .byte 0

ORIGINAL_DC_02: .byte 0
ORIGINAL_DC_03: .byte 0





