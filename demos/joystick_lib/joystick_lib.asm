start_read_joystick:

    /* clean screen */
    jsr PRINT_LIB.clean_screen
    insert_text(1,1,sprites_colls_demo_str,YELLOW)

    /* read joystick positions */
    jsr JOYSTICK_LIB.read_joystick

    /* actions in each joystick position */
    lda JOYSTICK_POSITIONS
    and #%00000100
    beq check_joy_right 
    jsr joy_left

    check_joy_right:
        lda JOYSTICK_POSITIONS
        and #JOY_GO_RIGHT
        beq check_joy_up
        jsr joy_right

    check_joy_up:
        lda JOYSTICK_POSITIONS
        and #JOY_GO_UP
        beq check_joy_down
        jsr joy_up

    check_joy_down:
        lda JOYSTICK_POSITIONS
        and #JOY_GO_DOWN
        beq check_joy_fire
        jsr joy_down

    check_joy_fire:
        lda JOYSTICK_POSITIONS
        and #JOY_GO_FIRE
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
    insert_text(2,10,joystick_up_str,WHITE)
    pull_regs_from_stack()
    rts
    
joy_down:
    push_regs_to_stack()
    insert_text(6,10,joystick_down_str,WHITE)
    pull_regs_from_stack()
    rts
    
joy_left:
    push_regs_to_stack()
    insert_text(4,4,joystick_left_str,WHITE)
    pull_regs_from_stack()
    rts
    
joy_right:
    push_regs_to_stack()
    insert_text(4,15,joystick_right_str,WHITE)
    pull_regs_from_stack()
    rts

joy_fire:
    push_regs_to_stack()
    insert_text(2,10,joystick_fire_str,WHITE)
    pull_regs_from_stack()
    rts