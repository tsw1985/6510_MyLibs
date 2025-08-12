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





    /*++++++++++++++++++++++ Y *************************/
    /* ROW -- */
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

    /* ROW ++ */
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




}