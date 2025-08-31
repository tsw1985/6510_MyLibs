.macro print_tile(tile_number,tile_col,tile_row){

    /* Load the new memory map configuration */
    lda #tile_number
    sta TILE_NUMBER

    lda #tile_col
    sta TILE_COL

    lda #tile_row
    sta TILE_ROW

    jsr TILES_LIB.print_tile

}