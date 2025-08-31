SYSTEM:
{
	setup:
    
		//kernel_status
		push_regs_to_stack()
		
		sei // Disable system interrupts
		lda $0001
		sta system_status // backup of MAPS_ADDRESS
		                   // $0001

		lda #%00110110 // Disable BASIC
		sta $0001 // Processor port

		
		/* Configure char set */
		jsr TILES_LIB.init_new_charset
		//lda #%00011110 // Screen RAM: $0400   Charset: $3800
		//sta SCREEN_MEMORY_SETUP

		lda #%11011000 // Enable screen multicolor
		sta SCREEN_CONTROL_2

		/* SET DEFAULT COLORS */
		lda #DEFAULT_SCREEN_BORDER_COLOR
		sta SCREEN_BORDER_COLOR
		lda #DEFAULT_SCREEN_BACKGROUND_COLOR
		sta SCREEN_BACKGROUND_COLOR
		lda #DEFAULT_SCREEN_EXTRA_COLOR_1
		sta SCREEN_EXTRA_COLOR_1
		lda #DEFAULT_SCREEN_EXTRA_COLOR_2
		sta SCREEN_EXTRA_COLOR_2

        cli // Enable system interrupts


		pull_regs_from_stack()
		rts

	//go back to the status before change
	//the address 0001 . Without this, when
	//the program finish, the C64 is died
	restore_system:
		push_regs_to_stack()
		sei
		lda system_status
    	sta $0001		
		cli
		pull_regs_from_stack()
		rts
		
}