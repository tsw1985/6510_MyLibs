#import "tiles_macros/tiles_lib_macros.asm"

TILES_LIB:
{

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

    /* PRINT TOP LEFT */
    /* Set col */
    lda TILE_ROW
    sta SCREEN_ROW_POS

    lda TILE_COL
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


/* Load a MAP in screen.

    IN :
        MAP_NUMBER
 */
load_map:
push_regs_to_stack()


/* Access to the MAP. Each Map its a section of 16 tiles width x 12 tiles height
Each Tile is 4 bytes , so each map is (16x12) x 4 bytes each tile = 192 bytes.

To access to the first byte of each MAP , we have the table "map_table.asm",
where we get the LOW and HIGHT byte of that memory address using this formula:

    .byte <(MAP_ADDRESS + (MAP_SIZE * ROOM_NUMBER )).

If you see the code , you will see a list from 0 to 63 , because remember, there
are 64 maps.


Finally, if you use the VICE MONITOR and inspect the memory in the MAP_ADDRESS
you will see a list of bytes. Each byte means the TILE to load. In this case, 
remember, we are using MAPS of 16x12 tiles = 192 bytes . So you need print in
screen 192 tiles. Each value here is the TILE to print, it is the index in the
pallette "Tail Set" in the program CHARPAD
*/


   // The first step we must to do is get the LO and HI byte of start address of
   // this room.
   ldx MAP_NUMBER
    
   lda Map_LO,x
   sta ZERO_PAGE_MAP_LO //access to the first LO byte and save it in ZERO_PAGE

   lda Map_HI,x
   sta ZERO_PAGE_MAP_HI //access to the first HI byte and save it in ZERO_PAGE

   // In this point we have the address saved into the ZERO PAGE:
   // ( ZERO_PAGE_MAP_LO + ZERO_PAGE_MAP_HI)


   //Now we must load each tile. Starting by ROWS and COLS using 2 nested loops.
   //This is like to use two for loops:
   // for(int i=0; i<16; i++)
      // for(int j=0; j<12 ; j++)

      //set ROW and COL to 1 - 1

      lda #1
      sta TILE_ROW // Row for tile
      sta TILE_COL // Col for tile  

      ldy #0
      next_tail:  

        // Access to TAIL VALUE
        lda (ZERO_PAGE_MAP_LO),y
        sta TILE_NUMBER  // Number of tile
        jsr TILES_LIB.print_tile

        iny
        cpy #192 // ( 16 x 12 = 192 )
        beq exit_load_map

        inc TILE_COL
        inc TILE_COL
        lda TILE_COL
        cmp #33 // Limit visible cols
        bne next_tail // si no es igual al final, sigo contando

        //si es el final, pongo col a 1 y bajo 2 row

        lda #1                //if is the COL LIMIT , set to 1 again the col
        sta TILE_COL
        inc TILE_ROW
        inc TILE_ROW
        jmp next_tail
        
    exit_load_map:

pull_regs_from_stack()
rts
    



}
