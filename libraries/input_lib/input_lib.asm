INPUT_LIB:
{

    #import "input_macros/input_lib_macros.asm"

    input_keyboard:
        // Port A = enter
        lda #$00
        sta $DC02 //; ---> $DC00

        // Port B = exit
        lda #$ff
        sta $DC03 //; ---> $DC01

    read_key:
        jsr clear_key_pressed_table
        
        // Primer paso: escanear todas las teclas sin imprimir nada
        jsr scan_all_keys
        
        // Segundo paso: imprimir resultados de las teclas detectadas
        jsr print_key_results
        
        jsr sleep_key    // Un solo sleep después de todas las impresiones
        jmp read_key

    scan_all_keys:
        ldx #0
    scan_rows_loop:
        lda TABLE_KEY_BOARD_ROW,x
        sta $DC01

        lda $DC00
        eor #%11111111
        sta KEY_PRESSED

        ldy #0
    
    scan_cols_loop:

        lda KEY_PRESSED
        and TABLE_KEY_BOARD_COL,y
        beq no_key_detected

        // Calcular offset y guardar en la tabla
        stx TEMP_X_REG    // Guardar X temporalmente
        sty TEMP_Y_REG    // Guardar Y temporalmente
        
        jsr calculate_offset_for_ascii_table
        
        ldy TABLE_KEY_ASCII_X_OFFSET
        lda #1
        sta PRESSED_KEY_TABLE,y
        
        ldx TEMP_X_REG    // Restaurar X
        ldy TEMP_Y_REG    // Restaurar Y

    no_key_detected:
        iny
        cpy #8
        bne scan_cols_loop

        inx
        cpx #8
        bne scan_rows_loop
        rts

    print_key_results:
        // Esta función imprimirá todas las teclas detectadas

    check_combo_keys:

        ldx #47  //CMB OFFSET !! not value
        lda PRESSED_KEY_TABLE,x
        beq skip // A value is 0 ? skip

        ldx #16 //Cursor key
        lda PRESSED_KEY_TABLE,x
        beq skip // A value is 0 ? skip

        // If not skip , means CMB + Cursor is pressed, move to left cursor
        .break
        rts

        skip:
            //ldx #16 //check again cursor key . Here is only cursor key
            //lda PRESSED_KEY_TABLE,x
            //bne is_only_cursor_key // A value is == 1 ?

        rts
        
    //; -------------------- Functions ---------------------------

    print_offset_result:
        jsr PRINT_LIB.clean_location_screen
        locate_text(4,0,WHITE)
        print_text(calc_offset_str)

        lda TABLE_KEY_ASCII_X_OFFSET
        sta div_res_0
        lda #0
        sta div_res_1
        sta div_res_2
        sta div_res_3

        jsr PRINT_LIB.clean_location_screen
        print_calculation_result(4,8,YELLOW,div_res_0,div_res_1,div_res_2,div_res_3)
        rts

    sleep_key:
        ldx #120
    outer_loop:
        ldy #120
    inner_loop:
        nop
        dey
        bne inner_loop
        dex
        bne outer_loop
        rts

    clear_key_pressed_table:
        ldx #0
    clear_pressed:
        lda #0
        sta PRESSED_KEY_TABLE,x
        inx
        cpx #64
        bne clear_pressed
        rts

    calculate_offset_for_ascii_table:
        txa
        asl
        asl
        asl
        sta temp_offset
        tya
        clc
        adc temp_offset
        sta TABLE_KEY_ASCII_X_OFFSET
        rts

}
