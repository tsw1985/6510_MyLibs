
.label ZERO_PAGE                 = $0020     

.label ZERO_PAGE_ROW_LOW_BYTE    = ZERO_PAGE + 0 // $20
.label ZERO_PAGE_ROW_HIGHT_BYTE  = ZERO_PAGE + 1 // $21

.label ZERO_PAGE_PRINT_TEXT_LO  = ZERO_PAGE + 2 // $22
.label ZERO_PAGE_PRINT_TEXT_HI  = ZERO_PAGE + 3 // $23


.label SCREEN_RAM     = $0400
.label SCREEN_WIDTH   = 40
.label SCREEN_HEIGHT  = 25


// ---------------------------- ROWS ---------------------------------------
//LOW BYTE
Row_LO:
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 0))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 1))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 2))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 3))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 4))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 5))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 6))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 7))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 8))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 9))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 10))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 11))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 12))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 13))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 14))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 15))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 16))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 17))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 18))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 19))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 20))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 21))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 22))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 23))
.byte <(SCREEN_RAM + (SCREEN_WIDTH * 24))


Row_HI:
//HIGHT_BYTE
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 0))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 1))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 2))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 3))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 4))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 5))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 6))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 7))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 8))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 9))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 10))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 11))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 12))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 13))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 14))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 15))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 16))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 17))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 18))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 19))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 20))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 21))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 22))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 23))
.byte >(SCREEN_RAM + (SCREEN_WIDTH * 24))

// ---------------------------- END ROWS ---------------------------------------