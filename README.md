# Small libs

# PRINT TEXT FUNCTIONS
- Print a char
    
    lda #1 // A
    sta SCREEN_CHAR
    locate_text(3,4,0)
    jsr print_char  // print single char

# Print a string text

    jsr clean_location_screen
    locate_text(4,1,0) // row,col,color
    load_text(message) // string