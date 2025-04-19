lda #1 // A
sta SCREEN_CHAR
locate_text(7,4,YELLOW)
jsr PRINT_LIB.print_char  // print single char