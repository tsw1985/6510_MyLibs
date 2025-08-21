insert_text(1,1,sprites_speed_demo_str,YELLOW)

/* Global */
sprite_set_extra_colors(GRAY,YELLOW)

// Enable sprites
sprite_enable_sprite(0)
sprite_enable_sprite(1)
sprite_enable_sprite(2)
sprite_enable_sprite(3)
sprite_enable_sprite(4)
sprite_enable_sprite(5)
sprite_enable_sprite(6)
sprite_enable_sprite(7)

/* Setup for sprite 1 */
sprite_load_like_multicolor(0)
sprite_set_position(0,130,40)
sprite_set_color(0,WHITE)
sprite_set_frame_to_sprite(0,0) // $00c0 ... $00c1 ... $00c2 ...
/* Setup for sprite 1 */

/* Setup for sprite 2 */
sprite_load_like_multicolor(1)
sprite_set_position(1,130,70)
sprite_set_color(1,CYAN)
sprite_set_frame_to_sprite(0,1)
/* Setup for sprite 2 */

/* Setup for sprite 3 */
sprite_load_like_multicolor(2)
sprite_set_position(2,130,100)
sprite_set_color(2,YELLOW)
sprite_set_frame_to_sprite(0,2)
/* Setup for sprite 3 */

/* Setup for sprite 4 */
sprite_load_like_multicolor(3)
sprite_set_position(3,130,130)
sprite_set_color(3,BROWN)
sprite_set_frame_to_sprite(0,3)
/* Setup for sprite 4 */

/* Setup for sprite 5 */
sprite_load_like_multicolor(4)
sprite_set_position(4,130,160)
sprite_set_color(4,RED)
sprite_set_frame_to_sprite(0,4)
/* Setup for sprite 5 */

/* Setup for sprite 6 */
sprite_load_like_multicolor(5)
sprite_set_position(5,130,190)
sprite_set_color(5,GRAY)
sprite_set_frame_to_sprite(0,5)
/* Setup for sprite 5 */

/* Setup for sprite 7 */
sprite_load_like_multicolor(6)
sprite_set_position(6,130,220)
sprite_set_color(6,PINK)
sprite_set_frame_to_sprite(0,6)
/* Setup for sprite 7 */

/* Setup for sprite 8 */
sprite_load_like_multicolor(7)
sprite_set_position(7,130,250)
sprite_set_color(7,ORANGE)
sprite_set_frame_to_sprite(0,7)
/* Setup for sprite 8 */

/*  RASTER INTERRUPT */
jsr setupRasterInterrupt


simulate_game_loop:

    cli
        ldx #0 //sprites animation list index
        lda sprite_animations_list_LO_table,x
        sta ANIMATION_FRAMES_LIST_LO

        lda sprite_animations_list_HI_table,x
        sta ANIMATION_FRAMES_LIST_HI
    sei

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
    jsr SPRITE_LIB.sprite_1_decrement_y
    jsr SPRITE_LIB.sprite_2_decrement_y
    jsr SPRITE_LIB.sprite_3_decrement_y
    jsr SPRITE_LIB.sprite_4_decrement_y
    jsr SPRITE_LIB.sprite_5_decrement_y
    jsr SPRITE_LIB.sprite_6_decrement_y
    jsr SPRITE_LIB.sprite_7_decrement_y
    rts
    
joy_down:
    jsr SPRITE_LIB.sprite_0_increment_y
    jsr SPRITE_LIB.sprite_1_increment_y
    jsr SPRITE_LIB.sprite_2_increment_y
    jsr SPRITE_LIB.sprite_3_increment_y
    jsr SPRITE_LIB.sprite_4_increment_y
    jsr SPRITE_LIB.sprite_5_increment_y
    jsr SPRITE_LIB.sprite_6_increment_y
    jsr SPRITE_LIB.sprite_7_increment_y
    rts
    
joy_left:
    jsr SPRITE_LIB.sprite_0_decrement_x
    jsr SPRITE_LIB.sprite_1_decrement_x
    jsr SPRITE_LIB.sprite_2_decrement_x
    jsr SPRITE_LIB.sprite_3_decrement_x
    jsr SPRITE_LIB.sprite_4_decrement_x
    jsr SPRITE_LIB.sprite_5_decrement_x
    jsr SPRITE_LIB.sprite_6_decrement_x
    jsr SPRITE_LIB.sprite_7_decrement_x
    rts
    
joy_right:
    jsr SPRITE_LIB.sprite_0_increment_x
    jsr SPRITE_LIB.sprite_1_increment_x
    jsr SPRITE_LIB.sprite_2_increment_x
    jsr SPRITE_LIB.sprite_3_increment_x
    jsr SPRITE_LIB.sprite_4_increment_x
    jsr SPRITE_LIB.sprite_5_increment_x
    jsr SPRITE_LIB.sprite_6_increment_x
    jsr SPRITE_LIB.sprite_7_increment_x
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

