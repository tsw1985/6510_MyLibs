/*
    Set sprite position : sprite, col , row
*/
.macro sprite_set_position( sprite_number, col, row){

    // Sprite 0 Y-pos
    lda #row
    .if(sprite_number == 0){
        sta $d001
    }
    .if(sprite_number == 1){
        sta $d003
    }
    .if(sprite_number == 2){
        sta $d005
    }
    .if(sprite_number == 3){
        sta $d007
    }
    .if(sprite_number == 4){
        sta $d009
    }
    .if(sprite_number == 5){
        sta $d00b
    }
    .if(sprite_number == 6){
        sta $d00d
    }
    .if(sprite_number == 7){
        sta $d00f
    }


    // Sprite 0 X-pos
    lda #col
    .if(sprite_number == 0){
        sta $d000
    }
    .if(sprite_number == 1){
        sta $d002
    }
    .if(sprite_number == 2){
        sta $d004
    }
    .if(sprite_number == 3){
        sta $d006
    }
    .if(sprite_number == 4){
        sta $d008
    }
    .if(sprite_number == 5){
        sta $d00a
    }
    .if(sprite_number == 6){
        sta $d00c
    }
    .if(sprite_number == 7){
        sta $d00e
    }

}

/*
    Set global sprite multicolors: color_one , color_two
*/
.macro sprite_set_extra_colors(color_one,color_two){

    lda #color_one
    sta $d025 //$d026 // Sprite extra color 1

    lda #color_two
    sta $d026 //$d027 // Sprite extra color 2

}

/*
    Set color a sprite
*/
.macro sprite_set_color(sprite_number,color){

    lda #color
    .if( sprite_number == 0){
        sta $d027
    }
    .if( sprite_number == 1){
        sta $d028
    }
    .if( sprite_number == 2){
        sta $d029
    }
    .if( sprite_number == 3){
        sta $d02a
    }
    .if( sprite_number == 4){
        sta $d02b
    }
    .if( sprite_number == 5){
        sta $d02c
    }
    .if( sprite_number == 6){
        sta $d02d
    }
    .if( sprite_number == 7){
        sta $d02e
    }

}

/* 
    Setup a Sprite like multicolor mode
*/
.macro sprite_load_like_multicolor(sprite_number){

    lda $d01c

    .if(sprite_number == 0){
        ora #%00000001
    }
    
    .if(sprite_number == 1){
        ora #%00000010
    }

    .if(sprite_number == 2){
        ora #%00000100
    }

    .if(sprite_number == 3){
        ora #%00001000
    }

    .if(sprite_number == 4){
        ora #%00010000 
    }

    .if(sprite_number == 5){
        ora #%00100000 
    }

    .if(sprite_number == 6){
        ora #%01000000
    }

    .if(sprite_number == 7){
        ora #%10000000
    }

    // Load sprite like multicolor
    sta $d01c // Sprite multicolor

}


/*
    Enable ( show - hide ) a sprite
*/
.macro sprite_enable_sprite(sprite_number){

    // load current sprites
    lda $d015 

    .if(sprite_number == 0){
        ora #%00000001
    }
    
    .if(sprite_number == 1){
        ora #%00000010
    }

    .if(sprite_number == 2){
        ora #%00000100
    }

    .if(sprite_number == 3){
        ora #%00001000
    }

    .if(sprite_number == 4){
        ora #%00010000 
    }

    .if(sprite_number == 5){
        ora #%00100000 
    }

    .if(sprite_number == 6){
        ora #%01000000
    }

    .if(sprite_number == 7){
        ora #%10000000
    }

    // Enable sprite
    sta $d015 
}


/*
    Set a sprite frame in a sprite
*/
.macro sprite_set_frame_to_sprite(frame_index,sprite_number){

    lda #frame_index

    .if(sprite_number == 0){
        sta $07f8
    }
    .if(sprite_number == 1){
        sta $07f9
    }
    .if(sprite_number == 2){
        sta $07fa
    }
    .if(sprite_number == 3){
        sta $07fb
    }
    .if(sprite_number == 4){
        sta $07fc
    }
    .if(sprite_number == 5){
        sta $07fd
    }
    .if(sprite_number == 6){
        sta $07fe
    }
    .if(sprite_number == 7){
        sta $07ff
    }
    
}