// This is the entry point file . Execute kick assambler on main.asm

main:

    jsr $e544 //clear screen
    

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

rts //go basic