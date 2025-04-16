# 6510 Lib
I made this small functions to try to make me easy my life with the 6510 assembler code. I hope this help to you.

This functions are for kickassembler.

## PRINT TEXT FUNCTIONS
### Print a char
    
    lda #1 // A
    sta SCREEN_CHAR
    locate_text(3,4,0) // row,col,color
    jsr print_char  // print single char

### Print a string text

    message: .text @"This is your text\$00"
    jsr clean_location_screen
    locate_text(4,1,0) // row,col,color
    load_text(message) // string

    
