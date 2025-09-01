/*
    SAVE REGISTERS IN STACK
*/
.macro push_regs_to_stack(){

    pha  // save A on stack
    txa  // transfer X to A
    pha  // push A (X) on stack
    tya  // transfer Y to A
    pha  // push A (Y) to stack

}

/*
    RESTORE REGISTERS VALUES FROM STACK
*/
.macro pull_regs_from_stack(){

    pla // pull A from stack (Y)
    tay // transfer A to Y
    pla // pull A from stack (X)
    tax // transfer A to X
    pla // pull A from Stack

}

/*
    Wait a key from user
*/
.macro wait_until_press_any_key(){

    wait_key:
    jsr $ffe4
    cmp #0
    beq wait_key

}