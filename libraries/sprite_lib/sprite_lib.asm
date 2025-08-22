#import "sprite_macros/sprite_lib_macros.asm"

SPRITE_LIB:
{
    /*
        This functions increment and decrement de X and Y position for each
        sprite. 0 to 7 ( 8 Sprites )
    */
    /* ROW -- */
    sprite_0_decrement_x:
        push_regs_to_stack()
        ldx #0
        dec sprites_coord_table_x,x
        dec $d000
        pull_regs_from_stack()
        rts

    sprite_1_decrement_x:
        push_regs_to_stack()
        ldx #1
        dec sprites_coord_table_x,x
        dec $d002
        pull_regs_from_stack()
        rts

    sprite_2_decrement_x:
        push_regs_to_stack()
        ldx #2
        dec sprites_coord_table_x,x
        dec $d004
        pull_regs_from_stack()
        rts

    sprite_3_decrement_x:
        push_regs_to_stack()
        ldx #3
        dec sprites_coord_table_x,x
        dec $d006
        pull_regs_from_stack()
        rts

    sprite_4_decrement_x:
        push_regs_to_stack()
        ldx #4
        dec sprites_coord_table_x,x
        dec $d008
        pull_regs_from_stack()
        rts

    sprite_5_decrement_x:
        push_regs_to_stack()
        ldx #5
        dec sprites_coord_table_x,x
        dec $d00a
        pull_regs_from_stack()
        rts

    sprite_6_decrement_x:
        push_regs_to_stack()
        ldx #6
        dec sprites_coord_table_x,x
        dec $d00c
        pull_regs_from_stack()
        rts

    sprite_7_decrement_x:
        push_regs_to_stack()
        ldx #7
        dec sprites_coord_table_x,x
        dec $d00e
        pull_regs_from_stack()
        rts

    /* ROW ++ */
    sprite_0_increment_x:
        push_regs_to_stack()
        ldx #0
        inc sprites_coord_table_x,x
        inc $d000
        pull_regs_from_stack()
        rts

    sprite_1_increment_x:
        push_regs_to_stack()
        ldx #1
        inc sprites_coord_table_x,x
        inc $d002
        pull_regs_from_stack()
        rts

    sprite_2_increment_x:
        push_regs_to_stack()
        ldx #2
        inc sprites_coord_table_x,x
        inc $d004
        pull_regs_from_stack()
        rts

    sprite_3_increment_x:
        push_regs_to_stack()
        ldx #3
        inc sprites_coord_table_x,x
        inc $d006
        pull_regs_from_stack()
        rts
    
    sprite_4_increment_x:
        push_regs_to_stack()
        ldx #4
        inc sprites_coord_table_x,x
        inc $d008
        pull_regs_from_stack()
        rts

    sprite_5_increment_x:
        push_regs_to_stack()
        ldx #5
        inc sprites_coord_table_x,x
        inc $d00a
        pull_regs_from_stack()
        rts

    sprite_6_increment_x:
        push_regs_to_stack()
        ldx #6
        inc sprites_coord_table_x,x
        inc $d00c
        pull_regs_from_stack()
        rts

    sprite_7_increment_x:
        push_regs_to_stack()
        ldx #7
        inc sprites_coord_table_x,x
        inc $d00e
        pull_regs_from_stack()
        rts

    
    /* COL -- */
    sprite_0_decrement_y:
        push_regs_to_stack()
        ldx #0
        dec sprites_coord_table_y,x
        dec $d001
        pull_regs_from_stack()
        rts


    sprite_1_decrement_y:
        push_regs_to_stack()
        ldx #1
        dec sprites_coord_table_y,x
        dec $d003
        pull_regs_from_stack()
        rts
    
    sprite_2_decrement_y:
        push_regs_to_stack()
        ldx #2
        dec sprites_coord_table_y,x
        dec $d005
        pull_regs_from_stack()
        rts
    
    sprite_3_decrement_y:
        push_regs_to_stack()
        ldx #3
        dec sprites_coord_table_y,x
        dec $d007
        pull_regs_from_stack()
        rts
    sprite_4_decrement_y:
        push_regs_to_stack()
        ldx #4
        dec sprites_coord_table_y,x
        dec $d009
        pull_regs_from_stack()
        rts
    
    sprite_5_decrement_y:
        push_regs_to_stack()
        ldx #5
        dec sprites_coord_table_y,x
        dec $d00b
        pull_regs_from_stack()
        rts

    sprite_6_decrement_y:
        push_regs_to_stack()
        ldx #6
        dec sprites_coord_table_y,x
        dec $d00d
        pull_regs_from_stack()
        rts
    
    sprite_7_decrement_y:
        push_regs_to_stack()
        ldx #7
        dec sprites_coord_table_y,x
        dec $d00f
        pull_regs_from_stack()
    rts

    /* COL ++ */
    sprite_0_increment_y:
        push_regs_to_stack()
        ldx #0
        inc sprites_coord_table_y,x
        inc $d001
        pull_regs_from_stack()
    rts

    sprite_1_increment_y:
        push_regs_to_stack()
        ldx #1
        inc sprites_coord_table_y,x
        inc $d003
        pull_regs_from_stack()
    rts

    sprite_2_increment_y:
        push_regs_to_stack()
        ldx #2
        inc sprites_coord_table_y,x
        inc $d005
        pull_regs_from_stack()
    rts

    sprite_3_increment_y:
        push_regs_to_stack()
        ldx #3
        inc sprites_coord_table_y,x
        inc $d007
        pull_regs_from_stack()
    rts

    sprite_4_increment_y:
        push_regs_to_stack()
        ldx #4
        inc sprites_coord_table_y,x
        inc $d009
        pull_regs_from_stack()
    rts

    sprite_5_increment_y:
        push_regs_to_stack()
        ldx #5
        inc sprites_coord_table_y,x
        inc $d00b
        pull_regs_from_stack()
    rts

    sprite_6_increment_y:
        push_regs_to_stack()
        ldx #6
        inc sprites_coord_table_y,x
        inc $d00d
        pull_regs_from_stack()
    rts

    sprite_7_increment_y:
        push_regs_to_stack()
        ldx #7
        inc sprites_coord_table_y,x
        inc $d00f
        pull_regs_from_stack()
    rts


/*
    Enable sprite : 
    --------------
        IN : SPRITE_TO_ENABLE in binary
        Each bit in 1 means sprite to enable

*/
enable_sprite:

    push_regs_to_stack()

    lda $d015             // position to enable - disable sprites
    ora SPRITE_TO_ENABLE  // set to 1 the target sprites
    sta $d015             // save the enables sprites

    pull_regs_from_stack()
    rts

/*
    Disable sprite : 
    ----------------
        IN : SPRITE_TO_ENABLE in binary
        Each bit in 0 means sprite to disable

*/
disable_sprite:
    push_regs_to_stack()
    lda $d015             // position to enable - disable sprites
    and SPRITE_TO_ENABLE  // set to 0 the target sprites
    sta $d015             // save the enables sprites
    pull_regs_from_stack()
    rts

/*
    Set frames to sprites:
    ----------------------
        
        This function set a sprite data pointer ( where is the sprite picture
        data) to a sprite target

        IN: SPRITE_FRAME_POINTER ( address where is the sprite draw data)
        Each address : $07f8 , $07f9 , $07fa ... this is the pointer (address) 
        to set wich image to load for each sprite
*/
set_frame_to_sprite_0:
    push_regs_to_stack()
    lda SPRITE_FRAME_POINTER
    sta $07f8   
    pull_regs_from_stack()
    rts

set_frame_to_sprite_1:
    push_regs_to_stack()
    lda SPRITE_FRAME_POINTER
    sta $07f9
    pull_regs_from_stack()
    rts

set_frame_to_sprite_2:
    push_regs_to_stack()
    lda SPRITE_FRAME_POINTER
    sta $07fa
    pull_regs_from_stack()
    rts

set_frame_to_sprite_3:
    push_regs_to_stack()
    lda SPRITE_FRAME_POINTER
    sta $07fb
    pull_regs_from_stack()
    rts

set_frame_to_sprite_4:
    push_regs_to_stack()
    lda SPRITE_FRAME_POINTER
    sta $07fc
    pull_regs_from_stack()
    rts

set_frame_to_sprite_5:
    push_regs_to_stack()
    lda SPRITE_FRAME_POINTER
    sta $07fd
    pull_regs_from_stack()
    rts

set_frame_to_sprite_6:
    push_regs_to_stack()
    lda SPRITE_FRAME_POINTER
    sta $07fe
    pull_regs_from_stack()
    rts

set_frame_to_sprite_7:
    push_regs_to_stack()
    lda SPRITE_FRAME_POINTER
    sta $07ff
    pull_regs_from_stack()
    rts



/* 

Function:

Get SPRITE_PAD index in a sprite animation. A animation is a list of bytes.
Each byte have a value, this value is a INDEX in the spritepad program pallete.

For example, we have a list of frames to play the animation. This animation is
a player jump. This secuence are the frames : 0-1-2-3 and the value 255 means
"end of animation".

So, with this function we access to this value in this list. Imagine this like
a List.

    int[] player_jump = new int[3];
    player_jump[0] = 1  // Frame 1 ...
    player_jump[1] = 2  // Frame 2 ...
    player_jump[2] = 3  // Frame 3 ...
    player_jump[3] = 255

    PARAMS:
    =======

        IN:
            ANIMATION_FRAMES_LIST_LO: Low byte of this animation list
            ANIMATION_FRAMES_LIST_HI: Hight byte of this animation list
            SPRITE_ANIMATION_VALUE_OFFSET: Index position in this list

            SPRITE_INDEX_COUNTER_RASTER_LOOP

        OUT:
            SPRITE_PAD_INDEX: The value in this list for the given index.

 */ 
sprite_get_current_index_sprite_pad_value_animation:

    push_regs_to_stack()

    /*lda ANIMATION_FRAMES_LIST_LO
    sta ZERO_PAGE_SPRITE_LOW_BYTE

    lda ANIMATION_FRAMES_LIST_HI
    sta ZERO_PAGE_SPRITE_HIGHT_BYTE*/

    ldx SPRITE_INDEX_COUNTER_RASTER_LOOP
    lda sprite_current_anim_LO_table,x
    sta ZERO_PAGE_SPRITE_LOW_BYTE

    lda sprite_current_anim_HI_table,x
    sta ZERO_PAGE_SPRITE_HIGHT_BYTE



    ldy SPRITE_ANIMATION_VALUE_OFFSET //This value move to the right X positions
                                      //in the current sprite_animation list.

                  //Is like do in a array -> array[SPRITE_ANIMATION_VALUE_OFFSET
                  //This value is saved in Y register and used in the custom 
                  //address created using the ZERO_PAGE bellow


    lda (ZERO_PAGE_SPRITE_LOW_BYTE),y // get the value of this item in the list
                                      // using a INDIRECT ADDRESSING with the ZP 
    sta SPRITE_PAD_INDEX    // returned value wich contains the value of the
                            // target sprite into the sprite pad pallete

    pull_regs_from_stack()
    rts


















    
}