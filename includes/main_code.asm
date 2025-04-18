// This is the entry point file . Execute kick assambler on main.asm

main:

    jsr $e544 //clear screen
    
    // PRINT LIB DEMOS
        #import "/demos/print/print_single_char.asm"
        #import "/demos/print/print_text.asm"

    // MATHS LIBS DEMOS


rts //go basic