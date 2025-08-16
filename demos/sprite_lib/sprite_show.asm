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
sprite_set_position(0,40,130)
sprite_set_color(0,WHITE)
sprite_set_frame_to_sprite($00c0,0) // $00c0 ... $00c1 ... $00c2 ...
/* Setup for sprite 1 */

/* Setup for sprite 2 */
sprite_load_like_multicolor(1)
sprite_set_position(1,70,130)
sprite_set_color(1,CYAN)
sprite_set_frame_to_sprite($00c0,1)
/* Setup for sprite 2 */

/* Setup for sprite 3 */
sprite_load_like_multicolor(2)
sprite_set_position(2,100,130)
sprite_set_color(2,YELLOW)
sprite_set_frame_to_sprite($00c0,2)
/* Setup for sprite 3 */

/* Setup for sprite 4 */
sprite_load_like_multicolor(3)
sprite_set_position(3,130,130)
sprite_set_color(3,BROWN)
sprite_set_frame_to_sprite($00c0,3)
/* Setup for sprite 4 */

/* Setup for sprite 5 */
sprite_load_like_multicolor(4)
sprite_set_position(4,160,130)
sprite_set_color(4,RED)
sprite_set_frame_to_sprite($00c0,4)
/* Setup for sprite 5 */

/* Setup for sprite 6 */
sprite_load_like_multicolor(5)
sprite_set_position(5,190,130)
sprite_set_color(5,GRAY)
sprite_set_frame_to_sprite($00c0,5)
/* Setup for sprite 5 */

/* Setup for sprite 7 */
sprite_load_like_multicolor(6)
sprite_set_position(6,220,130)
sprite_set_color(6,PINK)
sprite_set_frame_to_sprite($00c0,6)
/* Setup for sprite 7 */

/* Setup for sprite 8 */
sprite_load_like_multicolor(7)
sprite_set_position(7,250,130)
sprite_set_color(7,ORANGE)
sprite_set_frame_to_sprite($00c0,7)
/* Setup for sprite 8 */





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

   inc INTERRUPT_STATUS // $d019 - Set bit 0 in Interrupt Status Register to 
                        // acknowledge raster interrupt

   // Empezar con el sprite 0
   ldx #0

   bucle_sprites:

       // Incrementar el contador de este sprite
       inc sprites_raster_counters,x
       
       // Leer cuántos frames han pasado para este sprite
       lda sprites_raster_counters,x    
       
       // Comparar con la velocidad de este sprite
       cmp sprites_animations_speed,x  
       
       // Si aún no ha llegado al límite, saltar al siguiente sprite
       bcc jmp_siguiente_sprite
       bne ignore_jump_siguiente_sprite
       jmp_siguiente_sprite:
           jmp siguiente_sprite
       ignore_jump_siguiente_sprite:

       // Si llegamos aquí, este sprite SÍ debe cambiar de frame
       
       // Obtener los bytes LO y HI de la animación de este sprite
       lda sprite_animations_list_LO,x
       sta ANIMATION_FRAMES_LIST_LO
       lda sprite_animations_list_HI,x
       sta ANIMATION_FRAMES_LIST_HI

       // 1. Obtener el frame actual de la animación
       lda sprites_animation_index,x    
       sta SPRITE_INDEX_COUNTER
       jsr SPRITE_LIB.sprite_get_current_index_sprite_pad_value_animation
       // SPRITE_PAD_INDEX contiene el valor indice del sprite a mostrar

       // Verificar si llegamos al final de la animación
       lda SPRITE_PAD_INDEX
       cmp #255
       beq reset_animacion              

       // 2. Avanzar al siguiente frame de la animación  
       inc sprites_animation_index,x    

       jmp continuar_sprite             

   reset_animacion:
       // Volver al frame 0 de la animación
       lda #0
       sta sprites_animation_index,x
       
       // ¡NUEVO! Obtener y mostrar el frame 0 inmediatamente
       sta SPRITE_INDEX_COUNTER
       jsr SPRITE_LIB.sprite_get_current_index_sprite_pad_value_animation
       // Ahora SPRITE_PAD_INDEX tiene el frame 0 de la animación

       // ¡NUEVO! Incrementar también aquí para que la próxima vez vaya al frame 1
        inc sprites_animation_index,x
       
   continuar_sprite:
       // 3. Calcular y aplicar el frame al sprite
       lda SPRITE_INDEX_POINTER
       clc
       adc SPRITE_PAD_INDEX
       sta SPRITE_FRAME_POINTER
       
       // Asignar el frame al sprite correspondiente
       cpx #0
       bne x_1
       jsr SPRITE_LIB.set_frame_to_sprite_0
       jmp continue_index

       x_1:
       cpx #1
           bne x_2
           jsr SPRITE_LIB.set_frame_to_sprite_1
           jmp continue_index

       x_2:
           cpx #2
           bne x_3
           jsr SPRITE_LIB.set_frame_to_sprite_2
           jmp continue_index
       x_3:
           cpx #3
           bne x_4
           jsr SPRITE_LIB.set_frame_to_sprite_3
           jmp continue_index
       x_4:
           cpx #4
           bne x_5
           jsr SPRITE_LIB.set_frame_to_sprite_4
           jmp continue_index
       x_5:
           cpx #5
           bne x_6
           jsr SPRITE_LIB.set_frame_to_sprite_5
           jmp continue_index
       x_6:
           cpx #6
           bne x_7
           jsr SPRITE_LIB.set_frame_to_sprite_6
           jmp continue_index
       x_7:
           cpx #7
           bne continue_index
           jsr SPRITE_LIB.set_frame_to_sprite_7
       
       continue_index:
       
       // Reset del contador del timer
       lda #0
       sta sprites_raster_counters,x
       
   siguiente_sprite:
       inx
       cpx #8

       beq ignore_jump_to_bucle_sprites
       bne jump_to_bucle_sprites

       jump_to_bucle_sprites:
           jmp bucle_sprites

       ignore_jump_to_bucle_sprites:

jmp INTERRUPT_RETURN // $ea81 - Return from interrupt