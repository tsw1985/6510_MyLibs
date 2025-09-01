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

/* MACRO TO LOAD A MAP IN SCREEN */
.macro print_map(map_number){
    lda #map_number
    sta MAP_NUMBER
    jsr TILES_LIB.load_map
}