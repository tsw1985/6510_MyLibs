#import "sprite_macros/sprite_lib_macros.asm"

SPRITE_LIB:
{

    show_sprite:
        push_regs_to_stack()

        //insert_text(2,5,sprite_hello_str,RED)

        // ----- Set up sprite 0 -----
        
        // Sprite 0 X-pos
        /*lda #160
        sta $d000
        
        // Sprite 0 Y-pos
        lda #130
        sta $d001*/
        sprite_set_position(0,160,130)

        
        /*lda #BROWN
        sta $d025 //$d026 // Sprite extra color 1

        lda #YELLOW
        sta $d026 //$d027 // Sprite extra color 1*/
        sprite_set_extra_colors(GRAY,YELLOW)
        
        // Sprite 0 color
        /*lda #WHITE
        sta $d027*/
        sprite_set_color(0,WHITE)

        // Load Sprite 0
        lda #$00c0 // FRAME 0
        //lda #$00c1   // FRAME 1
        sta $07f8
        

        /*
        lda #%00000001 
        sta $d01c // Sprite multicolor
        */
        sprite_load_like_multicolor(0)

        // Enable sprites
	    /*lda #%00000001 // Sprite 0 and sprite
	    sta $d015 // Enable sprite*/
        sprite_enable_sprite(0)



        pull_regs_from_stack()
        rts

}