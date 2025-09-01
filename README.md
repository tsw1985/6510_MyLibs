# 6510_MyLibs

## What it is this ?

This is a small "template","library","tools" ,"examples", to develop any program or game 
in assembler using KickAssembler for the Commodore 64.

This template use the compiler "Kick assembler"

This template is based / inspired from the Youtube Course "Commodore Tutorials".

https://www.youtube.com/@board-b-tutorials

This is the best course for learning assembly in all Youtube. Beleave me.

So, I toke the main ideas from the author and I made my customs macros , 
functions.

I started from scrach in assembly for C64. I had only a few knowledges in
assembly for x86.

My advice is , first watch all course videos and later use this template, why? 
because each project it is unique and the default memory configuration in this 
template can do not match with your target. Also the course speak about the
project structure and can help to you a lot to understeand this easy.

Also, maybe you do not need some libraries, we know the computer memory is
limited.

# Project Structure Folders

To be honest , in a first contact with this template can looks dificult to 
understeand but it is very easy, take a look to chapter "19 - Project Setup".

- **Main.asm**: Main file. Always we must compile our project from this file. This
file import / load all code in the desired memory address for the target in our
project. Take a look in the Youtube Course to chapter "18 - Memory Map"

- **Charset**: Contains the binary file with our custom charset.

- **Constants**: All constants for our project.

- **Demos**: Example demos to show how to use the functions in this template.

- **Includes**: This is the "main" folder. In this folder we have the file 
"main_code.asm" . This will be our main file to write our code, think it is our
main.c file. In this case , instead of write directly the code for run each
example, I'm doing a "Import" of the example code to load. If you want test
one example , uncomment ONLY ONE.

In this folder **includes** you will see other files, basically this files acts
like "main point" to load the rest of folders in the project.

- **Libraries**: This folder contains all core code called by our funcions and
macros. See documentations bellow.

- **Music**: Folder to save the music file for our project if we need it.

- **Sprites**: Folder to save the .bin files of our sprites.

- **System**: This folder contains the memory configuration values for our 
project

- **Tables**: This folder contains the tables used in our project. By default
the existing "map_table.asm" and "screen_table.asm" are required for any project

- **Tileset**: Contains the .bin file for our tile set. This file is used to
print maps ( game map for example ) in the screen.

- **Variables**: All variables used for each library.


# FUNCTIONS:

## Out Screen functions:

### Clean Screen:
    
    Clean the screen.

    jsr PRINT_LIB.clean_screen

### Print a string text:

    Print a string in screen. The strings values are stored in the file 
    strings.asm.

    message: .text @"This is your text\$00"
    insert_text(2,5,message,RED) // row , col, text , color

    DEMO: /demos/print_lib/print_text.asm


### Print the result of a calculation:

    This function show the result of a calculation. You need set to SUM_RES_0
    the value LOADED IN "A" Register.

    lda SPRITE_CENTER_PLAYER_POS_Y // Example value
    sta sum_res_0
    lda #0
    sta sum_res_1
    sta sum_res_2
    sta sum_res_3
    print_calculation_result(3,37,WHITE,sum_res_0,sum_res_1,sum_res_2,sum_res_3)

    
    This function can show big numbers (32 bits), you need only fill the bytes.
    DEMO:  /demos/sum_32_bits.asm to see a example.


## Input Screen functions

### INPUT TEXT ( Keyboard ):

    This function works like the $INPUT from Basic but it is improved because
    here you can set the row, column and text length. When the user press enter
    the value is stored in the variable: KEYS_TO_SCREEN_STR

    
    input_text(15,0,25,PINK)
    insert_text(16,15,KEYS_TO_SCREEN_STR,GREEN)

    DEMO: /demos/input_lib.asm


## Joystick functions