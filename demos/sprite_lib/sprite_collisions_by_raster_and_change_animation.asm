/******************************************************************************

    Sprites collision version RASTER.
    
  ===> NEW: This version , change de animation when the sprite is in collision


    This means , the collision checking is doing into the RASTER INTERRUPT
    and in main loop we are doing other stuffs.

    NOTE: 
  -----------------------------------------------------------------------------
  |  The sprite movement is SLOW because we are using the print functions     |
  |  for printing the Y-X coords of player and enemies in collision time.     |
  |                                                                           |
  |  If you remove this, the sprite will fly. Anyway you can play with the    |
  |   "sleep_sprite" function .                                               |
  |                                                                           |
  -----------------------------------------------------------------------------

 */


/* Load map #0 */
//print_map(0)

insert_text(1,1,sprites_colls_demo_str,YELLOW)
insert_text(3,33,sprites_player_y_str,YELLOW)
insert_text(4,33,sprites_player_x_str,YELLOW)
insert_text(6,33,sprites_enemy_y_str,YELLOW)
insert_text(7,33,sprites_enemy_x_str,YELLOW)
insert_text(8,33,sprites_enemy_n_str,YELLOW)

/* Global */
sprite_set_extra_colors(GRAY,YELLOW)

/* Enable sprites */
sprite_enable_sprite(0)
sprite_enable_sprite(1)
sprite_enable_sprite(2)
sprite_enable_sprite(3)
sprite_enable_sprite(4)
sprite_enable_sprite(5)
sprite_enable_sprite(6)
sprite_enable_sprite(7)


/* Setup for sprite 1 PLAYER */
sprite_load_like_multicolor(0)
sprite_set_position(0,145,150)
sprite_set_color(0,YELLOW)
sprite_set_frame_to_sprite(0,0) // $00c0 ... $00c1 ... $00c2 ...
/* Setup for sprite 1 */

/* Setup for sprite 2 ENEMY */
sprite_load_like_multicolor(1)
sprite_set_position(1,105,68)
sprite_set_color(1,PINK)
sprite_set_frame_to_sprite(0,1)
/* Setup for sprite 2 */


/* Setup for sprite 3 ENEMY */
sprite_load_like_multicolor(2)
sprite_set_position(2,106,230)
sprite_set_color(2,RED)
sprite_set_frame_to_sprite(0,2)
/* Setup for sprite 3 */


/* Setup for sprite 4 ENEMY */
sprite_load_like_multicolor(3)
sprite_set_position(3,108,154)
sprite_set_color(3,GREEN)
sprite_set_frame_to_sprite(0,3)
/* Setup for sprite 4 */


/* Setup for sprite 5 ENEMY */
sprite_load_like_multicolor(4)
sprite_set_position(4,170,62)
sprite_set_color(4,ORANGE)
sprite_set_frame_to_sprite(0,4)
/* Setup for sprite 5 */


/* Setup for sprite 6 ENEMY */
sprite_load_like_multicolor(5)
sprite_set_position(5,200,215)
sprite_set_color(5,LIGHT_BLUE)
sprite_set_frame_to_sprite(0,5)
/* Setup for sprite 6 */


/* Setup for sprite 7 ENEMY */
sprite_load_like_multicolor(6)
sprite_set_position(6,165,230)
sprite_set_color(6,GRAY)
sprite_set_frame_to_sprite(0,6)
/* Setup for sprite 7 */

/* Setup for sprite 8 ENEMY */
sprite_load_like_multicolor(7)
sprite_set_position(7,200,120)
sprite_set_color(7,BLACK)
sprite_set_frame_to_sprite(0,7)
/* Setup for sprite 7 */


/*  RASTER INTERRUPT */
jsr setupRasterInterrupt


/* MAIN LOOP.

    This is like a game loop

 */ 
