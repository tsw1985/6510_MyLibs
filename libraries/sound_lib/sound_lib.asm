#import "sound_macros/sound_lib_macros.asm"

SOUND_LIB:
{

play_sound:
push_regs_to_stack()

    lda #$0f
    sta $d418      // volumen máximo
    lda #$81       // ruido + gate
    sta $d404      // activar canal 1

pull_regs_from_stack()
rts

stop_sound:
push_regs_to_stack()

    lda #$00
    sta $d404      // apagar canal 1


pull_regs_from_stack()
rts













}