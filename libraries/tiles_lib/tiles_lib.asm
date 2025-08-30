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

    stx TILE_TEMP_X //save the current X value

    //Set row and col to print char
    // SCREEN_ROW_POS ( X position)
    // SCREEN_COL_POS ( Y position)
    // SCREEN_CHAR ( char to show )

    /* PRINT TOP LEFT */
    /* Set col */
    lda TILE_COL
    sta SCREEN_ROW_POS

    lda TILE_ROW
    sta SCREEN_COL_POS

    // Get first char of tile and
    lda TILESET_ADDRESS,x
    sta SCREEN_CHAR

         
    tax // set X to the current value of this char 
        // ( If A = 67 then X = offset 67)
    lda CHARSET_ATTRIB_ADDRESS,x  //In this position is the color of this char
    sta SCREEN_CHAR_COLOR
    jsr PRINT_LIB.print_char  // TOP LEFT PRINTED

    
    /* PRINT TOP RIGHT */
    lda TILE_TEMP_X
    tax // get again the value of X

    inc SCREEN_COL_POS // increment COL ( y ) to right
    // Get first char of tile and
    inx // Move to second char of TAIL
    stx TILE_TEMP_X //save again X
    lda TILESET_ADDRESS,x
    sta SCREEN_CHAR

    ldx SCREEN_CHAR
    lda CHARSET_ATTRIB_ADDRESS,x  //In this position is the color of this char
    sta SCREEN_CHAR_COLOR
    jsr PRINT_LIB.print_char  // TOP RIGHT PRINTED


    /* PRINT BOTTOM LEFT*/
    inc SCREEN_ROW_POS  // increment one ROW
    dec SCREEN_COL_POS  // decrement a col
    lda TILE_TEMP_X     // get again X value ( offset )
    tax                 // get again the value of X
    inx                 // move to third char of tail
    stx TILE_TEMP_X     // save again the current X index

    lda TILESET_ADDRESS,x  // access to third char
    sta SCREEN_CHAR      
    tax                    // set offset to X
    lda CHARSET_ATTRIB_ADDRESS,x  //In this position is the color of this char
    sta SCREEN_CHAR_COLOR
    jsr PRINT_LIB.print_char  // TOP RIGHT PRINTED


    /* PRINT BOTTOM RIGHT */
    inc SCREEN_COL_POS                // increment a col 
    ldx TILE_TEMP_X
    inx                               // increment X to four (last) char in tail
    lda TILESET_ADDRESS,x             // access to third char
    sta SCREEN_CHAR      
    tax // put on X the value of char ( if char == 67 , X = 67 . Offset = 67 )
    lda CHARSET_ATTRIB_ADDRESS,x  //In this position is the color of this char
    sta SCREEN_CHAR_COLOR
    jsr PRINT_LIB.print_char  // BOTTOM RIGHT PRINTED



    pull_regs_from_stack()
rts
    



}