// This is the entry point file . Execute kick assambler on main.asm

main:

    //Important init stack !!
	ldx #$ff
	txs       // Initialize system stack

init_code:

    //Your code here ...
    jsr $e544 //clear screen
    
    //print text 1
    jsr PRINT_LIB.clean_location_screen
    locate_text(0,0,RED)
    print_text(stars_line)

    //print text 2
    jsr PRINT_LIB.clean_location_screen
    locate_text(2,5,PINK)
    print_text(message)

    //print text 3
    jsr PRINT_LIB.clean_location_screen
    locate_text(3,0,BLACK)
    print_text(stars_line)


    //print text 4
    jsr PRINT_LIB.clean_location_screen
    locate_text(5,0,WHITE)
    print_text(bye)


    jmp init_code



    /*
    //Here you can add you main loop on your game
    // loop:
    //  your code here
    // jmp loop


    //but , we are showing the demos for each library

    // PRINT LIB DEMOS
        #import "/demos/print/print_single_char.asm"
        //#import "/demos/print/print_text.asm"

    // MATHS LIBS DEMOS
        //#import "/demos/math/division.asm"
        #import "demos/math/multiplication.asm"
        */

rts // exit to basic