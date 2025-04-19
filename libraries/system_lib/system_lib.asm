SYSTEM:
{
	setup:
    
		sei // Disable system interrupts
		lda #%00110110 // Disable BASIC
        cli // Enable system interrupts

}