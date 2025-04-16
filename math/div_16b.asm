/*
    DIVISION 16 bits
*/

BasicUpstart2(main)

//number 1250 / 10 = $04E2 / $0A
//==============================
result:       .byte 0

// 1250
number_1_lo:  .byte $E2 
number_1_hi:  .byte $04
// end 1250

// 125 -- $007D
// number_1_lo:  .byte $7D
// number_1_hi:  .byte $00
// end 125

// 12 -- $007D
//number_1_lo:  .byte $0C
//number_1_hi:  .byte $00
// end 125


// 1 -- $0001
//number_1_lo:  .byte $01
//number_1_hi:  .byte $00
// end 1


// Divided by 10
number_2_lo:  .byte $0A //10
number_2_hi:  .byte $00

main:

    sec                    // sec carry to substraction to 0

    continue_substraction:

        lda number_1_lo  // Restamos partes LOW del numero
        sbc number_2_lo
        sta number_1_lo  // actualizamos number_1_lo con el resultado de la resta

        lda number_1_hi  // Restamos partes HI del numero  
        sbc number_2_hi  // actualizamos number_2_hi con el resultado de la resta
        sta number_1_hi

        inc result       // como ya se ha hecho una resta, incrementamos 1 a result ( es el cociente )

        lda number_1_hi  // comparamos si la parte alta de number_1_hi todavía es mayor a la al de number_2_hi
        cmp number_2_hi  // comparamos.
        bne continue_substraction  // ¿ no son iguales ? Quiere decir que aun es mayor , así que vuelve a restar

        lda number_1_lo     // cargamos en A la parte LOW de number_1 .
        cmp number_2_lo     // comparamos 
        bcs continue_substraction // ¿ number_1_lo es mayor a number_2_lo ( 10 ) ? pues sigue restando

    lda result // ver el cociente
    //lda number_1_lo // ver el modulo 
    .break
    rts //return basic


