// This is the entry point file . Execute kick assambler on main.asm

main:

    //Important init stack !!
    //if you want see your current screen on exit program 
    //or go to basic, comment it
    //ldx #$ff
	//txs       // Initialize system stack

init_code:

    //Your code here ...
    jsr $e544 //clear screen
    
    /*
    //Here you can add you main loop on your game
    // loop:
    //  your code here
    // jmp loop
    */

    //but , we are showing the demos for each library

    // PRINT LIB DEMOS
        //#import "/demos/print_lib/print_single_char.asm"
        //#import "/demos/print_lib/print_text.asm"

    // MATHS LIBS DEMOS
        #import "/demos/math_lib/multiplication.asm"
        //#import "/demos/math_lib/division.asm"
        

//jmp init_code        
rts // exit to basic