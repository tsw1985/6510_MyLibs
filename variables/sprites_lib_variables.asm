/* Sprites COLORS */
SPRITE_FRAME_POINTER: .byte 0
SPRITE_TO_ENABLE:     .byte 0
SPRITE_COLOR:         .byte 0
SPRITE_Y_POS:         .byte 0
SPRITE_X_POS:         .byte 0

SPRITE_RASTER_COUNTER: .byte 0
SPRITE_PAD_INDEX:      .byte 0


SPRITE_0_FRAME_COUNTER: .byte 0

ANIMATION_FRAMES_LIST_LO: .byte 0
ANIMATION_FRAMES_LIST_HI: .byte 0

/* SPRITE TABLES */
/*  This 2 tables are main list where are listed all animations. We get the
    HI and LOW bytes to create a address in the ZERO PAGE using: 
    
        ZERO_PAGE_SPRITE_HIGHT_BYTE
        ZERO_PAGE_SPRITE_LOW_BYTE
*/
sprite_animations_list_LO:
    .byte <sprite_air_plane_air_animation

sprite_animations_list_HI:
    .byte >sprite_air_plane_air_animation

/* Individual animations */
/* Air Plane In air  */
sprite_air_plane_air_animation:
    .byte 10   // Frame 0 in Sprite pad
    .byte 11   // Frame 1 in Sprite pad
    .byte 12   // Frame 2 in Sprite pad
    .byte 13   // Frame 3 in Sprite pad
    .byte 14   // Frame 4 in Sprite pad
    .byte 15   // Frame 5 in Sprite pad
    .byte 255 // Finish animation
/* Sprites animations speed */

/* 
    Sprites tracking table . Each entry is used to save the current index
    (wich frame ) of each animation.

*/
sprites_tracking_table:
    .byte 0   // sprite 0
    .byte 0   // sprite 1
    .byte 0   // sprite 2
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0