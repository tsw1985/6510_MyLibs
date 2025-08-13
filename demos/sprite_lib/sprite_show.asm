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
sprite_set_position(1,50,100)
sprite_set_color(1,GREEN)
sprite_set_frame_to_sprite($00c1,1)
/* Setup for sprite 1 */


start_read_joystick:

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

jmp start_read_joystick


/* 
/////////////////////////////////////////////
                Functions 
/////////////////////////////////////////////
*/
joy_up:
    jsr SPRITE_LIB.sprite_0_decrement_y
    jsr SPRITE_LIB.sprite_1_decrement_y
    rts
    
joy_down:
    jsr SPRITE_LIB.sprite_0_increment_y
    jsr SPRITE_LIB.sprite_1_increment_y
    rts
    
joy_left:
    jsr SPRITE_LIB.sprite_0_decrement_x
    jsr SPRITE_LIB.sprite_1_decrement_x
    rts
    
joy_right:
    jsr SPRITE_LIB.sprite_0_increment_x
    jsr SPRITE_LIB.sprite_1_increment_x
    rts

joy_fire:
    push_regs_to_stack()
    insert_text(2,10,joystick_fire_str,WHITE)
    pull_regs_from_stack()
    rts

sleep_sprite:

    push_regs_to_stack()
    ldx #25
    sleep_sprite_outer_loop:
        ldy #25
    sleep_sprite_inner_loop:
        nop
        dey
        bne sleep_sprite_inner_loop
        dex
        bne sleep_sprite_outer_loop
        
        pull_regs_from_stack()
rts    

