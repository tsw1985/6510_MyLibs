SPRITE_LIB:
{

    show_sprite:
        push_regs_to_stack()

        //insert_text(2,5,sprite_hello_str,RED)

        // ----- Set up sprite 0 -----
        
        // Sprite 0 X-pos
        lda #160
        sta $d000
        
        // Sprite 0 Y-pos
        lda #130
        sta $d001

        
        lda #BROWN
        sta $d025 //$d026 // Sprite extra color 1

        lda #YELLOW
        sta $d026 //$d027 // Sprite extra color 1
        

        /*lda #LIGHT_BLUE
		sta $d022 // Screen extra color 1

		lda #BROWN
		sta $d023 // Screen extra color 2*/


        // ----- Load sprite 0 -----
        lda #$00c0
        sta $07f8
        
        // Sprite 0 color
        lda #WHITE
        sta $d027

        // Load Sprite 0
        lda #%00000001 
        sta $d01c // Sprite multicolor

        // Enable sprites
	    lda #%00000001 // Sprite 0 and sprite
	    sta $d015 // Enable sprite


        pull_regs_from_stack()
        rts

}