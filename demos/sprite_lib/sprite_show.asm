insert_text(2,5,sprite_hello_str,YELLOW)

/* Global */
sprite_set_extra_colors(GRAY,YELLOW)

// Enable sprites
sprite_enable_sprite(0)
sprite_enable_sprite(1)

/* Setup for sprite 0 */
sprite_load_like_multicolor(0)
sprite_set_position(0,160,130)
sprite_set_color(0,WHITE)
sprite_set_frame_to_sprite($00c0,0) // $00c0 ... $00c1 ... $00c2 ...
/* Setup for sprite 0 */

/* Setup for sprite 1 */
sprite_load_like_multicolor(1)
sprite_set_position(1,254,60)
sprite_set_color(1,GREEN)
sprite_set_frame_to_sprite($00c5,1)
/* Setup for sprite 1 */

/*  RASTER INTERRUPT */
jsr setupRasterInterrupt

simulate_game_loop:
    jsr start_read_joystick
jmp simulate_game_loop


start_read_joystick:

    push_regs_to_stack()

    /* clean screen */
    jsr sleep_sprite

    /* read joystick positions */
    jsr JOYSTICK_LIB.read_joystick

    /* actions in each joystick position */

    lda JOYSTICK_POSITIONS
    and #%00000100
    beq check_joy_right 
    jsr joy_left

    check_joy_right:
        lda JOYSTICK_POSITIONS
        and #%00001000  
        beq check_joy_up
        jsr joy_right

    check_joy_up:
        lda JOYSTICK_POSITIONS
        and #%00000001
        beq check_joy_down
        jsr joy_up

    check_joy_down:
        lda JOYSTICK_POSITIONS
        and #%00000010
        beq check_joy_fire
        jsr joy_down

    check_joy_fire:
        lda JOYSTICK_POSITIONS
        and #%00010000
        beq end_read_joystick
        jsr joy_fire

    end_read_joystick:

    pull_regs_from_stack()
    rts
    //jmp start_read_joystick


/* 
/////////////////////////////////////////////
                Functions 
/////////////////////////////////////////////
*/
joy_up:
    jsr SPRITE_LIB.sprite_0_decrement_y
    //jsr SPRITE_LIB.sprite_1_decrement_y
    rts
    
joy_down:
    jsr SPRITE_LIB.sprite_0_increment_y
    //jsr SPRITE_LIB.sprite_1_increment_y
    rts
    
joy_left:
    jsr SPRITE_LIB.sprite_0_decrement_x
    //jsr SPRITE_LIB.sprite_1_decrement_x
    rts
    
joy_right:
    jsr SPRITE_LIB.sprite_0_increment_x
    //jsr SPRITE_LIB.sprite_1_increment_x
    rts

joy_fire:
    push_regs_to_stack()
    insert_text(2,10,joystick_fire_str,WHITE)
    pull_regs_from_stack()
    rts

sleep_sprite:

    push_regs_to_stack()

    ldx #50
    sleep_sprite_outer_loop:
        ldy #50
    sleep_sprite_inner_loop:
        nop
        dey
        bne sleep_sprite_inner_loop
        dex
        bne sleep_sprite_outer_loop
        
    pull_regs_from_stack()

rts    


setupRasterInterrupt:

    push_regs_to_stack()

    sei // Disable system interrupts

    lda #%01111111 // Turn off the CIA timer interrupt
    sta INTERRUPT_CONTROL_AND_STATUS1 // $dc0d
    sta INTERRUPT_CONTROL_AND_STATUS2 // $dd0d

    // Setup Raster Interrupt

    lda #%01111111 // Clear high bit of raster line
    and SCREEN_CONTROL_1 // $d011
    sta SCREEN_CONTROL_1 // $d011

    lda #250 // Set raster interrupt to trigger on line 250
    sta CURRENT_RASTER_LINE // $d012

    lda #<actions_in_raster // Set pointer for raster interrupt
    sta INTERRUPT_EXEC_ADDR1_SERVICE // $0314
    lda #>actions_in_raster
    sta INTERRUPT_EXEC_ADDR2_SERVICE // $0315

    lda #%00000001 // Enable raster interrupt
    sta INTERRUPT_CONTROL // $d01a

    cli // Enable system interrupts

    pull_regs_from_stack()
    rts


enableRasterInterrupt:
	lda #%00000101
	sta INTERRUPT_CONTROL
	rts


disableRasterInterrupt:
	lda #%00000100
	sta INTERRUPT_CONTROL
	rts

/* */
actions_in_raster:
		inc INTERRUPT_STATUS // $d019 - Set bit 0 in Interrupt Status Register to acknowledge raster interrupt
		//////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////
		////////////////////*** START INTERRUPT CODE *****////////////////////
		//
            
            inc SPRITE_FRAME_COUNTER
            lda SPRITE_FRAME_COUNTER
            cmp #10
            bne exit_raster_irq

            /* if is X , reset counter and change frame */
            /* reset counter */
            lda #0       
            sta SPRITE_FRAME_COUNTER

            /* change frame */
            /* check current frame */
            lda SPRITE_FRAME_CURRENT
            cmp #1

            /* if frame == 1 , change to 0 */
            beq change_to_frame_0 // == 0

            /* if frame == 0 , change to 1 */
            bne change_to_frame_1
            change_to_frame_1:
                lda #$00c1
                sta $07f8
                lda #1
                sta SPRITE_FRAME_CURRENT
                jmp exit_raster_irq
                
            change_to_frame_0:
                lda #$00c0
                sta $07f8
                lda #0
                sta SPRITE_FRAME_CURRENT

            exit_raster_irq:
                jmp INTERRUPT_RETURN // $ea81 - Return from interrupt
		//
		////////////////////***** END INTERRUPT CODE *****////////////////////
		//////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////


/* SPRITE TABLES */
/*  This 2 tables are main list where are listed all animations. We get the
    HI and LOW bytes to create a address in the ZERO PAGE using: 
    
        ZERO_PAGE_SPRITE_HIGHT_BYTE
        ZERO_PAGE_SPRITE_LOW_BYTE
*/
Sprite_animations_list_LO:
    .byte <Sprite_air_plane_air

Sprite_animations_list_HI:
    .byte >Sprite_air_plane_air

/* Individual animations */
/* Air Plane In air  */
Sprite_air_plane_air:
    .byte 0   // Frame 0 in Sprite pad
    .byte 1   // Frame 1 in Sprite pad
    .byte 2   // Frame 2 in Sprite pad
    .byte 3   // Frame 3 in Sprite pad
    .byte 255 // Finish animation

/* Sprites animations speed */




