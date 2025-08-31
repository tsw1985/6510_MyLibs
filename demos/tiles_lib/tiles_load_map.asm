/*This demo shows how to load a MAP */
//.break


lda #8
sta MAP_NUMBER
jsr TILES_LIB.load_map