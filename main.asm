#import "/system/config.asm"
#import "/system/memory_map.asm"
#import "/includes/constants.asm"

BasicUpstart2(main)

*=MAIN_CODE_ADDRESS "Main Code"
#import "/includes/main_code.asm"


*=TILESET_ADDRESS "Tileset"
.import binary "/tileset/tileset.bin"


/*
*=MUSIC_ADDRESS "Music"
.import binary "/music/music.sid"
*/


*=CHARSET_ATTRIB_ADDRESS "Charset Attrib"
.import binary "/charset/charsetAttrib.bin"


*=VARIABLES_ADDRESS "Variables"
#import "/includes/variables.asm"


*=SPRITES_ADDRESS "Sprites"
//.import binary "/sprites/sprites.bin"
//.import binary "/sprites/numbers.bin"
//.import binary "/sprites/numbersv2.bin"
.import binary "/sprites/numbers12sprites.bin"


*=CHARSET_ADDRESS "Charset"
.import binary "/charset/charset.bin"


*=TABLES_ADDRESS "Tables"
#import "/includes/tables.asm"

*=LIBRARIES_ADDRESS "Libraries"
#import "/includes/libraries.asm"


*=MAP_ADDRESS "Maps"
//.import binary "/maps/allmaps.bin"
//.import binary "/maps/singlemap.bin"
//.import binary "/maps/rooms.bin"
.import binary "/maps/demomap.bin"


//*=MAPS_COLOR_ADDRESS "Maps Colors"
//.import binary "/maps/colormap.bin"

