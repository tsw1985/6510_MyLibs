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


### Read Joystick Port 2


    The function JOYSTICK_LIB.read_joystick , read the value of positions
    in PORT 2 . The value of the joystick position is returned in the variable
    "JOYSTICK_POSITIONS". This function should be under a loop.

    DEMO: /demos/joystick_lib/joystick_lib.asm


    jsr JOYSTICK_LIB.read_joystick

    /* actions in each joystick position */
    lda JOYSTICK_POSITIONS
    and #%00000100
    beq check_joy_right 
    jsr joy_left

    check_joy_right:
        lda JOYSTICK_POSITIONS
        and #JOY_GO_RIGHT
        beq check_joy_up
        jsr joy_right

    check_joy_up:
        lda JOYSTICK_POSITIONS
        and #JOY_GO_UP
        beq check_joy_down
        jsr joy_up

    check_joy_down:
        lda JOYSTICK_POSITIONS
        and #JOY_GO_DOWN
        beq check_joy_fire
        jsr joy_down

    check_joy_fire:
        lda JOYSTICK_POSITIONS
        and #JOY_GO_FIRE
        beq end_read_joystick
        jsr joy_fire

    end_read_joystick:


## Maths functions

### SUM Function

This is a function to sum 2 numbers. Each byte of this number must be store in
each byte , starting from the LOW byte. The IN params are sum_1_0 , sum_1_1,
sum_1_2 ,sum_1_3 for the first number and sum_2_0 , sum_2_1, sum_2_2 ,sum_2_3.

The OUT params are the same. You can use them in the function 
"print_calculation_result"

Example: 65765 + 89927 = 155692

//load N1
lda #$0C
sta sum_num1_0

lda #$00
sta sum_num1_1

lda #$00
sta sum_num1_2

lda #$00
sta sum_num1_3

//load N2
lda #$00
sta sum_num2_0

lda #$00
sta sum_num2_1

lda #$00
sta sum_num2_2

lda #$00
sta sum_num2_3

//set to 0 result
lda #0
sta sum_res_0
sta sum_res_1
sta sum_res_2
sta sum_res_3

//calculate sum
jsr MATH_LIB.sum_32
print_calculation_result(19,5,YELLOW,sum_res_0,sum_res_1,sum_res_2,sum_res_3)


DEMO: /demos/math_lib/sum_32_bits.asm


### SUB Function


This is a function to sub 2 numbers. Each byte of this number must be store in
each byte , starting from the LOW byte. The IN params are sub_1_0 , sub_1_1,
sub_1_2 ,sub_1_3 for the first number and sub_2_0 , sub_2_1, sub_2_2 ,sub_2_3.

The OUT params are the same. You can use them in the function 
"print_calculation_result"


// N1
lda #$47
sta sub_num1_0
lda #$5F
sta sub_num1_1
lda #$01
sta sub_num1_2
lda #$00
sta sub_num1_3

// N2
lda #$E5
sta sub_num2_0
lda #$00
sta sub_num2_1
lda #$01
sta sub_num2_2
lda #$00
sta sub_num2_3

// Result
lda #0
sta sub_res_0
sta sub_res_1
sta sub_res_2
sta sub_res_3

// Do the calculation
jsr MATH_LIB.sub_32

//Print the result
print_calculation_result(10,3,YELLOW,sub_res_0,sub_res_1,sub_res_2,sub_res_3)

DEMO: /demos/math_lib/sub_32_bits.asm


### MUL function

This is a function to mul 2 numbers. Each byte of this number must be store in
each byte , starting from the LOW byte. The IN params are mul_num1_0,mul_num1_1,
mul_num1_2 , mul_num1_3 for the first mul_num2_0,mul_num2_1,mul_num2_2, 
mul_num2_3

The OUT params are the same. You can use them in the function 
"print_calculation_result"


// do the multiplication
// 9547 x 13 = 122941

lda #$f1
sta mul_num1_0 
lda #$24
sta mul_num1_1
lda #$00
sta mul_num1_2
lda #$00
sta mul_num1_3

lda #$0D
sta mul_num2_0
lda #$00
sta mul_num2_1
lda #$00
sta mul_num2_2
lda #$00
sta mul_num2_3

//set to 0 result
lda #$00
sta mul_res_0
sta mul_res_1
sta mul_res_2
sta mul_res_3

jsr MATH_LIB.multiplication_32    

// Print the result of calculation on screen
print_calculation_result(17,5,PINK,mul_res_0,
                                   mul_res_1,
                                   mul_res_2,
                                   mul_res_3)

DEMO: /demos/math_lib/multiplication_32_bits.asm


### DIV function



This is a function to mul 2 numbers. Each byte of this number must be store in
each byte , starting from the LOW byte. The IN params are mul_num1_0,mul_num1_1,
mul_num1_2 , mul_num1_3 for the first mul_num2_0,mul_num2_1,mul_num2_2, 
mul_num2_3

The OUT params are the same. You can use them in the function 
"print_calculation_result"

DEMO: /demos/math_lib/division_32_bits.asm


//Low byte to hight byte
// 158272 / 81 = 1953
//N1
lda #$40
sta div_num1_0 
lda #$6A
sta div_num1_1
lda #$02
sta div_num1_2
lda #$00
sta div_num1_3

//N2
lda #$51
sta div_num2_0
lda #$00
sta div_num2_1
lda #$00
sta div_num2_2
lda #$00
sta div_num2_3

//Set result to 0
lda #$00
sta div_res_0
sta div_res_1
sta div_res_2
sta div_res_3

//calculate division
jsr MATH_LIB.division_32

// Print the result of calculation on screen
print_calculation_result(17,5,PINK,div_res_0,div_res_1,div_res_2,div_res_3)



## Tiles functions ( load maps in screen )    


One we have configured our .bin file with the map data , only you need call this
macro : 

print_map(map_number)

Example : 

print_map(3)

This function will render a map in our screen. This is a macro , but , if we
need change our map programatically:

    lda #3
    sta MAP_NUMBER
    jsr TILES_LIB.load_map


This load the map number 3 . The IN param for this funtion is MAP_NUMBER    