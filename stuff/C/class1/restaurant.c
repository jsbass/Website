/*
******************************************************************************
*** Project #4:  Fast Food Restaurant                                      ***
*** Program:     restaurant                                                ***
*** Author:      Jacob Bass (bass@ou.edu)                                  ***
*** Class:       CS 1313 010 computer Programming, Fall 2013               ***
*** Lab:         Sec 015 Fridays 3:30pm                                    ***
*** Description: Asks the user to input an order for entree, side dish,    *** 
***              and drink as well as sizes for each. Then it calculates   ***
***              the bill outputs a reciept                                ***
******************************************************************************
*/

#include <stdio.h>
#include <stdlib.h>

int main()
{ /*main*/
    /*
     ***************************
     *** Declaration Section ***
     ***************************
     *
     ******************************
     * Named Constants Subsection *
     ******************************
     *
     * small_burger_price:  price for small burger
     * large_burger_price:  price for large burger
     * small_chicken_price: price for small chicken
     * large_chicken_price: price for large chicken
     * small_fries_price:   price for small fries
     * large_fries_price:   price for large fries
     * small_rice_price:    price for small rice
     * large_rice_price:    price for large rice
     * small_soda_price:    price for small soda
     * large_soda_price:    price for large soda
     * small_coffee_price:  price for small coffee
     * large_coffee_price:  price for large coffee
     * no_item_price:       price for no selection
     * burger_item_code:    item code for a burger
     * chicken_item_code:   item code for chicken
     * fries_item_code:     item code for fries
     * rice_item_code:      item code for rice
     * soda_item_code:      item code for soda
     * coffee_item_code:    item code for coffee
     * no_item_code:        item code for no selection
     * small_size_code:     size code for small items
     * large_size code:     size code for large items
     * tax_rate:            percentage of bill added for tax
     *
     */

    const float small_burger_price = 3.25;
    const float large_burger_price = 4.50;
    const float small_chicken_price = 4.50;
    const float large_chicken_price = 5.25;
    const float small_fries_price = 1.75;
    const float large_fries_price = 2.50;
    const float small_rice_price = 1.25;
    const float large_rice_price = 2.00;
    const float small_soda_price = 1.50;
    const float large_soda_price = 1.75;
    const float small_coffee_price = 2.75;
    const float large_coffee_price = 3.25;
    const float no_item_price = 0;
    const int burger_item_code = 1;
    const int chicken_item_code = 2;
    const int fries_item_code = 1;
    const int rice_item_code = 2;
    const int soda_item_code = 1;
    const int coffee_item_code = 2;
    const int no_item_code = 0;
    const int small_size_code = 1;
    const int large_size_code = 2;
    const float tax_rate = .0825;
    const int program_success_code = 0;
    const int program_failure_code = 1;

    /*
     *****************************
     * Local Variable Subsection *
     *****************************
     *
     * entree_item_code: user input entree item selection code
     * entree_size_code: user input entree size selection code
     * side_item_code:   user input side item selection code
     * side_size_code:   user input side size selection code
     * drink_item_code:  user input drink item selection code
     * drink_size_code:  user input drink size selection code
     * subtotal:         subtotalled bill before tax
     * total:            totalled bill after tax
     *
     */

    int entree_item_code, entree_size_code;
    int side_item_code, side_size_code;
    int drink_item_code, drink_size_code;
    float subtotal = 0;
    float tax = 0;
    float total = 0;

    /*
     *************************
     *** Execution Section ***
     *************************
     *
     ***********************
     * Greeting Subsection *
     ***********************
     *
     * Greets the user by telling them what the program does
     *
     */

    printf("\n");
    printf("Welcome to Jake's Eatery!\n");

    /*
     * Print a menu for prices
     */

    printf("\n");
    printf("======================================\n");
    printf(" Item    | Small Price | Large Price | \n");
    printf(" Burger  |    $%5.2f   |    $%5.2f   |\n", small_burger_price,
        large_burger_price);
    printf("-------------------------------------\n");
    printf(" Chicken |    $%5.2f   |    $%5.2f   |\n", small_chicken_price, 
        large_chicken_price);
    printf("=====================================\n");
    printf(" Fries   |    $%5.2f   |    $%5.2f   |\n", small_fries_price,
        large_fries_price);
    printf("-------------------------------------\n");
    printf(" Rice    |    $%5.2f   |    $%5.2f   |\n", small_rice_price,
        large_rice_price);
    printf("=====================================\n");
    printf(" Soda    |    $%5.2f   |    $%5.2f   |\n", small_soda_price,
        large_soda_price);
    printf("-------------------------------------\n");
    printf(" Coffee  |    $%5.2f   |    $%5.2f   |\n", small_coffee_price,
        large_coffee_price);
    printf("=====================================\n");
    
    /*
     ********************
     * Input Subsection *
     ********************
     *
     * Prompt the user for an entree input
     *
     */

    printf("Please select an entree\n");
    printf("Enter:\n");
    printf("%d for no entree\n", no_item_code);
    printf("%d for a burger\n", burger_item_code);
    printf("%d for chicken\n", chicken_item_code);

    /*
     * Input the user's entree selection
     */

    scanf("%d", &entree_item_code);

    /*
     * IdiotProof: Make sure the user input a valid entree code
     */
    
    if ((entree_item_code != burger_item_code) &&
       (entree_item_code != chicken_item_code) &&
       (entree_item_code != no_item_code)) {
        /*
         * The entree_item_code wasn't a valid choice
         */
        printf("%d is not a valid choice\n", entree_item_code);
        exit(program_failure_code);
    } /* if ((entree_item_code != burger_item_code) && (entre...) */

    /*
     * Check to see if the user selected an entree
     */

    if (entree_item_code != no_item_code) {
        /*
         * user selected an entree
         */

        /*
         * Prompt for an entree size
         */

        printf("Please select a size\n");
        printf("Enter\n");
        printf("%d for a small\n", small_size_code);
        printf("%d for a large\n", large_size_code);

        /*
         * Input user's entree size selection
         */

        scanf("%d", &entree_size_code);

        /*
         * IdiotProofing: Make sure the user input a valid size code
         */

        if ((entree_size_code != 1) &&
           (entree_size_code != 2)) {
            /*
             * entree_size_code wasn't a valid size code
             */

            printf("%d is not a valid size\n", entree_size_code);
            exit(program_failure_code);
        } /* if ((entree_size_code != 1) && (entree... */
    } /* if (entree_item_code != no_item_code) */

    /*
     * Prompts the user for a side input
     */

    printf("Please Select a Side\n");
    printf("Enter:\n");
    printf("%d for no side\n", no_item_code);
    printf("%d for fries\n", fries_item_code);
    printf("%d for rice\n", rice_item_code);

    /*
     * Input user's side selection
     */

    scanf("%d", &side_item_code);

    /*
     * Idiotproof: Make sure the user input a valid side code
     */

    if ((side_item_code != no_item_code) &&
        (side_item_code != fries_item_code) &&
        (side_item_code != rice_item_code)) {
        /*
         * side_item_code wasn't a valid side item code
         */

        printf("%d is not a valid side choice\n", side_item_code);
        exit(program_failure_code);
    } /* if ((side_item_code != no_item_code) && (side_item... */

    /*
     * Check to see if the user selected a side
     */

    if (side_item_code != no_item_code) {

        /*
         * User selected a side
         */

        /*
         * Prompt the user for a side size
         */

        printf("Please select a side size\n");
        printf("Enter\n");
        printf("%d for a small\n", small_size_code);
        printf("%d for a large\n", large_size_code);

        /*
         * Input a user's side size selection
         */

        scanf("%d", &side_size_code);

        /*
         * Idiotproofing: Make sure the user input a valid size code
         */

        if ((side_size_code != large_size_code) &&
            (side_size_code != small_size_code)) {

            /*
             * side_size_code wasn't a valid size code
             */

            printf("%d is not a valid size\n", side_size_code);
            exit(program_failure_code);
        } /* if ((side_size_code != large_size... */
    } /* if ((side_item_code != no_item_code) */

    /*
     * Prompts the user for a drink input
     */

    printf("Please select a drink\n");
    printf("Enter\n");
    printf("%d for no drink\n", no_item_code);
    printf("%d for soda\n", soda_item_code);
    printf("%d for coffee\n", coffee_item_code);

    /*
     * Inputs the user's drink selection
     */

    scanf("%d", &drink_item_code);

    /*
     * Idiotproofing: Make sure the user input a valid drink code
     */

    if ((drink_item_code != no_item_code) &&
        (drink_item_code != soda_item_code) &&
        (drink_item_code != coffee_item_code)) {

        /*
         *  drink_item_code is not a valid item code
         */

        printf("%d is not a valid choice\n", drink_item_code);
        exit(program_failure_code);
    } /* if ((drink_item_code != no_item_code) && (drink_it... */

    /*
     * Check to see if the user selected a drnk
     */

    if (drink_item_code != no_item_code) {

        /*
         * User selected a drink
         */

        /*
         * Prompt the user for a drink size
         */

        printf("Please select a drink size\n");
        printf("Enter:\n");
        printf("%d for a small\n", small_size_code);
        printf("%d for a large\n", large_size_code);

        /*
         * Inputs the users drink size selection
         */

        scanf("%d", &drink_size_code);

        /*
         * Idiotproofing: Make sure the user input a valid size code
         */

        if ((drink_size_code != small_size_code) &&
            (drink_size_code != large_size_code)) {

            /*
             * drink_size_code wasn't a valid size code
             */

            printf("%d is not a valid size\n", drink_size_code);
            exit(program_failure_code);
        } /* if ((drink_size_code != small_size_code) && ... */
    } /* if (drink_item_code != no_item_code) */

    if ((entree_item_code == no_item_code) &&
        (side_item_code == no_item_code) &&
        (drink_item_code == no_item_code)) {

        /*
         * User selected no items
         */

        printf("Thank you. Please Come Again.\n");
        exit(program_success_code);

    } /* if((entree_item_code == no_item_code) && (side_item... */

    /*
     ***************************
     * Calculation Subsection  *
     ***************************
     *
     * Add the entree price to subtotal
     *
     */

    if (entree_item_code == burger_item_code) {

        /*
         * user selected a burger entree
         */

        if (entree_size_code == small_size_code) {

            /*
             * User selected a small burger entree
             */

            subtotal = subtotal + small_burger_price;

        } /* if(entree_size_code == small_burger_code) */
        else {

            /*
             * User selected a large burger entree
             */

            subtotal += large_burger_price;
        } /* if(entree_size_code == small_burger_code)... else  */
    } /* if(entree_item_code == burger__item_code) */
    else {
        if (entree_item_code == chicken_item_code) {

            /*
             * User selected a chicken entree
             */

            if (entree_size_code == small_size_code) {

                /*
                 * User selected a small chicken
                 */

                subtotal += small_chicken_price;

            } /* if(entree_size_code == small_size_code) */
            else {

                /*
                 * User selected a large chicken
                 */

                subtotal += large_chicken_price;

            } /* if(entree_size_code == small_size_code)...else */
        } /* if (entree_item_code == chicken_item_code) */
    } /* if (entree_item_code == burger_item_code)...else */

    /*
     * Add the side price to the subtotal
     */

    if (side_item_code == fries_item_code) {

        /*
         * user selected a fries side
         */

        if (side_size_code == small_size_code) {

            /*
             * User selected a small fries side
             */

            subtotal += small_fries_price;
        } /* if(side_size_code == small_fries_code) */
        else {

            /*
             * User selected a large fries side
             */

            subtotal += large_fries_price;
        } /* if(side_size_code == small_fries_code)... else  */
    } /* if(side_item_code == fries__item_code) */
    else {
        if (side_item_code == rice_item_code) {

            /*
             * User selected a rice side
             */

            if (side_size_code == small_size_code) {

                /*
                 * User selected a small rice
                 */

                subtotal += small_rice_price;

            } /* if(side_size_code == small_size_code) */
            else {

                /*
                 * User selected a large rice
                 */

                subtotal += large_rice_price;

            } /* if(side_size_code == small_size_code)...else */ 
        } /* if (side_item_code == rice_item_code) */
    } /* if (side_item_code == fries_item_code)...else */

    /*
     * Add the drink price to the subtotal
     */

    if (drink_item_code == soda_item_code) {

        /*
         * user selected a soda drink
         */

        if (drink_size_code == small_size_code) {

            /*
             * User selected a small soda drink
             */

            subtotal += small_soda_price;
        } /* if(drink_size_code == small_soda_code) */
        else {

            /*
             * User selected a large soda drink
             */

            subtotal += large_soda_price;
        } /* if(drink_size_code == small_soda_code)... else  */
    } /* if(drink_item_code == soda__item_code) */
    else {
        if (drink_item_code == coffee_item_code) {

            /*
             * User selected a coffee drink
             */

            if (drink_size_code == small_size_code) {

                /*
                 * User selected a small coffee
                 */

                subtotal += small_coffee_price;

            } /* if(drink_size_code == small_size_code) */
            else {

                /*
                 * User selected a large coffee
                 */

                subtotal += large_coffee_price;

            } /* if(drink_size_code == small_size_code)...else */ 
        } /* if (drink_item_code == coffee_item_code) */
    } /* if (drink_item_code == soda_item_code)...else */

    tax = subtotal * tax_rate;
    total = subtotal + tax;

    /*
     *********************
     * Output Subsection *
     *********************
     *
     * Prints the bill's header
     *
     */

    printf("=================================================\n");
    printf("|             Jacob's Eatery Bill               |\n");
    printf("=================================================\n");
    printf("\n");
    
    /*
     * Prints the entree item and price
     */

    if (entree_item_code == burger_item_code) {

        /*
         * user selected a burger entree
         */

        if (entree_size_code == small_size_code) {

            /*
             * User selected a small burger entree
             */

            printf("   Small Burger:       $ %5.2f\n",
                small_burger_price);

        } /* if(entree_size_code == small_burger_code) */
        else {

            /*
             * User selected a large burger entree
             */

            printf("   Large Burger:       $ %5.2f\n",
                large_burger_price);

        } /* if(entree_size_code == small_burger_code)... else  */
    } /* if(entree_item_code == burger__item_code) */
    else {
        if (entree_item_code == chicken_item_code) {

            /*
             * User selected a chicken entree
             */

            if (entree_size_code == small_size_code) {

                /*
                 * User selected a small chicken
                 */

                printf("   Small Chicken:      $ %5.2f\n",
                    small_chicken_price);

            } /* if(entree_size_code == small_size_code) */
            else {

                /*
                 * User selected a large chicken
                 */

                printf("   Large Chicken:      $ %5.2f\n",
                    large_chicken_price);

            } /* if(entree_size_code == small_size_code)...else */
        } /* if (entree_item_code == chicken_item_code) */
        else {

            /*
             * User selected no entree
             */

            printf("   No Entree:          $ %5.2f\n", no_item_price);

        } /* if (entree_item_code == chicken_item_code)...else */
    } /* if (entree_item_code == burger_item_code)...else */

    /*
     * Prints the side item and price
     */

    if (side_item_code == fries_item_code) {

        /*
         * user selected a fries side
         */

        if (side_size_code == small_size_code) {

            /*
             * User selected a small fries side
             */

            printf("   Small fries:        $ %5.2f\n",
                small_fries_price);

        } /* if(side_size_code == small_fries_code) */
        else {

            /*
             * User selected a large fries side
             */

            printf("   Large fries:        $ %5.2f\n",
                large_fries_price);

        } /* if(side_size_code == small_fries_code)... else  */
    } /* if(side_item_code == fries__item_code) */
    else {
        if (side_item_code == rice_item_code) {

            /*
             * User selected a rice side
             */

            if (side_size_code == small_size_code) {

                /*
                 * User selected a small rice
                 */

                printf("   Small rice:         $ %5.2f\n",
                    small_rice_price);

            } /* if(side_size_code == small_size_code) */
            else {

                /*
                 * User selected a large rice
                 */

                printf("   Large rice:         $ %5.2f\n",
                    large_rice_price);

            } /* if(side_size_code == small_size_code)...else */
        } /* if (side_item_code == rice_item_code) */
        else {

            /*
             * User selected no side
             */

            printf("   No side:            $ %5.2f\n", no_item_price);

        } /* if (side_item_code == rice_item_code)...else */
    } /* if (side_item_code == fries_item_code)...else */

    /*
     * Prints the drink item and price
     */

    if (drink_item_code == soda_item_code) {

        /*
         * user selected a soda drink
         */

        if (drink_size_code == small_size_code) {

            /*
             * User selected a small soda drink
             */

            printf("   Small soda:         $ %5.2f\n",
                small_soda_price);

        } /* if(drink_size_code == small_soda_code) */
        else {

            /*
             * User selected a large soda drink
             */

            printf("   Large soda:         $ %5.2f\n",
                large_soda_price);

        } /* if(drink_size_code == small_soda_code)... else  */
    } /* if(drink_item_code == soda__item_code) */
    else {
        if (drink_item_code == coffee_item_code) {

            /*
             * User selected a coffee drink
             */

            if (drink_size_code == small_size_code) {

                /*
                 * User selected a small coffee
                 */

                printf("   Small coffee:       $ %5.2f\n",
                    small_coffee_price);

            } /* if(drink_size_code == small_size_code) */
            else {

                /*
                 * User selected a large coffee
                 */

                printf("   Large coffee:       $ %5.2f\n",
                    large_coffee_price);

            } /* if(drink_size_code == small_size_code)...else */
        } /* if (drink_item_code == coffee_item_code) */
        else {

            /*
             * User selected no drink
             */

            printf("   No drink:           $ %5.2f\n", no_item_price);

        } /* if (drink_item_code == coffee_item_code)...else */
    } /* if (drink_item_code == soda_item_code)...else */

    /*
     * Prints the subtotal, tax, and total
     */

    printf("   ---------------------------\n");
    printf("   Subtotal:           $ %5.2f\n", subtotal);
    printf("   Tax:                $ %5.2f\n", tax);
    printf("   ---------------------------\n");
    printf("   Total:              $ %5.2f\n", total);
    
    /*
     * Prints Goodbye
     */

    printf("\n");
    printf("Thank You for Visiting Jacob's Eatery! Come Again\n");
    printf("=================================================\n");
    printf("\n");

    exit(program_success_code);
} /*main*/
