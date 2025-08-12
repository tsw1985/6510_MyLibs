/*
    JOYSTICK_POSITIONS : This is the global variable where is set the bits to
                         know with joystick position is used.
*/
JOYSTICK_LIB:
{
    read_joystick:

    push_regs_to_stack()    

    /* reset to 0 current positions in joystick */
    lda #0
    sta JOYSTICK_POSITIONS

    input_left_check:
        lda #%00000100        // mask left movement
        bit $DC00             // bitwise "and" with joystick port 1
        bne input_right_check // if not active (==1),go to input_right_check
        lda JOYSTICK_POSITIONS
        ora #%00000100
        sta JOYSTICK_POSITIONS
    
    input_right_check:
        lda #%00001000        // mask left movement (8 == bit 4 == )
        bit $DC00             // bitwise "and" with joystick port 1
        bne input_up_check    // if not active (==1), go to .input_up_check
        lda JOYSTICK_POSITIONS
        ora #%00001000
        sta JOYSTICK_POSITIONS
    
    input_up_check:
        lda #%00000001         // mask left movement (1 == bit 1 == )
        bit $DC00              // bitwise "and" with joystick port 1
        bne input_down_check   // if not active (==1),goto input_down_check
        lda JOYSTICK_POSITIONS
        ora #%00000001
        sta JOYSTICK_POSITIONS
    
    input_down_check:
        lda #%00000010         // mask left movement (2 == bit 2 == )
        bit $DC00              // bitwise "and" with joystick port 1
        bne input_fire_check   // if not active (==1), go to fire_check
        lda JOYSTICK_POSITIONS
        ora #%00000010
        sta JOYSTICK_POSITIONS
    
    input_fire_check:
        lda #%00010000         // mask left movement (16 == bit 5 == )
        bit $DC00              // bitwise "and" with joystick port 1
        bne finish_read_stick  // if not active (==1),go to finish checking
        lda JOYSTICK_POSITIONS
        ora #%00010000
        sta JOYSTICK_POSITIONS

    finish_read_stick:
        
    pull_regs_from_stack()

rts
}