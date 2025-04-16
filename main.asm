BasicUpstart2(main)

#import "print/print_char.asm"

message: .text @"hola amantes de la panera como estan\$00"
message2: .text @"guarden este repo\$00"

main:

    jsr $e544 //clear screen

    // ------------- test single char----------------
    lda #1 // A
    sta SCREEN_CHAR
    lda #20
    sta SCREEN_ROW_POS
    lda #5
    sta SCREEN_COL_POS
    jsr print_char  // print single char
    // ------------- end test single char----------------


    //create some macros
    // ------------------ test 1 TEXT by param ------------------
    jsr clean_location_screen
    lda #4
    sta SCREEN_ROW_POS
    lda #1 
    sta SCREEN_COL_POS
    lda #<message
    sta ZERO_PAGE_PRINT_TEXT_LO
    lda #>message
    sta ZERO_PAGE_PRINT_TEXT_HI
    jsr print_text    // show a long text
    // ------------------ end test 1 TEXT by param ------------------



    //create some macros
    // ------------------ test 2 TEXT by param ------------------
    jsr clean_location_screen
    lda #7
    sta SCREEN_ROW_POS
    lda #1 
    sta SCREEN_COL_POS
    lda #<message2
    sta ZERO_PAGE_PRINT_TEXT_LO
    lda #>message2
    sta ZERO_PAGE_PRINT_TEXT_HI
    jsr print_text    // show a long text
    // ------------------ end test 2 TEXT by param ------------------


rts //go basic