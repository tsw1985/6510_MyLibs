/*
    Set sprite position : sprite, col , row
    ---------------------------------------
*/
.macro sprite_set_position( sprite_number, col, row){

    // Sprite Y-pos
    lda #col

    .if(sprite_number == 0){
        ldx #0
        sta sprites_coord_table_y,x
        sta $d001
    }
    .if(sprite_number == 1){
        ldx #1
        sta sprites_coord_table_y,x
        sta $d003
    }
    .if(sprite_number == 2){
        ldx #2
        sta sprites_coord_table_y,x
        sta $d005
    }
    .if(sprite_number == 3){
        ldx #3
        sta sprites_coord_table_y,x
        sta $d007
    }
    .if(sprite_number == 4){
        ldx #4
        sta sprites_coord_table_y,x
        sta $d009
    }
    .if(sprite_number == 5){
        ldx #5
        sta sprites_coord_table_y,x
        sta $d00b
    }
    .if(sprite_number == 6){
        ldx #6
        sta sprites_coord_table_y,x
        sta $d00d
    }
    .if(sprite_number == 7){
        ldx #7
        sta sprites_coord_table_y,x
        sta $d00f
    }


    // Sprite X-pos
    lda #row

    .if(sprite_number == 0){
        ldx #0
        sta sprites_coord_table_x,x
        sta $d000
    }
    .if(sprite_number == 1){
        ldx #1
        sta sprites_coord_table_x,x
        sta $d002
    }
    .if(sprite_number == 2){
        ldx #2
        sta sprites_coord_table_x,x
        sta $d004
    }
    .if(sprite_number == 3){
        ldx #3
        sta sprites_coord_table_x,x
        sta $d006
    }
    .if(sprite_number == 4){
        ldx #4
        sta sprites_coord_table_x,x
        sta $d008
    }
    .if(sprite_number == 5){
        ldx #5
        sta sprites_coord_table_x,x
        sta $d00a
    }
    .if(sprite_number == 6){
        ldx #6
        sta sprites_coord_table_x,x
        sta $d00c
    }
    .if(sprite_number == 7){
        ldx #7
        sta sprites_coord_table_x,x
        sta $d00e
    }


    

}

/*
    Set global sprite multicolors: color_one , color_two
    ----------------------------------------------------
*/
.macro sprite_set_extra_colors(color_one,color_two){

    lda #color_one
    sta $d025 // Sprite extra color 1

    lda #color_two
    sta $d026 // Sprite extra color 2

}

/*
    Set color a sprite
    ------------------
*/
.macro sprite_set_color(sprite_number,color){

    lda #color
    .if( sprite_number == 0 ){
        sta $d027
    }
    .if( sprite_number == 1 ){
        sta $d028
    }
    .if( sprite_number == 2 ){
        sta $d029
    }
    .if( sprite_number == 3 ){
        sta $d02a
    }
    .if( sprite_number == 4 ){
        sta $d02b
    }
    .if( sprite_number == 5 ){
        sta $d02c
    }
    .if( sprite_number == 6 ){
        sta $d02d
    }
    .if( sprite_number == 7 ){
        sta $d02e
    }

}

/* 
    Setup a Sprite like multicolor mode
    -----------------------------------
*/
.macro sprite_load_like_multicolor(sprite_number){

    lda $d01c

    .if( sprite_number == 0 ){
        ora #%00000001
    }
    
    .if( sprite_number == 1 ){
        ora #%00000010
    }

    .if( sprite_number == 2 ){
        ora #%00000100
    }

    .if( sprite_number == 3 ){
        ora #%00001000
    }

    .if( sprite_number == 4 ){
        ora #%00010000 
    }

    .if( sprite_number == 5 ){
        ora #%00100000 
    }

    .if( sprite_number == 6 ){
        ora #%01000000
    }

    .if( sprite_number == 7 ){
        ora #%10000000
    }

    // Load sprite like multicolor
    sta $d01c // Sprite multicolor

}


