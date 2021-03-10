/* 
********************************************************************** 
*** Project #3:  Two Little Calculations                           ***
*** Author:      Jacob Bass (seabass992@gmail.com                           ***
*** Class:       CS 1313 010 Computer Programming, Fall 2013       ***
*** Lab:         Sec 015 Fridays 3:30pm                            ***
*** Description: Converts a user inputted English units for Energy ***
***              and fuel burn rate to metric units                *** 
********************************************************************** 
*/

#include <stdio.h>
#include <math.h>

int main()
{ /*main*/
    /*
     ***************************
     *** Declaration Section ***
     ***************************
     *
     *****************************
     * Named Constant Subsection *
     *****************************
     *
     * number_of_values: number of values to have statistics run on
     */

    const int number_of_values = 4;

    /*
     *****************************
     * Local Variable Subsection *
     *****************************
     *
     * arithmetic_mean:       the arithmetic mean of the input values
     * root_mean_square:      the root mean square of the input values
     * harmonic_mean:         the harmonic mean of the input values
     * value1:                User input fist value in the set of data
     * value2:                User input second value in the set of data
     * value3:                User input third value in the set of data
     * value4:                User inpur fourth value in the set of data
     * reciprical_numerator:  Since we can't use number literals in he 
     *                        calculations section this is a variable 
     *                        representative of the number one
     */

    float arithmetic_mean, root_mean_square, harmonic_mean;
    float value1, value2, value3, value4;
    int reciprical_numerator = 1;

    /*
     *************************
     *** Execution Section ***
     *************************
     *
     ***********************
     * Greeting Subsection *
     ***********************
     *
     * Describe what the program does
     */

    printf("If you input four values I will output the:\n");
    printf("  Arithmetic Mean, Root Mean Square and, Harmonic Mean\n");

    /*
     ********************
     * Input Subsection *
     ********************
     *
     * Prompts the user for four number values on which to perform statistics
     */

    printf("What are the four numbers for which you wish to run statistics\n");
    printf("(Please use a space or new line to denote the different numbers\n");

    /*
     * Input the users four numbers
     */

    scanf("%f %f %f %f", &value1, &value2, &value3, &value4);

    /*
     **************************
     * Calculation Subsection *
     **************************
     *
     * Do math!!!!!!!!!!!!!
     */

    arithmetic_mean = (value1 + value2 + value3 + value4)/number_of_values;
    root_mean_square = 
        sqrt((value1*value1+value2*value2+value3*value3+value4*value4)
        /number_of_values);
    harmonic_mean = number_of_values/(reciprical_numerator/value1 + 
        reciprical_numerator/value2 + 
        reciprical_numerator/value3 + 
        reciprical_numerator/value4);
    /*
     *********************
     * Output Subsection *
     *********************
     *
     * Outputs the the four input values
     */

    printf("The four input values are (in case you didn't remember):\n");
    printf("  %f, %f, %f and, %f\n", value1, value2, value3, value4);

    /*
     * Outputs the calculated statistics
     */

    printf("The Arithmetic Mean is:  %f\n", arithmetic_mean);
    printf("The Root Mean Square is: %f\n", root_mean_square);
    printf("The Harmonic Mean is:    %f\n", harmonic_mean);

} /*main*/
