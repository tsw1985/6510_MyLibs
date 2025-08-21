// This is the entry point file . Execute kick assambler on main.asm
system_status: .byte 0
main:

    //Important init stack !!
    //if you want see your current screen on exit program 
    //or go to basic, comment it
    //ldx #$ff
	//txs       // Initialize system stack

    //start setup
    jsr SYSTEM.setup

init_code:

    //Your code here ...
    jsr PRINT_LIB.clean_screen
    
    /*
    //Here you can add you main loop on your game
    // loop:
    //  your code here
    // jmp loop
    */

    //but , we are showing the demos for each library

    /*  PRINT LIB DEMOS */
    //#import "/demos/print_lib/print_single_char.asm"
    //#import "/demos/print_lib/print_text.asm"

    /* MATHS LIBS DEMOS */
    //#import "/demos/math_lib/division_32_bits.asm"
    //#import "/demos/math_lib/multiplication_32_bits.asm"
    //#import "/demos/math_lib/sum_32_bits.asm"
    //#import "/demos/math_lib/sub_32_bits.asm"

    /* Simple concurrence system ( Round Robbin) */
    //#import "/demos/concurrent/concurrent.asm"

    /* KEYBOARD DEMOS */
    //#import "/demos/input_lib/input_lib.asm"

    /* JOYSTICK DEMO */
    //#import "/demos/joystick_lib/joystick_lib.asm"
    
    /* 8 SPRITES animations with individual speeds */
    // #import "/demos/sprite_lib/sprite_8_animations.asm"

    /* SPRITES COLLISIONS */
    //#import "/demos/sprite_lib/sprite_collisions.asm"
    //#import "/demos/sprite_lib/sprite_collisions_by_raster.asm"
    #import "/demos/sprite_lib/sprite_collisions_by_raster_and_change_animation.asm"
    




    // uncommet in develop time
    wait_key:
        jsr $ffe4       // GETIN
        cmp #0
        beq wait_key    // si no se ha pulsado tecla, repetir
    
    


    // NOT REMOVEEE !!!
    //restore setup
    jsr SYSTEM.restore_system
    jsr PRINT_LIB.clean_screen
    //rts // exit to basic


//jmp init_code   
