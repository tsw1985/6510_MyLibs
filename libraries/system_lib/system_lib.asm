#import "system_macros/system_lib_macros.asm"

SYSTEM:
{

setup:

	//kernel_status
	push_regs_to_stack()

	sei // Disable system interrupts
	lda $0001
	sta system_status // backup of MAPS_ADDRESS $0001

	/* Disable BASIC to use his free space */
	disable_basic()

	/* Configure char set and Screen RAM: $0400 */
	enable_custom_charset()

	/* Enable Screen like multicolor */
	enable_screen_multicolor()

	/* SET DEFAULT COLORS */
	set_default_screen_colors()

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