/* input 1 demo */
/* CALL INPUT ROW , COL , LIMIT , COLOR */
input_text(15,0,25,PINK)
/* Show wrote text demo */
insert_text(16,1,user_wrote_str,RED)
insert_text(16,15,KEYS_TO_SCREEN_STR,GREEN)


/* input 2 demo */
/* CALL INPUT ROW , COL , LIMIT , COLOR */
input_text(17,0,39,YELLOW)
/* Show wrote text demo */
insert_text(18,1,user_wrote_str,WHITE)
insert_text(18,12,KEYS_TO_SCREEN_STR,GRAY)

/* comment this. This is a infinity loop to allow see the wrote text */
wait_until_press_any_key()

