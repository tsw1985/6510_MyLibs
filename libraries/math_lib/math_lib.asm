MATH_LIB:
{
/*
Division 32 bits:
Input: 

Number to divide from 0 to 3 ( low byte to hight)
    
    div_num1_0
    div_num1_1
    div_num1_2
    div_num1_3

Number divided by

    div_num2_0
    div_num2_1
    div_num2_2
    div_num2_3

Output:

    div_res_0
    div_res_1
    div_res_2
    div_res_3

    */
division_32:
    
    push_regs_to_stack()


    loop:
    // compare if div_num1 >= div_num2
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
    pull_regs_from_stack()
rts
//--------------------------------------------------------------------------------
/*
Multiplication 32 bits

Input:

    Num1 to multiplication.
    Low byte to hight byte

    mul_num1_0 
    mul_num1_1
    mul_num1_2
    mul_num1_3
    
    ( times )

    Num2 
    mul_num2_0
    mul_num2_1
    mul_num2_2
    mul_num2_3

Output:

    mul_res_0
    mul_res_1
    mul_res_2
    mul_res_3
*/
multiplication_32:

    push_regs_to_stack()

    continue_multiplication_32:
        clc                   // clear carry
        lda mul_res_0
        adc mul_num1_0
        sta mul_res_0

        lda mul_res_1
        adc mul_num1_1
        sta mul_res_1

        lda mul_res_2
        adc mul_num1_2
        sta mul_res_2

        lda mul_res_3
        adc mul_num1_3
        sta mul_res_3


        //restar multiplicador
        sec
        lda mul_num2_0
        sbc #1
        sta mul_num2_0

        lda mul_num2_1
        sbc #0
        sta mul_num2_1

        lda mul_num2_2
        sbc #0
        sta mul_num2_2

        lda mul_num2_3
        sbc #0
        sta mul_num2_3
        //end restar multiplicador

        lda mul_num2_0
        
        // ¿ Los 2 bytes son ya 0 ? 
        ora mul_num2_1 // comprueba ambos bytes si son 0 , con ORA
        ora mul_num2_2 // comprueba ambos bytes si son 0 , con ORA
        ora mul_num2_3 // comprueba ambos bytes si son 0 , con ORA
        
        // si no , pues sigue multiplicando
        bne continue_multiplication_32

pull_regs_from_stack()
    
rts //return         

//---------------------------------------------------
/*
Sum 32 bits.
Bytes from low to hight

Input:

    Num 1

    sum_num1_0: .byte 0
    sum_num1_1: .byte 0
    sum_num1_2: .byte 0
    sum_num1_3: .byte 0

    Num 2
    sum_num2_0: .byte 0
    sum_num2_1: .byte 0
    sum_num2_2: .byte 0
    sum_num2_3: .byte 0

    Result

    sum_res_0
    sum_res_1
    sum_res_2
    sum_res_3
*/
sum_32:

    push_regs_to_stack()
    
    clc
    lda sum_num1_0
    adc sum_num2_0
    sta sum_res_0

    lda sum_num1_1
    adc sum_num2_1
    sta sum_res_1

    lda sum_num1_2
    adc sum_num2_2
    sta sum_res_2

    lda sum_num1_3
    adc sum_num2_3
    sta sum_res_3

    pull_regs_from_stack()

rts
//------------------------------------------------------    

/*
Sub 32 bits.
Bytes from low to hight

Input:

    Num 1

    sub_num1_0: .byte 0
    sub_num1_1: .byte 0
    sub_num1_2: .byte 0
    sub_num1_3: .byte 0

    Num 2
    sub_num2_0: .byte 0
    sub_num2_1: .byte 0
    sub_num2_2: .byte 0
    sub_num2_3: .byte 0

    Result
    sub_res_0
    sub_res_1
    sub_res_2
    sub_res_3
*/
sub_32:

    push_regs_to_stack()
    
    sec
    lda sub_num1_0
    sbc sub_num2_0
    sta sub_res_0

    lda sub_num1_1
    sbc sub_num2_1
    sta sub_res_1

    lda sub_num1_2
    sbc sub_num2_2
    sta sub_res_2

    lda sub_num1_3
    sbc sub_num2_3
    sta sub_res_3

    lda sub_res_0
    lda sub_res_1
    lda sub_res_2
    lda sub_res_3

    pull_regs_from_stack()

rts

}