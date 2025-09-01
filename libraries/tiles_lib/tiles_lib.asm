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


/* 

    Load a MAP in screen.

    IN :
        MAP_NUMBER

Access to the MAP. Each Map its a section of 16 tiles width x 12 tiles height
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

load_map:

    push_regs_to_stack()

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
        lda (ZERO_PAGE_MAP_LO),y //In this position + Y offset we are retrieving
                                 //the tail to print   

        sta TILE_NUMBER  // Set the number of tile to print
        jsr TILES_LIB.print_tile

        iny
        cpy #192 // ( 16 x 12 = 192 ) // Check a MAP section, it is 192 bytes
                                        // of length

        beq exit_load_map // If we reach 192 bytes, this means we retrieve all
                          // map data

        inc TILE_COL  // Increment 2 chars to right
        inc TILE_COL  // Increment 2 chars to right
        lda TILE_COL  // Save the value incremented in column
        cmp #33   // Limit visible cols. The max length to move a sprite to 
                  // right , is 255, then we have a "free space" on the right
                  // of screen. We are using this space for data gaming


        bne next_tail // if the current col printing is not 33 we keep printing

        // When is the final printable col, we must reset the TILE_COL to 1 
        // and increments 2 columns. Remember: each tile is 2 chars, so you need
        // move 2 chars down

        lda #1                //if is the COL LIMIT , set to 1 again the col
        sta TILE_COL
        inc TILE_ROW
        inc TILE_ROW
        jmp next_tail
        
    exit_load_map:

pull_regs_from_stack()
rts
    



}
