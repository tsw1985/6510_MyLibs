insert_text(1,1,cur_frame_index_str,YELLOW)
insert_text(2,1,cur_sprite_pad_index_str,YELLOW)
insert_text(3,1,fut_sprite_pad_index_str,YELLOW)




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

    cli
        ldx #0 //sprites animation list index
        lda sprite_animations_list_LO,x
        sta ANIMATION_FRAMES_LIST_LO

        lda sprite_animations_list_HI,x
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
    //--- Start raster code  

        // recorrer lista de animaciones
        start_again:
        ldx SPRITE_COUNTER // #0

        // Accedemos al timer de cada sprite
        //lda sprites_frame_counters,x   // accedemos al valor del contador del sprite que esta en X
        //cmp sprites_animations_speed,x // accedemos al valor de velocidad del sprite que esta en X


        lda SPRITE_RASTER_COUNTER
        cmp #70
        beq start_retrieve_list_sprites      // si los valores coinciden, empezamos a recorrer los sprites
        jmp exit_raster_irq 

        start_retrieve_list_sprites:    
            lda #0
            sta SPRITE_RASTER_COUNTER

            continue_animation_list:

                // Obtenmos los bytes LO y HI para luego acceder a la lista
                // con la funcion "sprite_get_current_index_sprite_pad_value_animation"
                lda sprite_animations_list_LO,x
                sta ANIMATION_FRAMES_LIST_LO

                lda sprite_animations_list_HI,x
                sta ANIMATION_FRAMES_LIST_HI

                continue_getting_animation_frames:

                    jsr SPRITE_LIB.sprite_get_current_index_sprite_pad_value_animation
                    //inc SPRITE_INDEX_COUNTER  //contador de frames por cada animacion

                    // despues de esta funcion, tenemos el indice en SPRITE_PAD_INDEX
                    // lo imprimimos en pantalla para ir viendolo
                    lda SPRITE_PAD_INDEX
                    sta div_res_0
                    lda #0
                    sta div_res_1
                    sta div_res_2
                    sta div_res_3
                    print_calculation_result(3,25,YELLOW,div_res_0,div_res_1,div_res_2,div_res_3)


                    inc SPRITE_INDEX_COUNTER  //contador de frames por cada animacion

                    // y comparamos si es 255 , que significa que es fin de las animaciones
                    // y hay que pasar al siguiente sprite
                    lda SPRITE_PAD_INDEX
                    cmp #255 // ¿ SPRITE_PAD_INDEX == 255 , Llego al final de la animacion ?
                    beq go_to_next_sprite // si es 255 pasamos al siguiente sprite
                    jmp exit_raster_irq 

        go_to_next_sprite:
        lda #0
        sta SPRITE_INDEX_COUNTER
        //inx  //incrementamos X para ir a la lista del siguiente sprite
        inc SPRITE_COUNTER
        ldx SPRITE_COUNTER
        cpx #8 // ¿ ya son los 8 sprites ?
        beq reset_sprite_counter//exit_raster_irq
        jmp start_again //continue_animation_list


    //---- end raster code

reset_sprite_counter:
    lda #0
    sta SPRITE_COUNTER
    
exit_raster_irq:
inc SPRITE_RASTER_COUNTER
jmp INTERRUPT_RETURN // $ea81 - Return from interrupt
