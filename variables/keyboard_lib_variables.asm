// ------------------------- Keyboard Variables -------------------------------
TABLE_KEY_COL_INDEX: .byte 0
TABLE_KEY_ROW_INDEX: .byte 0
KEY_PRESSED:         .byte 0
CHAR_KEY_PRESSED:    .byte 0

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

TABLE_KEY_ASCII_X: .byte 1    
TABLE_KEY_ASCII:
    .byte 0,51,53,55,57,0,0,49       
    .byte 0,23,18,25,9,16,0,0       
    .byte 0,1,4,7,10,12,0,0       
    .byte 0,52,54,56,48,45,0,50       
    .byte 0,26,3,2,13,46,0,0       
    .byte 0,19,6,8,11,0,0,0       
    .byte 0,5,20,21,15,0,0,17       
    .byte 0,0,24,22,14,44,0,0

/*
m
,
.
-
space
*/