// ---------------------- CONFIG ----------------------

// ZERO PAGE
//==========
/*******************************************************************************
    !!!!!!!! IMPORTANT !!!! ALWAYS START BY LO BYTE.  !!!!!!!!!!!
*******************************************************************************/

.label ZERO_PAGE_ADDRESS              = $0020     

.label ZERO_PAGE_ROW_LOW_BYTE         = ZERO_PAGE_ADDRESS + 0 // $20
.label ZERO_PAGE_ROW_HIGHT_BYTE       = ZERO_PAGE_ADDRESS + 1 // $21

.label ZERO_PAGE_PRINT_TEXT_LO        = ZERO_PAGE_ADDRESS + 2 // $22
.label ZERO_PAGE_PRINT_TEXT_HI        = ZERO_PAGE_ADDRESS + 3 // $23

.label ZERO_PAGE_ROW_COLOR_LOW_BYTE   = ZERO_PAGE_ADDRESS + 4 // $24
.label ZERO_PAGE_ROW_COLOR_HIGHT_BYTE = ZERO_PAGE_ADDRESS + 5 // $25

.label ZERO_PAGE_SPRITE_LOW_BYTE      = ZERO_PAGE_ADDRESS + 6 // $27
.label ZERO_PAGE_SPRITE_HIGHT_BYTE    = ZERO_PAGE_ADDRESS + 7 // $26

.label ZERO_PAGE_MAP_LO	          = ZERO_PAGE_ADDRESS + 8 // $28
.label ZERO_PAGE_MAP_HI	          = ZERO_PAGE_ADDRESS + 9 // $29



