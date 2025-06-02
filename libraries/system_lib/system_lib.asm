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
		
		/*sei // Disable system interrupts
		lda #%00110110 // Disable BASIC
		sta $0001 // Processor port
        cli // Enable system interrupts
		rts*/


		/*
		lda #%00011110 // Screen RAM: $0400   Charset: $3800
		sta $d018 // Screen memory setup

		lda #%11010111 // Enable screen multicolor   Screen width: 38 cols
					   // Scroll bits: Screen adjusted to the right
		sta $d016 // Screen control 2

		lda #BLACK
		sta $d020 // Screen border color

		lda #BLACK
		sta $d021 // Screen background color

		lda #LIGHT_BLUE
		sta $d022 // Screen extra color 1

		lda #BROWN
		sta $d023 // Screen extra color 2

		jsr INTERRUPT.setupRasterInterrupt

		rts*/

}