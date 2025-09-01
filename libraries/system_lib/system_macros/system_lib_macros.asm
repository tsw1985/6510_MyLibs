/* Disable basic and uset his memory space */
.macro disable_basic(){
    lda #%00110110 // Disable BASIC
	sta $0001 // Processor port
}

/* Enable screen like multicolor */
.macro enable_screen_multicolor(){
    lda #%11011000 // Enable screen multicolor
    sta SCREEN_CONTROL_2
}

/* Configure colors in Screen */
.macro set_default_screen_colors(){
    set_border_color(DEFAULT_SCREEN_BORDER_COLOR)
    set_background_color(DEFAULT_SCREEN_BACKGROUND_COLOR)
    set_extra_color_1(DEFAULT_SCREEN_EXTRA_COLOR_1)
    set_extra_color_2(DEFAULT_SCREEN_EXTRA_COLOR_2)
}

/* Set a custom border color */
.macro set_border_color(color){
    lda #color
    sta SCREEN_BORDER_COLOR
}

/* Set a custom background color */
.macro set_background_color(color){
    lda #color
    sta SCREEN_BACKGROUND_COLOR
}

/* Set extra color 1 */
.macro set_extra_color_1(color){
    lda #color
    sta SCREEN_EXTRA_COLOR_1
}

/* Set extra color 2 */
.macro set_extra_color_2(color){
    lda #color
    sta SCREEN_EXTRA_COLOR_2
}


/* Here we are setting the position of Screen ram and where is the
charset to use, in the address $3800 */
.macro enable_custom_charset(){
    lda #%00011110 // Screen RAM: $0400   Charset: $3800
    sta $d018      // Screen memory setup
}