/* RASTER EXECUTION CODE*/
actions_in_raster:

    inc INTERRUPT_STATUS // $d019 - Set bit 0 in Interrupt Status Register to 
                        // acknowledge raster interrupt

    // X Register contains the number of SPRITE to retrieve in each iteration
    // it is like : for ( int x = 0 ; x < 8 ; x++ )
    ldx #0

    sprites_loop:

       
        inc sprites_raster_counters_table,x /* Increment the value of the 
                                     iteration counter for the current sprite */
       
        lda sprites_raster_counters_table,x /*Load in A the current incremented 
                                           value */

        cmp sprites_rasters_limit_table,x  /* Check if the sprite counter == 
                                              sprite limit */
       
        beq process_this_sprite /* If it is in the limit, this means we must 
                                  move to the next frame in this animation */
        jmp go_to_next_sprite /* If is NOT in the limit,go to next frame (X++)*/

        process_this_sprite:

            /* ??? Change to next frame in the animnation */

            // Get the LO and HI bytes values of the associated animation list
            // for this current sprite.
            lda sprite_animations_list_LO_table,x
            sta ANIMATION_FRAMES_LIST_LO

            lda sprite_animations_list_HI_table,x
            sta ANIMATION_FRAMES_LIST_HI

            // Once we have the address of this list ...
            lda sprites_current_animation_index_position_table,x    

            // We save the value in the next variable ...
            // (SPRITE_ANIMATION_VALUE_OFFSET)
            // Then we call to the next function to get the sprited_pad index
            // value and point to this picture in the sprites memory. This index
            // is returned in SPRITE_PAD_INDEX from this function...
            sta SPRITE_ANIMATION_VALUE_OFFSET
            jsr SPRITE_LIB.sprite_get_current_index_sprite_pad_value_animation

            // But , if SPRITE_PAD_INDEX have the value 255, this means we are 
            // in the final of the animation , and we must reset to 0 
            // the sprites_current_animation_index_position_table, because we
            // need start to count again from 0   
            lda SPRITE_PAD_INDEX
            cmp #255
            beq reset_animation

            // So , if we are NOT in the final of the animation, 
            // we increment this value in the table, 
            inc sprites_current_animation_index_position_table,x    

            // Finally we show this new slide (frame) of the animation in screen
            jmp put_animation_frame_in_screen             

    reset_animation:
       
        lda #0 // Set to 0 this index in the table
        sta sprites_current_animation_index_position_table,x
       
        // Once we have rested this value, we must force to point to the first
        // animation frame. To get this goal , we must use our function
        // "sprite_get_current_index_sprite_pad_value_animation" , and the with
        // with INDEX (SPRITE_PAD_INDEX) match with the first animation of the
        // current sprite, the IN param for this function is 
        // "SPRITE_ANIMATION_VALUE_OFFSET"

        sta SPRITE_ANIMATION_VALUE_OFFSET
        jsr SPRITE_LIB.sprite_get_current_index_sprite_pad_value_animation

        // Finally we increment the value of: 
        // "sprites_current_animation_index_position_table" to show the next
        // frame of this sprite in the next iteration of the loop. With this
        // we create the ilusion of a infinity animation loop
        inc sprites_current_animation_index_position_table,x
       
    put_animation_frame_in_screen:
        
        // If we are NOT in the LIMIT of the animation list ( final slide )
        // We must access where start the sprites blocks in memory , this is
        // SPRITES_ADDRESS / 64 decimal = SPRITES_ADDRESS / $40
        // Each sprite are 64 bytes, so we must move us by 64 bytes
        
        // So to put the next slide of the animation sprite for the current
        // sprite, we must access to this SPRITE_INDEX_POINTER and ADD this
        // offset. This offset is the value of SPRITE_PAD_INDEX. This is the
        // position of the sprite in the pallette of SPRITE PAD Windows Program
        lda SPRITE_INDEX_POINTER 
        clc
        adc SPRITE_PAD_INDEX
        sta SPRITE_FRAME_POINTER
       
        // Finally, is missing only check if the X Register is pointing to
        // the sprite 0,1,2 and so on until 8. Finally we call to the function
        // set_frame_to_sprite_X to the this SPRITE_FRAME_POINTER in the
        // target address sprite pointer.
        cpx #0
        bne x_1
        jsr SPRITE_LIB.set_frame_to_sprite_0
        jmp reset_sprite_raster_counter_in_current_sprite

        x_1:
        cpx #1
            bne x_2
            jsr SPRITE_LIB.set_frame_to_sprite_1
            jmp reset_sprite_raster_counter_in_current_sprite

        x_2:
            cpx #2
            bne x_3
            jsr SPRITE_LIB.set_frame_to_sprite_2
            jmp reset_sprite_raster_counter_in_current_sprite
        x_3:
            cpx #3
            bne x_4
            jsr SPRITE_LIB.set_frame_to_sprite_3
            jmp reset_sprite_raster_counter_in_current_sprite
        x_4:
            cpx #4
            bne x_5
            jsr SPRITE_LIB.set_frame_to_sprite_4
            jmp reset_sprite_raster_counter_in_current_sprite
        x_5:
            cpx #5
            bne x_6
            jsr SPRITE_LIB.set_frame_to_sprite_5
            jmp reset_sprite_raster_counter_in_current_sprite
        x_6:
            cpx #6
            bne x_7
            jsr SPRITE_LIB.set_frame_to_sprite_6
            jmp reset_sprite_raster_counter_in_current_sprite
        x_7:
            cpx #7
            bne reset_sprite_raster_counter_in_current_sprite
            jsr SPRITE_LIB.set_frame_to_sprite_7
       
        reset_sprite_raster_counter_in_current_sprite:
        lda #0
        sta sprites_raster_counters_table,x
       
    go_to_next_sprite:
        inx
        cpx #8
        // If the loop is in the last sprite ( X == 8 )        
        // we leave the interruption if not , we continue the loop iteration
        beq exit_sprites_loop
        jmp sprites_loop

        exit_sprites_loop:

jmp INTERRUPT_RETURN // $ea81 - Return from interrupt