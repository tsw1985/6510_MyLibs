BasicUpstart2(main)

#import "print/print_lib.asm"

stars_line: .text @"****************************************\$00"
message: .text @"helloooo , how are you ???\$00"

main:

    jsr $e544 //clear screen

    // ------------- test single char----------------
    //lda #1 // A
    //sta SCREEN_CHAR
    //locate_text(3,4,YELLOW)
    //jsr print_char  // print single char
    // ------------- end test single char----------------


    
    //print text 1
    jsr clean_location_screen
    locate_text(0,0,RED)
    print_text(stars_line)

    //print text 2
    jsr clean_location_screen
    locate_text(2,5,PINK)
    print_text(message)

    //print text 1
    jsr clean_location_screen
    locate_text(23,0,BLACK)
    print_text(stars_line)
    


rts //go basic