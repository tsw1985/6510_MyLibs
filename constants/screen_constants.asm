//SCREEN CONFIG
//=============


.label SCREEN_WIDTH            = 40 // Cols
.label SCREEN_HEIGHT           = 25 // Rows
.label SCREEN_SIZE             = SCREEN_WIDTH * SCREEN_HEIGHT
.label SCREEN_CONTROL_1        = $d011
.label SCREEN_CONTROL_2        = $d016


// Rooms:
.label MAP_WIDTH  = 16 // Tiles
.label MAP_HEIGHT = 12 // Tiles
.label MAP_SIZE   = MAP_WIDTH * MAP_HEIGHT



//COLORS:
//=======

.label BLACK  = $00
.label WHITE  = $01
.label RED    = $02
.label CYAN   = $03
.label PURPLE = $04
.label GREEN  = $05
.label BLUE   = $06
.label YELLOW = $07
.label ORANGE = $08
.label BROWN  = $09
.label PINK   = $0A
.label GREY   = $0C
.label LIGHT_GREEN = $0D
.label LIGHT_BLUE  = $0E
.label LIGHT_GRAY  = $0F
.label DARK_GRAY   = $0B


.label DEFAULT_SCREEN_BORDER_COLOR = BLACK
.label DEFAULT_SCREEN_BACKGROUND_COLOR = BLACK

.label DEFAULT_SCREEN_EXTRA_COLOR_1 = LIGHT_BLUE
.label DEFAULT_SCREEN_EXTRA_COLOR_2 = BROWN

.label SCREEN_EXTRA_COLOR_1 = $d022
.label SCREEN_EXTRA_COLOR_2 = $d023






//RASTER IRQ:
//===========

.label INTERRUPT_CONTROL_AND_STATUS1 = $dc0d
.label INTERRUPT_CONTROL_AND_STATUS2 = $dd0d
.label INTERRUPT_EXEC_ADDR1_SERVICE  = $0314
.label INTERRUPT_EXEC_ADDR2_SERVICE  = $0315
.label CURRENT_RASTER_LINE           = $d012
.label INTERRUPT_STATUS              = $d019
.label INTERRUPT_CONTROL             = $d01a
.label INTERRUPT_RETURN	             = $ea81

//SPRITE CONSTANTS:
//=================

.label SPRITE_HEIGHT = 21
.label SPRITE_WIDTH  = 24
.label SPRITE_CENTER_WIDTH_OFFSET  = 12 // 24px / 2 = 12
.label SPRITE_CENTER_HEIGHT_OFFSET = 10 // 21px / 2 = 10.5 ( 10 rounded )
