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
    insert_text(2,5,message,RED) // row , col, text , color

## INPUT TEXT ( Keyboard )

    /* CALL INPUT ROW , COL , LIMIT , COLOR */
    /* The variable with the wrotten text is : KEYS_TO_SCREEN_STR */
    input_text(15,0,25,PINK)
    insert_text(16,15,KEYS_TO_SCREEN_STR,GREEN)

