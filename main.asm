BasicUpstart2(main)

#import "print/print_char.asm"

message: .text @"hola que tal como estan\$00"
//message: .byte 'h'

main:

    jsr $e544 //clear screen
    lda #1 // A
    sta SCREEN_CHAR

    lda #20
    sta SCREEN_ROW_POS
    lda #5
    sta SCREEN_COL_POS

    //jsr print_char  // print single char
    
    jsr clean_location_screen
    lda #4
    sta SCREEN_ROW_POS
    lda #8 
    sta SCREEN_COL_POS
    jsr print_text    // show a long text

rts

print_text:

    ldx #0
    continue_writing:

        lda message,x
        beq end_writing  //si A == 0 flag Z active
        sta SCREEN_CHAR //load char to show
        jsr print_char
        inx
        inc SCREEN_COL_POS
        jmp continue_writing

    end_writing:

rts



