JOYSTICK_2_NO_MOVE: .byte %00011111
JOYSTICK_2_DATA:    .byte 0
JOYSTICK_2_FIRE:    .byte %00010000

JOYSTICK_2_UP:      .byte 0 // %00000001
JOYSTICK_2_DOWN:    .byte 0 // %00000010
JOYSTICK_2_LEFT:    .byte 0 // %00000100
JOYSTICK_2_RIGHT:   .byte 0 //%00001000


/* Set positions joystick:
    0 : UP
    1 : DOWN
    2 : LEFT
    3 : RIGHT
    4 : FIRE BUTTON
*/
JOYSTICK_POSITIONS: .byte 0  