/* Load map #0 */

insert_text(1,1,welcome_demo_str,YELLOW)     // Msg bienvenida en 1,1
insert_text(3,1,write_name_str,GREEN)        // Msg pedir nombre en 3,1   
    
input_text(3,19,10,YELLOW)                   // Input nombre en 3,19 y 10 length 
    
insert_text(5,1,welcome_user_str,WHITE)      // mostramos bienvenida a nombre 
insert_text(5,6,KEYS_TO_SCREEN_STR,GRAY)     // mostramos texto escrito
    
insert_text(7,1,start_game_str,GREEN)        // pulsa una tecla para continuar
input_text(8,1,1,BLACK)                      // pulsamos 
    
enable_custom_charset()                      // actualizo a mi charset
enable_screen_multicolor()                   // activamos pantalla a multicolor
    
jsr PRINT_LIB.clean_screen                   // limpiamos la pantalla
    
print_map(0)                                 // cargamos el map 0


/* Enable sprites */
sprite_enable_sprite(0)

/* Setup for sprite 0 PLAYER */
sprite_load_like_multicolor(0)
sprite_set_position(0,100,100)
sprite_set_color(0,LIGHT_BLUE)
sprite_set_frame_to_sprite(0,0) 
/* Setup for sprite 0 */


/* MAIN LOOP */ 
simulate_game_loop:
    jsr start_read_joystick
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
    inc MAP_NUMBER
    jsr TILES_LIB.load_map
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