#import "sprite_macros/sprite_lib_macros.asm"

SPRITE_LIB:
{

    show_sprite:
        push_regs_to_stack()

        //insert_text(2,5,sprite_hello_str,RED)

        /* Global */
        sprite_set_extra_colors(GRAY,YELLOW)
        //sprite_enable_sprite(0)
        //sprite_enable_sprite(1)


        /* Setup for sprite 0 */
        sprite_load_like_multicolor(0)
        sprite_set_position(0,160,130)
        sprite_set_color(0,WHITE)
        sprite_set_frame_to_sprite($00c0,0) // $00c1 ... $00c2 ...
        /* Setup for sprite 0 */


        /* Setup for sprite 1 */
        sprite_load_like_multicolor(1)
        sprite_set_position(1,50,100)
        sprite_set_color(1,GREEN)
        sprite_set_frame_to_sprite($00c0,1) // $00c1 ... $00c2 ...
        /* Setup for sprite 1 */



        // Enable sprites
        sprite_enable_sprite(0)
        sprite_enable_sprite(1)



        pull_regs_from_stack()
        rts

}