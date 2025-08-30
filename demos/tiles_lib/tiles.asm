insert_text(1,1,tileslib_str,YELLOW)


/* Load the new memory map configuration */


//lda #67 // A
//sta SCREEN_CHAR
//locate_text(2,1,BROWN)
//jsr PRINT_LIB.print_char  // print single char

lda #3
sta TILE_NUMBER

//lda #67
//sta SCREEN_CHAR

lda #5
sta TILE_COL

lda #10
sta TILE_ROW



jsr TILES_LIB.print_tile