/*
    Enable ( show - hide ) a sprite
    -------------------------------
*/
.macro sprite_enable_sprite(sprite_number){


    .if( sprite_number == 0 ){
        lda #%00000001
        sta SPRITE_TO_ENABLE
        jsr SPRITE_LIB.enable_sprite
    }
    
    .if( sprite_number == 1 ){
        lda #%00000010
        sta SPRITE_TO_ENABLE
        jsr SPRITE_LIB.enable_sprite
    }

    .if( sprite_number == 2 ){
        lda #%00000100
        sta SPRITE_TO_ENABLE
        jsr SPRITE_LIB.enable_sprite
    }

    .if( sprite_number == 3 ){
        lda #%00001000
        sta SPRITE_TO_ENABLE
        jsr SPRITE_LIB.enable_sprite
    }

    .if( sprite_number == 4 ){
        lda #%00010000 
        sta SPRITE_TO_ENABLE
        jsr SPRITE_LIB.enable_sprite
    }

    .if( sprite_number == 5 ){
        lda #%00100000 
        sta SPRITE_TO_ENABLE
        jsr SPRITE_LIB.enable_sprite
    }

    .if( sprite_number == 6 ){
        lda #%01000000
        sta SPRITE_TO_ENABLE
        jsr SPRITE_LIB.enable_sprite
    }

    .if( sprite_number == 7 ){
        lda #%10000000
        sta SPRITE_TO_ENABLE
        jsr SPRITE_LIB.enable_sprite
    }
   
}

/*
    Disable ( show - hide ) a sprite
    --------------------------------
    IN: SPRITE_TO_ENABLE
        This variable will contains the sprites to enable in binary
*/
.macro sprite_disable_sprite(sprite_number){

    .if(sprite_number == 0){
        lda #%11111110
        sta SPRITE_TO_ENABLE
        jsr SPRITE_LIB.disable_sprite
    }
    
    .if(sprite_number == 1){
        lda #%11111101
        sta SPRITE_TO_ENABLE
        jsr SPRITE_LIB.disable_sprite
    }

    .if(sprite_number == 2){
        lda #%11111011
        sta SPRITE_TO_ENABLE
        jsr SPRITE_LIB.disable_sprite
    }

    .if(sprite_number == 3){
        lda #%11110111
        sta SPRITE_TO_ENABLE
        jsr SPRITE_LIB.disable_sprite
    }

    .if(sprite_number == 4){
        lda #%11101111  
        sta SPRITE_TO_ENABLE
        jsr SPRITE_LIB.disable_sprite
    }

    .if(sprite_number == 5){
        lda #%11011111 
        sta SPRITE_TO_ENABLE
        jsr SPRITE_LIB.disable_sprite
    }

    .if(sprite_number == 6){
        lda #%10111111
        sta SPRITE_TO_ENABLE
        jsr SPRITE_LIB.disable_sprite
    }

    .if(sprite_number == 7){
        lda #%01111111
        sta SPRITE_TO_ENABLE
        jsr SPRITE_LIB.disable_sprite
    }

}

/*
    Set a sprite frame in a sprite
    ------------------------------
    IN : SPRITE_FRAME_POINTER
        In this variable we set the address where is the sprite to draw in the
        selected sprite
*/
.macro sprite_set_frame_to_sprite(frame_index,sprite_number){

    .if(sprite_number == 0){
        clc
        lda SPRITE_INDEX_POINTER
        adc #frame_index
        sta SPRITE_FRAME_POINTER
        jsr SPRITE_LIB.set_frame_to_sprite_0
    }
    .if(sprite_number == 1){
        clc
        lda SPRITE_INDEX_POINTER
        adc #frame_index
        sta SPRITE_FRAME_POINTER
        jsr SPRITE_LIB.set_frame_to_sprite_1
    }
    .if(sprite_number == 2){
        clc
        lda SPRITE_INDEX_POINTER
        adc #frame_index
        sta SPRITE_FRAME_POINTER
        jsr SPRITE_LIB.set_frame_to_sprite_2
    }
    .if(sprite_number == 3){
        clc
        lda SPRITE_INDEX_POINTER
        adc #frame_index
        sta SPRITE_FRAME_POINTER
        jsr SPRITE_LIB.set_frame_to_sprite_3
    }
    .if(sprite_number == 4){
        clc
        lda SPRITE_INDEX_POINTER
        adc #frame_index
        sta SPRITE_FRAME_POINTER
        jsr SPRITE_LIB.set_frame_to_sprite_4
    }
    .if(sprite_number == 5){
        clc
        lda SPRITE_INDEX_POINTER
        adc #frame_index
        sta SPRITE_FRAME_POINTER
        jsr SPRITE_LIB.set_frame_to_sprite_5
    }
    .if(sprite_number == 6){
        clc
        lda SPRITE_INDEX_POINTER
        adc #frame_index
        sta SPRITE_FRAME_POINTER
        jsr SPRITE_LIB.set_frame_to_sprite_6
    }
    .if(sprite_number == 7){
        clc
        lda SPRITE_INDEX_POINTER
        adc #frame_index
        sta SPRITE_FRAME_POINTER
        jsr SPRITE_LIB.set_frame_to_sprite_7
    }
}