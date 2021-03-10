/*
***********************************************************************
*** Project #3:  Two Little Calculations                            ***
*** Author:      Jacob Bass (seabass992@gmail.com                            ***
*** Class:       CS 1313 010 Computer Programming, Fall 2013        ***
*** Lab:         Sec 015 Fridays 3:30pm                             ***
*** Description: Converts a user inputted English units for Energy  ***
***              and fuel burn rate to metric units                 ***
***********************************************************************
*/

#include <stdio.h>

int main ()
{ /* main */
    /*
     ***************************
     *** Declaration Section ***
     ***************************
     *
     *****************************
     * Named Constant Subsection *
     *****************************
     *
     * liters_per_gallon:         The conversion factor for Liters to gallons 
     * calories_per_kilecalorie:  The conversion factor for calories to 
     *                            kilecalories
     * joules_per_calorie         The conversion factor for joules to calories
     * ergs_per_joule:            The conversion factor for ergs to joules
     * seconds_per_minute:        The conversion factor for seconds to minutes
     * minutes_per_hour:          The conversion factor for minutes to hours
     */

    const float liters_per_gallon = 3.785411784;
    const int calories_per_kilocalorie = 1000;
    const float joules_per_calorie = 4.19;
    const int ergs_per_joule = 10e+7;
    const int seconds_per_minute = 60;
    const int minutes_per_hour = 60;

    /*
     *****************************
     * Local Variable Subsection *
     *****************************
     *
     * energy_in_US:                The user's input energy in 
     *                              kilocalories (Calories) 
     * fuel_burn_rate_in_US:        The user's input fuel burn 
     *                              rate in gallons per hour
     * 
     * energy_in_Metric:            The calculated energy in ergs
     * fuel_burn_rate_in_ Metric:   The calculated fuel burn 
     *                              rate in liters per second
     *
     */

     float energy_in_US;
     float energy_in_Metric;
     float fuel_burn_rate_in_US;
     float fuel_burn_rate_in_Metric;

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
     *
     */

    printf("If you tell me the Energy and Fuel Burn Rate in US units,\n");
    printf("I will tell you them in Metric units.\n");

    /*
     ********************
     * Input Subsection *
     ********************
     *
     * Prompts the user for Energy in US units
     *
     */

    printf("What is the Energy in Calories (kilocalories)?\n");

    /*
     * Inputs user's energy in US units
     */

    scanf("%f", &energy_in_US);

    /*
     * Prompts the user for Fuel Burn Rate in US units
     */

    printf("What is the Fuel Burn Rate in gallons per hour?\n");

    /*
     * Inputs the user's fuel burn rate in US units
     */

    scanf("%f", &fuel_burn_rate_in_US);

    /*
     **************************
     * Calculation Subsection *
     **************************
     *
     * Convert kilocalories to ergs
     */

    energy_in_Metric = 
    (energy_in_US*calories_per_kilocalorie*joules_per_calorie*ergs_per_joule);

    /*
     * Convert gallons per hour to liters per second
     */

    fuel_burn_rate_in_Metric = 
    fuel_burn_rate_in_US*liters_per_gallon*seconds_per_minute*minutes_per_hour;

    /*
     *********************
     * Output Subsection *
     *********************
     *
     * Outputs the converted energy in metric units
     */

    printf("%f kilocalories (Calories) is equal to %f ergs\n", 
           energy_in_US, energy_in_Metric);

    /*
     * Outputs the converted fuel burn rate in metric units
     */

    printf("%f gallons per hour is equal to %f joules per second\n",
           fuel_burn_rate_in_US, fuel_burn_rate_in_Metric);

} /* main */
