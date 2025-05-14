// ------------------------- Keyboard Variables -------------------------------
TABLE_KEY_COL_INDEX: .byte 0
TABLE_KEY_ROW_INDEX: .byte 0
KEY_PRESSED:         .byte 0
CHAR_KEY_PRESSED:    .byte 0
KEY_FLAGS:           .byte 0
KEY_BUFFER_INDEX:    .byte 0
KEY_WAIT:            .byte 0

// Save CMB KEY and
// future others special
// keys
KEYS_BUFFER:         .fill 6,0
KEYS_BUFFER_COUNTER: .byte 0

TABLE_KEY_BOARD_ROW:
    .byte %11111110  // 0
    .byte %11111101  // 1
    .byte %11111011  // 2
    .byte %11110111  // 3
    .byte %11101111  // 4
    .byte %11011111  // 5
    .byte %10111111  // 6
    .byte %01111111  // 7

TABLE_KEY_BOARD_COL:  //keys pressed
    .byte %00000001  // 0
    .byte %00000010  // 1
    .byte %00000100  // 2
    .byte %00001000  // 3
    .byte %00010000  // 4
    .byte %00100000  // 5
    .byte %01000000  // 6
    .byte %10000000  // 7

TABLE_KEY_ASCII_X_OFFSET: .byte 1    
TABLE_KEY_ASCII:
    .byte $00,$33,$35,$37,$39,$00,$00,$31
    .byte $00,$17,$12,$19,$09,$10,$00,$00
    .byte $FE,$01,$04,$07,$0A,$0C,$00,$FF // <--- CMB offset 23 . Cursor offset 16
    .byte $00,$34,$36,$38,$30,$2D,$00,$32
    .byte $00,$1A,$03,$02,$0D,$2E,$00,$60
    .byte $00,$13,$06,$08,$0B,$00,$00,$00
    .byte $00,$05,$14,$15,$0F,$00,$00,$11
    .byte $00,$00,$18,$16,$0E,$2C,$00,$00

//for input control
INPUT_STR_LIMIT:     .byte 0
INPUT_INDEX_COUNTER: .byte 0 // control string index

//Set row and col
SCREEN_INPUT_ROW_POS:   .byte 0
SCREEN_INPUT_COL_POS:   .byte 0
SCREEN_INPUT_COLOR:     .byte 0
PRESSED_KEY_TABLE:      .fill 64,0
INPUT_CURSOR_ROW:       .byte 0
INPUT_CURSOR_COL:       .byte 0
SCREEN_CHAR_COLOR_OLD:  .byte 0
INPUT_CURSOR:           .byte 0
temp_offset:            .byte 0
TEMP_X_REG: .byte 0
TEMP_Y_REG: .byte 0

