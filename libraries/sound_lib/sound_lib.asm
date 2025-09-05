#import "sound_macros/sound_lib_macros.asm"

SOUND_LIB:
{

play_sound:
push_regs_to_stack()

    lda #$0f
    sta $d418      // Max Volumen
    lda #$81       // Noise + gate
    sta $d404      // Enable channel 1
    

pull_regs_from_stack()
rts

stop_sound:
push_regs_to_stack()

    lda #$00
    sta $d404      // Disable channel 2


pull_regs_from_stack()
rts













}