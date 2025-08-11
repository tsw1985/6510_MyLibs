.macro read_joystick(up_func,down_func,left_func,right_func,fire_func){

    //read_stick:

        input_left_check:
            lda #%00000100        // mask left movement
            bit $DC00             // bitwise "and" with joystick port 1
            bne input_right_check // if not active (==1),go to input_right_check
            jsr left_func//joy_left
        
        input_right_check:
            lda #%00001000        // mask left movement (8 == bit 4 == )
            bit $DC00             // bitwise "and" with joystick port 1
            bne input_up_check    // if not active (==1), go to .input_up_check
            jsr right_func //joy_right
        
        input_up_check:
            lda #%00000001         // mask left movement (1 == bit 1 == )
            bit $DC00              // bitwise "and" with joystick port 1
            bne input_down_check   // if not active (==1),goto input_down_check
            jsr up_func //joy_up
        
        input_down_check:
            lda #%00000010         // mask left movement (2 == bit 2 == )
            bit $DC00              // bitwise "and" with joystick port 1
            bne input_fire_check   // if not active (==1), go to fire_check
            jsr down_func //joy_down
        
        input_fire_check:
            lda #%00010000         // mask left movement (16 == bit 5 == )
            bit $DC00              // bitwise "and" with joystick port 1
            bne finish_read_stick  // if not active (==1),go to finish checking
            jsr fire_func //joy_fire

        finish_read_stick:
        //    jmp read_stick         // go back to read_stick

}