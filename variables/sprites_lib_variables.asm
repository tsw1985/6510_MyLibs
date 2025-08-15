SPRITE_INDEX_POINTER: .byte SPRITES_ADDRESS / $40  //  ( $3000 / 64 )


/* Sprites COLORS */
SPRITE_FRAME_POINTER: .byte 0
SPRITE_TO_ENABLE:     .byte 0
SPRITE_COLOR:         .byte 0
SPRITE_Y_POS:         .byte 0
SPRITE_X_POS:         .byte 0

SPRITE_RASTER_COUNTER: .byte 0
SPRITE_PAD_INDEX:      .byte 0
SPRITE_PAD_INDEX_FUTURE: .byte 0
SPRITE_INDEX_COUNTER: .byte 0
SPRITE_CURRENT_SPRITE_SPEED: .byte 0


/* Temp values */
ANIMATION_FRAMES_LIST_LO: .byte 0
ANIMATION_FRAMES_LIST_HI: .byte 0

/* SPRITE TABLES */
/*  This 2 tables are main list where are listed all animations. We get the
    HI and LOW bytes to create a address in the ZERO PAGE using: 
    
        ZERO_PAGE_SPRITE_HIGHT_BYTE
        ZERO_PAGE_SPRITE_LOW_BYTE

    The limit list is 8 Sprites.
*/
sprite_animations_list_LO:
    .byte <sprite_animation_1_to_5  // Animation for sprite 1
    .byte <sprite_animation_5_to_9  // Animation for sprite 2
    .byte <sprite_animation_1_to_3  // Animation for sprite 2
    .byte <sprite_animation_1_to_2  // Animation for sprite 2
    .byte <sprite_animation_4_to_1  // Animation for sprite 2
    .byte <sprite_animation_2_4_6_8 // Animation for sprite 2
    .byte <sprite_animation_2_4     // Animation for sprite 2
    .byte <sprite_animation_9_10    // Animation for sprite 2

    

sprite_animations_list_HI:
    .byte >sprite_animation_1_to_5  // Animation for sprite 1
    .byte >sprite_animation_5_to_9  // Animation for sprite 2
    .byte >sprite_animation_1_to_3  // Animation for sprite 2
    .byte >sprite_animation_1_to_2  // Animation for sprite 2
    .byte >sprite_animation_4_to_1  // Animation for sprite 2
    .byte >sprite_animation_2_4_6_8 // Animation for sprite 2
    .byte >sprite_animation_2_4     // Animation for sprite 2
    .byte >sprite_animation_9_10    // Animation for sprite 2


/* Sprites animations speed */
sprites_animations_speed:
    .byte 40 // Speed for Sprite 1
    .byte 10 // Speed for Sprite 2
    .byte 45 // Speed for Sprite 3
    .byte 5  // Speed for Sprite 4
    .byte 50 // Speed for Sprite 5
    .byte 13 // Speed for Sprite 6
    .byte 20 // Speed for Sprite 7
    .byte 16 // Speed for Sprite 8


/* Sprites frame counters table */
sprites_frame_counters:
    .byte 0  // current frame counter sprite 1
    .byte 0  // current frame counter sprite 2
    .byte 0  // current frame counter sprite 3
    .byte 0  // current frame counter sprite 4
    .byte 0  // current frame counter sprite 5
    .byte 0  // current frame counter sprite 6
    .byte 0  // current frame counter sprite 7
    .byte 0  // current frame counter sprite 8


/* ************************************************** */
/*            Individual animations                   */
/* ************************************************** */

/* Animation 1: count 1 to 5 */
sprite_animation_1_to_5:
    .byte 10   // Frame 0 in Sprite pad
    .byte 20   // Frame 1 in Sprite pad
    .byte 30   // Frame 2 in Sprite pad
    .byte 40   // Frame 3 in Sprite pad
    .byte 50   // Frame 4 in Sprite pad
    .byte 60   // Frame 5 in Sprite pad
    .byte 70   // Frame 6 in Sprite pad
    .byte 80   // Frame 7 in Sprite pad
    .byte 90   // Frame 8 in Sprite pad
    .byte 100   // Frame 8 in Sprite pad
    .byte 255 // Finish animation

/* Animation 2: count 5 to 10 */
sprite_animation_5_to_9:
    .byte 5   // Frame 5 in Sprite pad
    .byte 6   // Frame 6 in Sprite pad
    .byte 7   // Frame 7 in Sprite pad
    .byte 8   // Frame 8 in Sprite pad
    .byte 9   // Frame 9 in Sprite pad
    .byte 255 // Finish animation

/* Animation 3: count 1 to 3 */
sprite_animation_1_to_3:
    .byte 0   // Frame 5 in Sprite pad
    .byte 1   // Frame 6 in Sprite pad
    .byte 2   // Frame 7 in Sprite pad
    .byte 255 // Finish animation


/* Animation 4: count 1 to 2 */
sprite_animation_1_to_2:
    .byte 0   // Frame 5 in Sprite pad
    .byte 1   // Frame 6 in Sprite pad
    .byte 255 // Finish animation

/* Animation 5: count 4 to 1 */
sprite_animation_4_to_1:
    .byte 3   // Frame 5 in Sprite pad
    .byte 2   // Frame 6 in Sprite pad
    .byte 1   // Frame 6 in Sprite pad
    .byte 0   // Frame 6 in Sprite pad
    .byte 255 // Finish animation    


/* Animation 6: show 2-4-6-8 */
sprite_animation_2_4_6_8:
    .byte 1   // Frame 5 in Sprite pad
    .byte 3   // Frame 6 in Sprite pad
    .byte 5   // Frame 6 in Sprite pad
    .byte 7   // Frame 6 in Sprite pad
    .byte 255 // Finish animation        


/* Animation 7: show 2-4 */
sprite_animation_2_4:
    .byte 1   // Frame 5 in Sprite pad
    .byte 3   // Frame 6 in Sprite pad
    .byte 255 // Finish animation        


/* Animation 8: show 2-4 */
sprite_animation_9_10:
    .byte 8   // Frame 5 in Sprite pad
    .byte 9   // Frame 6 in Sprite pad
    .byte 255 // Finish animation






