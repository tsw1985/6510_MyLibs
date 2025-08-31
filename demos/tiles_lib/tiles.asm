insert_text(1,1,tileslib_str,YELLOW)


/* Load the new memory map configuration */
/*lda #3
sta TILE_NUMBER

lda #5
sta TILE_COL

lda #10
sta TILE_ROW

jsr TILES_LIB.print_tile*/

print_tile(0,8,12)
print_tile(2,10,18)
print_tile(3,12,24)
print_tile(4,14,30)