simulate_game_loop:

        
    /* INIT SPRITE 0 animations.   
        This is the sprite_0 - animation 0. This is launched in the 
        raster interrupt
    */
    
    ldx #0

    lda sprite_animations_list_LO_table,x
    sta sprite_current_anim_LO_table,x

    lda sprite_animations_list_HI_table,x
    sta sprite_current_anim_HI_table,x

    jsr start_read_joystick


    /*****************************
        PRINT PLAYER COORDS
    ******************************/

    /*   Y   */
    lda SPRITE_CENTER_PLAYER_POS_Y
    sta sum_res_0
    lda #0
    sta sum_res_1
    sta sum_res_2
    sta sum_res_3
    print_calculation_result(3,37,WHITE,sum_res_0,sum_res_1,sum_res_2,sum_res_3)
    
    /*  X */
    lda SPRITE_CENTER_PLAYER_POS_X
    sta sum_res_0
    lda #0
    sta sum_res_1
    sta sum_res_2
    sta sum_res_3
    print_calculation_result(4,37,WHITE,sum_res_0,sum_res_1,sum_res_2,sum_res_3)


    /************************************************
        PRINT ENEMY COORDS VALUES IN COLLISION
    **************************************************/

    print_enemy_values:
        lda SPRITE_TEMP_Y
        sta sum_res_0
        lda #0
        sta sum_res_1
        sta sum_res_2
        sta sum_res_3
        print_calculation_result(6,37,WHITE,sum_res_0,sum_res_1,sum_res_2,sum_res_3)


        lda SPRITE_TEMP_X
        sta sum_res_0
        lda #0
        sta sum_res_1
        sta sum_res_2
        sta sum_res_3
        print_calculation_result(7,37,WHITE,sum_res_0,sum_res_1,sum_res_2,sum_res_3)



    /* Print with sprite is in collision */
    lda SPRITE_IN_COLLISION
    sta sum_res_0
    lda #0
    sta sum_res_1
    sta sum_res_2
    sta sum_res_3
    print_calculation_result(8,37,WHITE,sum_res_0,sum_res_1,sum_res_2,sum_res_3)


jmp simulate_game_loop



/* Function to read the joystick port */
start_read_joystick:

    push_regs_to_stack()

    /* clean screen */
    jsr sleep_sprite

    /* read joystick positions */
    jsr JOYSTICK_LIB.read_joystick

    /* actions in each joystick position */

    lda JOYSTICK_POSITIONS
    and #JOY_GO_LEFT 
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

pull_regs_from_stack()
rts


/*
/////////////////////////////////////////////
                Functions 
/////////////////////////////////////////////
*/
joy_up:
    jsr SPRITE_LIB.sprite_0_decrement_y
    rts
    
joy_down:
    jsr SPRITE_LIB.sprite_0_increment_y
    rts
    
joy_left:
    jsr SPRITE_LIB.sprite_0_decrement_x
    rts
    
joy_right:
    jsr SPRITE_LIB.sprite_0_increment_x
    rts

joy_fire:
    push_regs_to_stack()
    //insert_text(2,10,joystick_fire_str,WHITE)
    inc MAP_NUMBER
    jsr TILES_LIB.load_map

    pull_regs_from_stack()
    rts

sleep_sprite:

    push_regs_to_stack()

    ldx #25 //50
    sleep_sprite_outer_loop:
        ldy #25 //50
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

        stx SPRITE_INDEX_COUNTER_RASTER_LOOP
       
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

            /*lda sprite_animations_list_LO_table,x
            sta ANIMATION_FRAMES_LIST_LO

            lda sprite_animations_list_HI_table,x
            sta ANIMATION_FRAMES_LIST_HI*/

            lda sprite_animations_list_LO_table,x
            sta sprite_current_anim_LO_table,x

            lda sprite_animations_list_HI_table,x
            sta sprite_current_anim_HI_table,x

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

        // This is the SPRITE PLAYER ( this is player by default )
        // get currents X-Y Positions of the sprite player
        // SPRITE_PLAYER_POS_X
        // SPRITE_PLAYER_POS_Y

        cpx #0
        bne x_1
        
        jsr SPRITE_LIB.set_frame_to_sprite_0
        jmp reset_sprite_raster_counter_in_current_sprite

        x_1:   // sprite 2
            cpx #1   
            bne x_2
            jsr SPRITE_LIB.set_frame_to_sprite_1
            jmp reset_sprite_raster_counter_in_current_sprite


        x_2:   // Enemy sprite
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


        /* Call to check collision in any sprite */
        /* This loop is execute in the last part of the RASTER Interrupt.
           Here we retrieve each sprite ( from 1 to 7. Sprite 0 is player )
           To check if the CENTER of sprite 0 is into the rectangle of enemy
           sprite
        */
        ldy #0
        check_sprite_loop:
            iny
            sty SPRITE_TO_CHECK
            
            jsr check_sprite_collisions
            cpy #8
            bne check_sprite_loop

        /* end Call to check collision in any sprite */


jmp INTERRUPT_RETURN // $ea81 - Return from interrupt



