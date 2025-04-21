//here are division , substraction, multiplication , adding

MATH_LIB:
{
    /*
        Division 16 bits:
        Input: 

            div_number_16_lo
            div_number_16_hi
            div_divisor_16_lo
            div_divisor_16_hi
            div_result_16_lo
            div_result_16_hi

        Output:

            div_result_16_lo
            div_result_16_hi

    */
    //Start div 16 bits
    division_16:
        
        pha  // save A on stack
        txa  // transfer X to A
        pha  // push A (X) on stack
        tya  // transfer Y to A
        pha  // push A (Y) to stack
        

        continue_substraction_16:
            sec                    // sec carry to substraction to 0
            lda div_number_16_lo  // Restamos partes LOW del numero
            sbc div_divisor_16_lo
            sta div_number_16_lo  // actualizamos number_1_lo con el resultado de la resta

            lda div_number_16_hi  // Restamos partes HI del numero  
            sbc div_divisor_16_hi  // actualizamos divisor_hi con el resultado de la resta
            sta div_number_16_hi

            // incrementamos el cociente, de 1 en 1 , en 16 bits
            clc
            lda div_result_16_lo
            adc #1            // sumamos 1 a low
            sta div_result_16_lo
            lda div_result_16_hi     // sumamos hi con carry si es necesario
            adc #0
            sta div_result_16_hi

            lda div_number_16_hi  // comparamos si la parte alta de number_1_hi todavía es mayor a la al de divisor_hi
            cmp div_divisor_16_hi  // comparamos.
            bne continue_substraction_16  // ¿ no son iguales ? Quiere decir que aun es mayor , así que vuelve a restar

            lda div_number_16_lo     // cargamos en A la parte LOW de number_1 .
            cmp div_divisor_16_lo     // comparamos 
            bcs continue_substraction_16 // ¿ number_1_lo es mayor a divisor_lo ( 10 ) ? pues sigue restando
        
        pla // pull A from stack (Y)
        tay // transfer A to Y
        pla // pull A from stack (X)
        tax // transfer A to X
        pla // pull A from Stack
        

    rts //return
//end DIV 16 bits

/*************************************************************/
/******************** DIVISION 32 bits ***********************/
/*************************************************************/
division_32:
    // guardar registros
    pha
    txa
    pha
    tya
    pha


        loop:
        //; Comparar A >= B
        lda div_num1_3
        cmp div_num2_3
        bcc end_loop
        bne do_subtract

        lda div_num1_2
        cmp div_num2_2
        bcc end_loop
        bne do_subtract

        lda div_num1_1
        cmp div_num2_1
        bcc end_loop
        bne do_subtract

        lda div_num1_0
        cmp div_num2_0
        bcc end_loop

do_subtract:
        
        sec
        lda div_num1_0
        sbc div_num2_0
        sta div_num1_0

        lda div_num1_1
        sbc div_num2_1
        sta div_num1_1


        lda div_num1_2
        sbc div_num2_2
        sta div_num1_2

        lda div_num1_3
        sbc div_num2_3
        sta div_num1_3
        

        clc
        lda div_res_0
        adc #1
        sta div_res_0

        lda div_res_1
        adc #0
        sta div_res_1

        lda div_res_2
        adc #0
        sta div_res_2

        lda div_res_3
        adc #0
        sta div_res_3

        jmp loop

end_loop:

    .break
    lda div_res_3
    lda div_res_2
    lda div_res_1
    lda div_res_0


    // Restaurar registros
    pla
    tay
    pla
    tax
    pla
    rts






















    /*
        Multiplication 16 bits

        Input:

            mul_number_16_lo
            mul_number_16_hi

            mul_multiplicator_16_lo
            mul_multiplicator_16_hi

        Output:

            mulresult_16_lo
            mul_result_16_hi
    */
    multiplication_16:

        pha  // save A on stack
        txa  // transfer X to A
        pha  // push A (X) on stack
        tya  // transfer Y to A
        pha  // push A (Y) to stack


        continue_multiplication:
            clc                   // clear carry
            lda mul_result_16_lo
            adc mul_number_16_lo
            sta mul_result_16_lo

            lda mul_result_16_hi
            adc mul_number_16_hi
            sta mul_result_16_hi

            //restar multiplicador
            sec
            lda mul_multiplicator_16_lo
            sbc #$1
            sta mul_multiplicator_16_lo

            lda mul_multiplicator_16_hi
            sbc #$0
            sta mul_multiplicator_16_hi

            lda mul_multiplicator_16_lo
            
            // ¿ Los 2 bytes son ya 0 ? 
            ora mul_multiplicator_16_hi // comprueba ambos bytes si son 0 , con ORA
            
            // si no , pues sigue multiplicando
            bne continue_multiplication

        pla // pull A from stack (Y)
        tay // transfer A to Y
        pla // pull A from stack (X)
        tax // transfer A to X
        pla // pull A from Stack
        
        rts //return 




        

}