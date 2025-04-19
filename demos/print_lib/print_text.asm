   //print text 1
    jsr PRINT_LIB.clean_location_screen
    locate_text(0,0,RED)
    print_text(stars_line)

    //print text 2
    jsr PRINT_LIB.clean_location_screen
    locate_text(2,5,PINK)
    print_text(message)

    //print text 3
    jsr PRINT_LIB.clean_location_screen
    locate_text(3,0,BLACK)
    print_text(stars_line)


    //print text 4
    jsr PRINT_LIB.clean_location_screen
    locate_text(5,0,WHITE)
    print_text(bye)