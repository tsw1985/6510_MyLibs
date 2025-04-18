#import "math_variables/math_variables.asm"

//here are division , substraction, multiplication , adding

/*
    Division 16 bits:
    Input: 

        division_number_1_lo
        division_number_1_hi
        division_divisor_lo
        division_divisor_hi
        division_result_lo
        division_result_hi

    Output:

        division_result_lo
        division_result_hi

*/
division:
    
    pha  // save A on stack
    txa  // transfer X to A
    pha  // push A (X) on stack
    tya  // transfer Y to A
    pha  // push A (Y) to stack
    

    continue_substraction:
        sec                    // sec carry to substraction to 0
        lda division_number_lo  // Restamos partes LOW del numero
        sbc division_divisor_lo
        sta division_number_lo  // actualizamos number_1_lo con el resultado de la resta

        lda division_number_hi  // Restamos partes HI del numero  
        sbc division_divisor_hi  // actualizamos divisor_hi con el resultado de la resta
        sta division_number_hi

        // incrementamos el cociente, de 1 en 1 , en 16 bits
        clc
        lda division_result_lo
        adc #1            // sumamos 1 a low
        sta division_result_lo
        lda division_result_hi     // sumamos hi con carry si es necesario
        adc #0
        sta division_result_hi

        lda division_number_hi  // comparamos si la parte alta de number_1_hi todavía es mayor a la al de divisor_hi
        cmp division_divisor_hi  // comparamos.
        bne continue_substraction  // ¿ no son iguales ? Quiere decir que aun es mayor , así que vuelve a restar

        lda division_number_lo     // cargamos en A la parte LOW de number_1 .
        cmp division_divisor_lo     // comparamos 
        bcs continue_substraction // ¿ number_1_lo es mayor a divisor_lo ( 10 ) ? pues sigue restando
    
    pla // pull A from stack (Y)
    tay // transfer A to Y
    pla // pull A from stack (X)
    tax // transfer A to X
    pla // pull A from Stack
    

rts //return


/*
    Multiplication 16 bits

    Input:

        multiplication_number_1_lo
        multiplication_number_1_hi

        multiplication_multiplicator_lo
        multiplication_multiplicator_hi

    Output:

        multiplication_result_lo
        multiplication_result_hi
*/
multiplication:

    pha  // save A on stack
    txa  // transfer X to A
    pha  // push A (X) on stack
    tya  // transfer Y to A
    pha  // push A (Y) to stack


    continue_multiplication:
        clc                   // clear carry
        lda multiplication_result_lo
        adc multiplication_number_lo
        sta multiplication_result_lo

        lda multiplication_result_hi
        adc multiplication_number_hi
        sta multiplication_result_hi

        //restar multiplicador
        sec
        lda multiplication_multiplicator_lo
        sbc #$1
        sta multiplication_multiplicator_lo

        lda multiplication_multiplicator_hi
        sbc #$0
        sta multiplication_multiplicator_hi

        lda multiplication_multiplicator_lo
        // ¿ Los 2 bytes son ya 0 ? 
        ora multiplication_multiplicator_hi // comprueba ambos bytes si son 0 , con ORA
        // si no , pues sigue multiplicando
        bne continue_multiplication

    pla // pull A from stack (Y)
    tay // transfer A to Y
    pla // pull A from stack (X)
    tax // transfer A to X
    pla // pull A from Stack
    
    
    rts //return 




    

