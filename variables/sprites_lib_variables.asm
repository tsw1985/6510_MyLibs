/* Pointer where start the sprites information, the pictures.
Each sprite are 64 bytes. */
SPRITE_INDEX_POINTER: .byte SPRITES_ADDRESS / $40  //  ( $3000 / 64 )

/* SPRITE_FRAME_POINTER: Value used to point to a sprite in a sprite pointer */
SPRITE_FRAME_POINTER: .byte 0 

/* SPRITE_TO_ENABLE: Value to select a sprite and enable it. Used in 
macro "sprite_enable_sprite" */
SPRITE_TO_ENABLE:     .byte 0

/* SPRITE_COLOR: Value to set a sprite color */
SPRITE_COLOR:         .byte 0

/* TODO: move to a table*/ 
SPRITE_Y_POS:         .byte 0
SPRITE_X_POS:         .byte 0

/* SPRITE_PAD_INDEX: Returned value index in the sprite pad pallete. 
   Used in function: sprite_get_current_index_sprite_pad_value_animation */
SPRITE_PAD_INDEX:      .byte 0

/* SPRITE_ANIMATION_VALUE_OFFSET: Value used into the function
"sprite_get_current_index_sprite_pad_value_animation" , to move us in a 
sprite animation list */
SPRITE_ANIMATION_VALUE_OFFSET: .byte 0

/* ANIMATION_FRAMES_LIST_LO and ANIMATION_FRAMES_LIST_HI:

Values with contains the LOW and HIGHT bytes of a animation list address.
They are used in function "sprite_get_current_index_sprite_pad_value_animation"
to create the ZP pointer used in this function */
ANIMATION_FRAMES_LIST_LO: .byte 0
ANIMATION_FRAMES_LIST_HI: .byte 0


/* SPRITE TABLES */
/*  This 2 tables are main list where are listed all animations. We get the
    HI and LOW bytes to create a address in the ZERO PAGE using: 
    
        ZERO_PAGE_SPRITE_HIGHT_BYTE
        ZERO_PAGE_SPRITE_LOW_BYTE

    The limit list is 8 Sprites.
*/
sprite_animations_list_LO_table:
    .byte <sprite_animation_1_to_10  // Animation for sprite 1
    .byte <sprite_animation_1_to_10  // Animation for sprite 2
    .byte <sprite_animation_1_to_10  // Animation for sprite 3
    .byte <sprite_animation_1_to_10  // Animation for sprite 4
    .byte <sprite_animation_1_to_10  // Animation for sprite 5
    .byte <sprite_animation_1_to_10  // Animation for sprite 6
    .byte <sprite_animation_1_to_10  // Animation for sprite 7
    .byte <sprite_animation_1_to_10  // Animation for sprite 8

    
sprite_animations_list_HI_table:
    .byte >sprite_animation_1_to_10  // Animation for sprite 1
    .byte >sprite_animation_1_to_10  // Animation for sprite 2
    .byte >sprite_animation_1_to_10  // Animation for sprite 3
    .byte >sprite_animation_1_to_10  // Animation for sprite 4
    .byte >sprite_animation_1_to_10  // Animation for sprite 5
    .byte >sprite_animation_1_to_10  // Animation for sprite 6
    .byte >sprite_animation_1_to_10  // Animation for sprite 7
    .byte >sprite_animation_1_to_10  // Animation for sprite 8



/*

This tables are used to set the coords for each sprite
*/
/* SPRITES COORDS Y */
sprites_coord_table_y:
    .byte 0  // coor Y for sprite 1
    .byte 0  // coor Y for sprite 2
    .byte 0  // coor Y for sprite 3
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0

/* SPRITES COORDS X */
sprites_coord_table_x:
    .byte 0  // coor X for sprite 1
    .byte 0  // coor X for sprite 2
    .byte 0  // coor X for sprite 3
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0



/* Sprites animations speed */
sprites_rasters_limit_table:
    .byte 20 // Speed for Sprite 1
    .byte 30 // Speed for Sprite 2
    .byte 40 // Speed for Sprite 3
    .byte 50 // Speed for Sprite 4
    .byte 25 // Speed for Sprite 5
    .byte 15 // Speed for Sprite 6
    .byte 8 // Speed for Sprite 7
    .byte 4 // Speed for Sprite 8


/* Sprites frame counters table */
sprites_raster_counters_table:
    .byte 0  // current frame counter sprite 1
    .byte 0  // current frame counter sprite 2
    .byte 0  // current frame counter sprite 3
    .byte 0  // current frame counter sprite 4
    .byte 0  // current frame counter sprite 5
    .byte 0  // current frame counter sprite 6
    .byte 0  // current frame counter sprite 7
    .byte 0  // current frame counter sprite 8


/* Indices de animación */
sprites_animation_index_table:
    .byte 0  // current animation frame index sprite 1
    .byte 0  // current animation frame index sprite 2
    .byte 0  // current animation frame index sprite 3
    .byte 0  // current animation frame index sprite 4
    .byte 0  // current animation frame index sprite 5
    .byte 0  // current animation frame index sprite 6
    .byte 0  // current animation frame index sprite 7
    .byte 0  // current animation frame index sprite 8


/* ************************************************** */
/*            Individual animations                   */
/* ************************************************** */
/* Animation full: count 1 to 10 */
sprite_animation_1_to_10:
    .byte 0   // Frame 0 in Sprite pad
    .byte 1   // Frame 1 in Sprite pad
    .byte 2   // Frame 2 in Sprite pad
    .byte 3   // Frame 3 in Sprite pad
    .byte 4   // Frame 3 in Sprite pad
    .byte 5   // Frame 0 in Sprite pad
    .byte 6   // Frame 1 in Sprite pad
    .byte 7   // Frame 2 in Sprite pad
    .byte 8   // Frame 3 in Sprite pad
    .byte 9   // Frame 3 in Sprite pad
    .byte 255 // Finish animation

/* Animation 1: count 1 to 5 */
sprite_animation_1_to_5:
    .byte 0    // Frame 0 in Sprite pad
    .byte 1   // Frame 1 in Sprite pad
    .byte 2   // Frame 2 in Sprite pad
    .byte 3   // Frame 3 in Sprite pad
    .byte 4   // Frame 3 in Sprite pad
    .byte 255 // Finish animation

/* Animation 2: count 5 to 10 */
sprite_animation_5_to_9:
    .byte 4   // Frame 5 in Sprite pad
    .byte 5   // Frame 6 in Sprite pad
    .byte 6   // Frame 7 in Sprite pad
    .byte 7   // Frame 8 in Sprite pad
    .byte 8   // Frame 8 in Sprite pad
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






