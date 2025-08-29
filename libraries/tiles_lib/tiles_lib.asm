#import "tiles_macros/tiles_lib_macros.asm"

TILES_LIB:
{

    init_new_charset:
        push_regs_to_stack()

        /* Here we are setting the position of Screen ram and where is the
           charset to use, in the address $3800 */
        lda #%00011110 // Screen RAM: $0400   Charset: $3800
        sta $d018 // Screen memory setup
        pull_regs_from_stack()
    rts



}