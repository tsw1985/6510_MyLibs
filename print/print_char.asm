BasicUpstart2(main)

#import "screen_table.asm"

main:

    jsr $e544 //clear screen

    ldx #22   // Row 22
    
    lda Row_LO,x
    sta ZERO_PAGE_ROW_LOW_BYTE

    
    lda Row_HI,x
    sta ZERO_PAGE_ROW_HIGHT_BYTE


    ldy #15 // col 15
    lda #5 // char E
    sta (ZERO_PAGE_ROW_LOW_BYTE),y

    rts