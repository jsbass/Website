/*
 ******************************************************************************
 *** Project 3.5: Combinations                                              ***
 *** Program: choose                                                        ***
 *** Author: Jacob Bass (seabass992@gmail.com                                        ***
 *** Class: CS 1313 010 Computer Programming, Fall 2013                     ***
 *** Lab: Sec 015 Fridays 3:30pm                                            ***
 *** Description: Takes the user input, total number of items available and ***
 ***              the size of the subgroup to be created and determines the ***
 ***              total number of subgroups that can be created from the    ***
 ***              total number of items                                     ***
 ******************************************************************************
 */

#include <stdio.h>
#include <stdlib.h>

int main()
{ /* main*/
    /*
     ***************************
     *** Declaration Section ***
     ***************************
     *
     *****************************
     * Named Constant Subsection *
     *****************************
     *
     * program_success_code: boolean value for whether the program 
     *                       executed successfully
     * program_failure_code: boolean value for whether the program
     *                       executed successfully
     * count_start_value:    The value for the start of both the numerator
     *                       and denominator loops
     *
     */

    const int program_success_code = 1;
    const int program_failure_code = 0;
    const int count_start_value = 1;

    /*
     * Local Variable Subsection *
     *****************************
     *
     * number_of_items:           the total number of items
     * subgroup_size:             the size of the subgroups
     * number_of_combos:          the number of possible combinations
     * num_of_combos_numerator:   the numerator of the number of combinations
     * num_of_combos_denominator: the denonminator of the number of combinations
     * numerator_counter:         the counter used for the numerator loop
     * denominator_counter:       the counter used for the denominator loop
     *
     */

    int number_of_items = 0, subgroup_size = 0;
    int number_of_combos = 0;
    int num_of_combos_numerator = 0, num_of_combos_denominator = 1;
    int numerator_counter, denominator_counter;

    /*
     *************************
     *** Execution Section ***
     *************************
     *
     ***********************
     * Greeting Subsection *
     ***********************
     *
     * Greets the user and tells them the program's function
     *
     */

    printf("I will tell you the number of combinations available given:\n");
    printf("    Total number of items \n");
    printf("    Size of the subgroups \n");

    /*
     ********************
     * Input Subsection *
     ********************
     *
     * Prompt the user to input the number of items (Larger than 0)
     *
     */

    printf("Please enter the total number of items (must be larger than 0):\n");

    /*
     * Input the user's total number of items
     */

    scanf("%d", &number_of_items);

    /*
     * Idiotproofing: make sure the user input a value greater than zero
     */

    if (number_of_items <= 0) {

        /*
         * number_of_items wasn't greater than zero
         * Print Error Message and exit program with failure code
         */

        printf("ERROR: The total number of items needs to be greater than 0\n");
        exit(program_failure_code);

    } /* if (numner_of_items <= 0) */

    /*
     * Prompt user for the size of the subgroups
     */

    printf("Please input the size of the subgroups (Must be between 0 and"); 
    printf(" the total size)\n");

    /*
     * Input the user's size of the subgroups
     */

    scanf("%d", &subgroup_size);

    /*
     * Idiotproofing: Make the user input a subgroup_size that was 
     * larger than zero and less than the total number of items
     */

    if (subgroup_size <= 0) {

        /*
         * subgroup_size wasn't greater than zero
         */

        printf("ERROR: the subgroup size needs to be greater than 0\n");
        exit(program_failure_code);

    } /* if (subgroup_size <= 0) */

    if (subgroup_size > number_of_items) {

         /*
          * subgrou_size was greater than the total number of items
          */

         printf("ERROR: the subgroup size needs to be less than the total");
         printf(" number of items\n");
         exit(program_failure_code);

    } /* if (subgroup_size > number_of_items) */

    /*
     ***************************
     * Calculations Subsection *
     ***************************
     *
     * Calculate the numerator of the number of combinations
     *
     */

    num_of_combos_numerator = number_of_items;

    for (numerator_counter = count_start_value;
        numerator_counter <= (subgroup_size-1); numerator_counter++) {

       num_of_combos_numerator *= (number_of_items - numerator_counter);

    } /* for (numerator_counter) */

    /*
     * Calculate the denominator of the number of combinations
     */

    for (denominator_counter = count_start_value;
        denominator_counter <= subgroup_size; denominator_counter++) {

        num_of_combos_denominator *= denominator_counter;

    } /* for (denominator_counter) */

    /*
     * Calculate the number of combinations using the numerator and 
     * denominator values
     */

    number_of_combos = num_of_combos_numerator/num_of_combos_denominator;

    /*
     *********************
     * Output Subsection *
     *********************
     *
     * Output the total number of items, size of the subgroup, and 
     * number of cominations in a sentence
     *
     */

    printf("Given:\n");
    printf("    The total number of item:  %d\n", number_of_items);
    printf("    The subgroup size:         %d\n", subgroup_size);
    printf("The number of combinations possible is %d\n", number_of_combos);

    exit(program_success_code);
} /* main */
