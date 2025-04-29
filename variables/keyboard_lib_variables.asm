// ------------------------- Keyboard Variables -------------------------------
TABLE_KEY_COL_INDEX: .byte 0
TABLE_KEY_ROW_INDEX: .byte 0

TABLE_KEY_BOARD_ROW:
    .byte %11111110  // 0
    .byte %11111101  // 1
    .byte %11111011  // 2
    .byte %11110111  // 3
    .byte %11101111  // 4
    .byte %11011111  // 5
    .byte %10111111  // 6
    .byte %01111111  // 7

TABLE_KEY_BOARD_COL:
    .byte %00000001  // 0
    .byte %00000010  // 1
    .byte %00000100  // 2
    .byte %00001000  // 3
    .byte %00010000  // 4
    .byte %00100000  // 5
    .byte %01000000  // 6
    .byte %10000000  // 7  