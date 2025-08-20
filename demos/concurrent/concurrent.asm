insert_text(1,1,concurrence_str,YELLOW)
jsr init_irq_timer

task_infinity_loop:
jmp task_infinity_loop


/* 

    This is the default configuration timer.
    The values for "Count from" means, the CPU count from that number to 0
    to do a "sleep".
 */
init_irq_timer:

    push_regs_to_stack()
    sei  // stop interruptions

    /* SAVE ORIGINAL VECTOR */
    lda $0314
    sta OLD_IRQ_LOW
    lda $0315  
    sta OLD_IRQ_HIGH

    // Set up address of our code to execute
    lda #<execute_tasks    // Cambié el nombre de la función
    sta $0314                
    lda #>execute_tasks
    sta $0315                

    // Count from 12500 to 0 = 0.5 sec
    lda #<1000             
    sta $DC04               
    lda #>1000             
    sta $DC05               
    
    // Enable IRQ Timer
    lda #%10000001          
    sta $DC0D               
    
    // Start IRQ Timer loop mode
    lda #%00000001          
    sta $DC0E               

    cli  // restore interruptions

    pull_regs_from_stack()
    rts


/*
    This code is triggered when the timeout 1000 to 0 is 0.

    But here we do a trick. This function is executed to fast, enter a lot times
    by sencod. So we have a counter TASK_IRQ_COUNTER and we execute our code
    if the counter is 60 ( more or less it is 1 second ).

    The next is reset this counter to 0 to start again to count


 */
execute_tasks:

    push_regs_to_stack()

    /* We need read the CIA1 ICR to clean the flags */
    lda $DC0D 

    /* The system is busy? */
    lda TASK_BUSY
    cmp #0
    beq process_tasks 
    jmp irq_timer_exit   

    process_tasks:
    
        
        /* Each 0.5 second this code is executed */
        inc TASK_IRQ_COUNTER
        lda TASK_IRQ_COUNTER
        cmp #60              // 2 * 0.5 = 1 second   
        beq enter_to_select_a_task
        jmp irq_timer_exit

        enter_to_select_a_task:
        jsr PRINT_LIB.clean_screen


        /* Reset the IRQ counter to enter to execute when the counter value is 
        again in 60. Is more or less 1 sec */
        lda #0
        sta TASK_IRQ_COUNTER


        lda TASK_COUNTER
        /* task 1 */
        cmp #0
            beq go_to_task_0
            bne check_task_1
            go_to_task_0:
                inc TASK_COUNTER
                insert_text(2,1,concurrence_task_change_color_str,YELLOW)
                inc TASK_BUSY
                inc $d020 // change border color
                dec TASK_BUSY
                jmp irq_timer_exit

        /* task 2 */
        check_task_1:
        cmp #1
            beq go_to_task_1
            bne check_task_2
            go_to_task_1:
                inc TASK_COUNTER
                inc TASK_BUSY
                insert_text(3,1,concurrence_task_2_str,YELLOW)
                dec TASK_BUSY
                jmp irq_timer_exit

        /* task 3 */            
        check_task_2:
        cmp #2
            beq go_to_task_2
            jmp reset_counters
            go_to_task_2:
                inc TASK_COUNTER
                inc TASK_BUSY
                insert_text(4,1,concurrence_task_3_str,YELLOW)
                dec TASK_BUSY
                //jmp irq_timer_exit

    /* If is not task 1, 2 or 3 ...means we need reset the task counter*/
    /* Reset task counter*/
    reset_counters:
    lda #0
    sta TASK_COUNTER
    
    
irq_timer_exit:
    pull_regs_from_stack()
    jmp $EA31