#import "/system/config.asm"
#import "/system/memory_map.asm"
#import "/includes/constants.asm"

BasicUpstart2(main)

*=MAIN_CODE_ADDRESS "Main Code"
#import "/includes/main_code.asm"

/*
*=MUSIC_ADDRESS "Music"
.import binary "/music/music.sid"
*/

/*
*=CHARSET_ATTRIB_ADDRESS "Charset Attrib"
.import binary "/charset/charsetAttrib.bin"
*/

*=VARIABLES_ADDRESS "Variables"
#import "/includes/variables.asm"


*=SPRITES_ADDRESS "Sprites"
.import binary "/sprites/sprites.bin"


/*
*=CHARSET_ADDRESS "Charset"
.import binary "/charset/charset.bin"
*/

*=TABLES_ADDRESS "Tables"
#import "/includes/tables.asm"

*=LIBRARIES_ADDRESS "Libraries"
#import "/includes/libraries.asm"

/*
*=MAPS_ADDRESS "Maps"
.import binary "/maps/map2.bin"
*/

/*
*=MAPS_COLOR_ADDRESS "Maps Colors"
.import binary "/maps/map2color.bin"
*/