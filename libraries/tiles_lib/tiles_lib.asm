#import "tiles_macros/tiles_lib_macros.asm"

TILES_LIB:
{

    init_new_charset:
    push_regs_to_stack()

        /* Here we are setting the position of Screen ram and where is the
           charset to use, in the address $3800 */
        lda #%00011110 // Screen RAM: $0400   Charset: $3800
        sta $d018 // Screen memory setup
    pull_regs_from_stack()
    rts



    /* LOAD TILE:
    
       IN: 
        
            TILE_NUMBER: Number of tile
            TILE_COL:    Row for tile
            TILE_ROW:    Col for tile
    
     */
print_tile:

    push_regs_to_stack()

    lda TILE_NUMBER // Load the tile we want to load
    asl
    asl // Shift to left 2 bits ( its multiply by 4) 
        // because each tile are 4 bytes


    tax   // put on X this offset to select the tail in tail set file and load
            // first char

    //Set row and col to print char
    // SCREEN_ROW_POS ( X position)
    // SCREEN_COL_POS ( Y position)
    // SCREEN_CHAR ( char to show )

    /* Set col */
    lda TILE_COL
    sta SCREEN_ROW_POS

    lda TILE_ROW
    sta SCREEN_COL_POS


    // Get first char of tile and
    lda TILESET_ADDRESS,x
    sta SCREEN_CHAR
    jsr PRINT_LIB.print_char

    pull_regs_from_stack()
rts
    



}