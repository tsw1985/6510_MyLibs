BasicUpstart2(main)

#import "print/print_char.asm"

message: .text @"hola que tal como estan\$00"

main:

    jsr $e544 //clear screen
    lda #1 // A
    sta SCREEN_CHAR

    lda #20
    sta SCREEN_ROW_POS
    lda #5
    sta SCREEN_COL_POS

    //jsr print_char        // print single char
    jsr show_main_message // show a long text

rts

show_main_message:

    jsr clean_location_screen
    lda #4
    sta SCREEN_ROW_POS
    lda #5 
    sta SCREEN_COL_POS
    
    ldx #0
    continue_writing:
        lda message,x
        jsr print_char
        inx
        stx SCREEN_COL_POS

rts



