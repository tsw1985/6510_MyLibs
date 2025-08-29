/* Load the new memory map configuration */
jsr TILES_LIB.init_new_charset


lda #67 // A
sta SCREEN_CHAR
locate_text(1,1,YELLOW)
jsr PRINT_LIB.print_char  // print single char