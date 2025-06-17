
read_joystick:


    push_regs_to_stack()    
    insert_text(1,1,joystick_str,WHITE)

    read_stick:

        jsr PRINT_LIB.clean_screen


        input_left_check:
            lda #$04                // mask left movement (4 == bit 3 == %0000 0100)
            bit $DC00               // bitwise "and" with joystick port 1
            bne input_right_check   // if not active (==1), go to .input_right_check
            jsr joy_left
        
        input_right_check:
            lda #$08                // mask left movement (8 == bit 4 == %0000 1000)
            bit $DC00               // bitwise "and" with joystick port 1
            bne input_up_check      // if not active (==1), go to .input_up_check
            jsr joy_right
        
        input_up_check:
            lda #$01                // mask left movement (1 == bit 1 == %0000 0001)
            bit $DC00               // bitwise "and" with joystick port 1
            bne input_down_check    // if not active (==1), go to .input_down_check
            jsr joy_up
        
        input_down_check:
            lda #$02                // mask left movement (2 == bit 2 == %0000 0010)
            bit $DC00               // bitwise "and" with joystick port 1
            bne input_fire_check    // if not active (==1), go to .input_fire_check
            jsr joy_down
        
        
        input_fire_check:
            lda #$10                // mask left movement (16 == bit 5 == %0001 0000)
            bit $DC00               // bitwise "and" with joystick port 1
            bne finish_read_stick   // if not active (==1), go back to .input_left_check
            jsr joy_fire

    finish_read_stick:
        jmp read_stick              // go back to read_stick



        /* Functions */
        joy_none:        
            push_regs_to_stack()
            insert_text(2,10,joystick_no_move_str,WHITE)
            pull_regs_from_stack()
            rts

        joy_up:
            push_regs_to_stack()
            insert_text(2,10,joystick_up_str,WHITE)
            pull_regs_from_stack()
            rts
            
        joy_down:
            push_regs_to_stack()
            insert_text(2,10,joystick_down_str,WHITE)
            pull_regs_from_stack()
            rts
            
        joy_left:
            push_regs_to_stack()
            insert_text(2,10,joystick_left_str,WHITE)
            pull_regs_from_stack()
            rts
            
        joy_right:
            push_regs_to_stack()
            insert_text(2,10,joystick_right_str,WHITE)
            pull_regs_from_stack()
            rts
        
        joy_fire:
            push_regs_to_stack()
            insert_text(2,10,joystick_fire_str,WHITE)
            pull_regs_from_stack()
            rts
            



    wait_key:
        jsr $ffe4       // GETIN
        cmp #0
        beq wait_key    // si no se ha pulsado tecla, repetir
    pull_regs_from_stack()

rts