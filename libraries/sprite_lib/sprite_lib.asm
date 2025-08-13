#import "sprite_macros/sprite_lib_macros.asm"

SPRITE_LIB:
{

    /* ROW -- */
    sprite_0_decrement_x:
        dec $d000
    rts
    sprite_1_decrement_x:
        dec $d002
    rts
    sprite_2_decrement_x:
        dec $d004
    rts
    sprite_3_decrement_x:
        dec $d006
    rts
    sprite_4_decrement_x:
        dec $d008
    rts
    sprite_5_decrement_x:
        dec $d00a
    rts
    sprite_6_decrement_x:
        dec $d00c
    rts
    sprite_7_decrement_x:
        dec $d00e
    rts

    /* ROW ++ */
    sprite_0_increment_x:
        inc $d000
    rts
    sprite_1_increment_x:
        inc $d002
    rts
    sprite_2_increment_x:
        inc $d004
    rts
    sprite_3_increment_x:
        inc $d006
    rts
    sprite_4_increment_x:
        inc $d008
    rts
    sprite_5_increment_x:
        inc $d00a
    rts
    sprite_6_increment_x:
        inc $d00c
    rts
    sprite_7_increment_x:
        inc $d00e
    rts

    /* COL -- */
    sprite_0_decrement_y:
        dec $d001
    rts
    sprite_1_decrement_y:
        dec $d003
    rts
    sprite_2_decrement_y:
        dec $d005
    rts
    sprite_3_decrement_y:
        dec $d007
    rts
    sprite_4_decrement_y:
        dec $d009
    rts
    sprite_5_decrement_y:
        dec $d00b
    rts
    sprite_6_decrement_y:
        dec $d00d
    rts
    sprite_7_decrement_y:
        dec $d00f
    rts

    /* COL ++ */
    sprite_0_increment_y:
        inc $d001
    rts
    sprite_1_increment_y:
        inc $d003
    rts
    sprite_2_increment_y:
        inc $d005
    rts
    sprite_3_increment_y:
        inc $d007
    rts
    sprite_4_increment_y:
        inc $d009
    rts
    sprite_5_increment_y:
        inc $d00b
    rts
    sprite_6_increment_y:
        inc $d00d
    rts
    sprite_7_increment_y:
        inc $d00f
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
}