/* 

    Function:

        Check a target sprite if have a collision.
        
        IN:
        
            SPRITE_TO_CHECK

*/
check_sprite_collisions:
push_regs_to_stack()

    /* Reset local variables */
    lda #0
    sta SPRITE_CENTER_PLAYER_POS_Y
    sta SPRITE_CENTER_PLAYER_POS_X
    sta SPRITE_ENEMY_Y_PLUS_OFFSET
    sta SPRITE_ENEMY_X_PLUS_OFFSET
    sta SPRITE_ENEMY_Y
    sta SPRITE_ENEMY_X

    /* 
      The SPRITE 0 , is the player. We need calculate the center of the sprite.
      This center of the sprite , if it is into the retangle of the enemy sprite,
      this is a collision

    */

    /* set center Y */
    ldx #0
    lda sprites_coord_table_y,x
    clc 
    adc #10   // add 10 to point to the center of the sprite player COLS
    sta SPRITE_CENTER_PLAYER_POS_Y

    /* set center X */
    ldx #0
    lda sprites_coord_table_x,x
    clc 
    adc #12 // add 12 to set the center of sprite player ROWS
    sta SPRITE_CENTER_PLAYER_POS_X
    

    /* Now is time to set the limit coordinates values load the SPRITE to check 
    the collision, it is saved in variable SPRITE_TO_CHECK */

    lda SPRITE_TO_CHECK  
    tax   // transfer the value storaged in reg A to reg X

    /* Enemy X + offset X*/
    lda sprites_coord_table_x,x
    sta SPRITE_ENEMY_X
    clc
    adc #SPRITE_WIDTH // 24
    sta SPRITE_ENEMY_X_PLUS_OFFSET

    /* Enemy Y + offset Y*/
    lda sprites_coord_table_y,x
    sta SPRITE_ENEMY_Y
    clc
    adc #SPRITE_HEIGHT // 21
    sta SPRITE_ENEMY_Y_PLUS_OFFSET

    /**************************************************/
    /*            Start comparations                  */
    /**************************************************/
    // If Player_X >= Enemy_X
    lda SPRITE_CENTER_PLAYER_POS_X
    cmp SPRITE_ENEMY_X
    //bcc sprite_no_hit  // if is LESS means X is between the X and X + offset of rectangle
    bcs continue_check_1
    jmp sprite_no_hit

    continue_check_1:

        // IF Player_X <= Enemy_X + Sprite_width
        lda SPRITE_CENTER_PLAYER_POS_X
        cmp SPRITE_ENEMY_X_PLUS_OFFSET
        //bcs sprite_no_hit
        bcc continue_check_2
        jmp sprite_no_hit

    continue_check_2:

        // Start comparations
        // If Player_Y >= Enemy_Y
        lda SPRITE_CENTER_PLAYER_POS_Y
        cmp SPRITE_ENEMY_Y
        //bcc sprite_no_hit  // if is LESS means X is between the X and X + offset of rectangle
        bcs continue_check_3
        jmp sprite_no_hit

    continue_check_3:

        // IF Player_Y <= Enemy_Y + Sprite_height
        lda SPRITE_CENTER_PLAYER_POS_Y
        cmp SPRITE_ENEMY_Y_PLUS_OFFSET
        //bcs sprite_no_hit
        bcc change_border_color
        jmp sprite_no_hit

    change_border_color:

    

        //If exists collision , increment border color
        // change color ,save temp values and allow print
        inc $d020 // change border color

        /* Play sound */
        jsr SOUND_LIB.play_sound



        /* Save positions of enemy Y-X for print them in the main loop */
        lda SPRITE_ENEMY_Y
        sta SPRITE_TEMP_Y
        lda SPRITE_ENEMY_X
        sta SPRITE_TEMP_X

        /* Save the sprite in collision. Here we save the sprite index in
           collision */
        stx SPRITE_IN_COLLISION

        //---------------
        // Set the sprite in collision mode
        lda #1
        sta sprites_state_table,x

        /* Change sprite to "dead mode". To achieve this we must change the
           pointers to point to a new animation list. 
           
           The tables "sprite_animations_list_LO_table" basically are a list
           of animations lists.


            Here we are setting the ADDRESS LOW AND HIGHT byte of the dead
            animation to the target sprite ( sprite with collision ).

            Remember, the tables : sprite_animations_list_LO_table and 
            sprite_animations_list_HI_table , each entry is a SPRITE INDEX,and
            each sprite index point to a animation.

        */
        lda sprite_dead_list_LO_table,x
        sta sprite_animations_list_LO_table,x
        
        sta sprite_current_anim_LO_table,x 
        lda sprite_dead_list_HI_table,x

        sta sprite_animations_list_HI_table,x
        sta sprite_current_anim_HI_table,x 


        /* Set to 1 ignore  */
        lda IGNORE_RESET_ANIMATION_INDEX_TABLE,x
        cmp #1
        beq ignore_reset_animation_index

        //------- put the new animation inmediatly !
        // Put speed in dead mode sprite animation
        lda #4
        sta sprites_rasters_limit_table,x


        //Save the current index before reset it to 0
        lda sprites_current_animation_index_position_table,x
        sta sprites_current_animation_index_position_table_backup,x


        //Save the current raster counter before collision
        lda sprites_raster_counters_table,x
        sta sprites_raster_counters_table_backup,x


        lda #0
        sta sprites_current_animation_index_position_table,x
        sta sprites_raster_counters_table,x
        //------- end put the new animation inmediatly !



        // ---- set to 1 to avoid reset always the animation index to 0        
        lda #1
        sta IGNORE_RESET_ANIMATION_INDEX_TABLE,x

        ignore_reset_animation_index:

        jmp exit_check_collision


    sprite_no_hit:

        // if no hit, reset border color to default
        //lda #LIGHT_BLUE
        //sta $d020

        jsr SOUND_LIB.stop_sound

        // Solo restaurar si estaba en colisión
        lda sprites_state_table,x
        cmp #1
        //bne exit_check_collision
        beq skip_exit_check_collision
        jmp exit_check_collision
        
        skip_exit_check_collision:



        // Put the sprite in normal state

        /* Set sprite to normal animation and retet if from zero. 
        To achive this, we get the original values of the HI and LO (pointer) 
        saved into the backup tables.  */

        lda #0
        sta sprites_state_table,x
        lda sprite_animations_list_LO_table_backup,x
        sta sprite_animations_list_LO_table,x
        sta sprite_current_anim_LO_table,x

        lda sprite_animations_list_HI_table_backup,x
        sta sprite_animations_list_HI_table,x
        sta sprite_current_anim_HI_table,x

        /* also we must set again the default speed of the animations. Also
        saved in the backup tables. */
        lda sprites_rasters_limit_table_backup,x
        sta sprites_rasters_limit_table,x



        /* Put again the sprite in the frame before the collision. To achieve 
        this we need get the backup value. This value is the last index frame
        in the sprite animation before the collision with the player.
        
        We need substract 1 because this save the current value , always is +1.
         */
        lda sprites_current_animation_index_position_table_backup,x
        //sec
        //sbc #1  
        sta sprites_current_animation_index_position_table,x

        /* set to 0 the values to ignore put again the same animation in 
         collision, the otherwise , always start the "dead animation" from 0
         in collision condition */

        lda SPRITE_INDEX_POINTER 
        clc
        adc sprites_current_animation_index_position_table,x //  #0
        sta SPRITE_FRAME_POINTER

        // Ignore Sprite 0
            cpx #1   
            bne x_enemy_2

            /* Put again the last value of the raster counter for the sprite.
               In this point we need put the raster counter to the limit. Why?
               Because like it is, we set the raster_counter for this sprite
               to the limit, then, the sprite animation play faster again.

               The otherwise exists a small delay until the raster counter for
               this sprite is finished. We substract -1 because is need for the
               comparation "raster_counter" in the raster interruption.
            */
            lda sprites_rasters_limit_table,x
            sec
            sbc #1
            sta sprites_raster_counters_table,x // set counter to limit - 1
            jsr SPRITE_LIB.set_frame_to_sprite_1
            jmp end_reset_cases

        x_enemy_2:   // Enemy sprite
            cpx #2
            bne x_enemy_3
            lda sprites_rasters_limit_table,x
            sec
            sbc #1
            sta sprites_raster_counters_table,x // set counter to limit - 1
            jsr SPRITE_LIB.set_frame_to_sprite_2
            jmp end_reset_cases

        x_enemy_3:
            cpx #3
            bne x_enemy_4
            lda sprites_rasters_limit_table,x
            sec
            sbc #1
            sta sprites_raster_counters_table,x // set counter to limit - 1
            jsr SPRITE_LIB.set_frame_to_sprite_3
            jmp end_reset_cases
        x_enemy_4:
            cpx #4
            bne x_enemy_5
            lda sprites_rasters_limit_table,x
            sec
            sbc #1
            sta sprites_raster_counters_table,x // set counter to limit - 1
            jsr SPRITE_LIB.set_frame_to_sprite_4
            jmp end_reset_cases
        x_enemy_5:
            cpx #5
            bne x_enemy_6
            lda sprites_rasters_limit_table,x
            sec
            sbc #1
            sta sprites_raster_counters_table,x // set counter to limit - 1
            jsr SPRITE_LIB.set_frame_to_sprite_5
            jmp end_reset_cases
        x_enemy_6:
            cpx #6
            bne x_enemy_7
            lda sprites_rasters_limit_table,x
            sec
            sbc #1
            sta sprites_raster_counters_table,x // set counter to limit - 1
            jsr SPRITE_LIB.set_frame_to_sprite_6
            jmp end_reset_cases
        x_enemy_7:
            cpx #7
            bne end_reset_cases
            lda sprites_rasters_limit_table,x
            sec
            sbc #1
            sta sprites_raster_counters_table,x // set counter to limit - 1
            jsr SPRITE_LIB.set_frame_to_sprite_7

        end_reset_cases:

        lda #0
        sta IGNORE_RESET_ANIMATION_INDEX_TABLE,x
        
    
    exit_check_collision:

pull_regs_from_stack()
rts