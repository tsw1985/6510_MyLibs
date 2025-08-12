jsr SPRITE_LIB.show_sprite

start_read_joystick:

    //lda #$00c1   // FRAME 1
    //sta $07f8

    /* clean screen */
    //jsr PRINT_LIB.clean_screen
    jsr sleep_sprite

    //lda #$00c0   // FRAME 0
    //sta $07f8

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
    push_regs_to_stack()
    //insert_text(2,10,joystick_up_str,WHITE)

    dec $d001 /* sprite 0 */
    dec $d003 /* sprite 1 */

    pull_regs_from_stack()
    rts
    
joy_down:
    push_regs_to_stack()
    //insert_text(6,10,joystick_down_str,WHITE)
    inc $d001
    inc $d003


    pull_regs_from_stack()
    rts
    
joy_left:
    push_regs_to_stack()
    //insert_text(4,4,joystick_left_str,WHITE)
    dec $d000
    dec $d002
    pull_regs_from_stack()
    rts
    
joy_right:
    push_regs_to_stack()
    //insert_text(4,15,joystick_right_str,WHITE)
    inc $d000
    inc $d002
    pull_regs_from_stack()
    rts

joy_fire:
    push_regs_to_stack()
    //insert_text(2,10,joystick_fire_str,WHITE)
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

