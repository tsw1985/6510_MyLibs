SPRITE_LIB:
{

    show_sprite:
        push_regs_to_stack()

        insert_text(2,5,sprite_hello_str,RED)

        pull_regs_from_stack()
        rts

}