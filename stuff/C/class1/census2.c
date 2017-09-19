
/*
***********************************************************************
*** Project #2:	 Census                                             ***
*** Program:     census                                             ***
*** Author:      Jacob Bass (bass@ou.edu                            ***
*** Class:       CS 1313 010 Computer Programming, Fall 2013        ***
*** Lab:         Sec 015 Fridays 3:30pm                             ***
*** Description: Asks the user to input social security number      ***
*** and aver # of movies watched in theaters per month and average  ***
*** help sessions attended per month, then outputs these numbers    ***
***********************************************************************
*/

#include <stdio.h>

int main ()

{ /*main*/
	/*
	***************************
	*** Declaration Section ***
	***************************
	*
	******************************
	* Local Variables Subsection *
	******************************
	*
	* ssn_ area_num: The user's area number
	* ssn_group_num: The user's group number
	* ssn_serial_num: The user's serial number
	* avg_movies: The user's average number of movies per month
	* avg_sessions: The user's average number of help sessions
	* 	attended per month
	*
	*/

	float avg_movies;
	float avg_sessions;
	int   ssn_area_num, ssn_group_num, ssn_serial_num;

	/*
	*************************
	*** Execution Section ***
	*************************
	*
	************************
	* Greetings Subsection *
	************************
	*
	* Describe the program's function to the user
	*/

	printf("This program asks for the subject's: ");
	printf("Social Security Number\n");
	printf("Average number of movies watched per month\n");
	printf("Average number of help sessions attended per month\n");
	printf("And outputs the inputted values\n\n");

	/*
	********************
	* Input Subsection *
	********************
	*
	* Prompt the User for subject's SSN
	*
	* printf("What is the subject's Social Security Number:\n");
	* printf("### ## #### (area number, group number, serial");
	* printf("_number seperated by spaces)?\n");

	/*
	* Input subject's SSN number as an area, group, and serial 
	* number
	*/

        scanf("%d %d %d", &ssn_area_num, &ssn_group_num, &ssn_serial_num);

	/*
	* Prompts for the subject's avg. # of movies watched per month
	*/

	printf("What is the subject's average number of movies ");
	printf("watched per month?\n");

	/*
	* Inputs subject's avg. # of movies watched per month
	*/

	scanf("%f",&avg_movies);

	/*
	* Prompts for the subject's avg. # of help sessions attended per 
	* month
	*/

	printf("What is the subject's average number of help ");
	printf("sessions attended per month?\n");

	/*
	* Inputs the subject's avg. # of help sessions attended per 
	* month
	*/

	scanf("%f",&avg_sessions);

	/*
	*********************
	* Output Subsection *
	*********************
	*
	* Outputs the subject's SSN
	*/

	printf("\nThe subject's SSN is: ");
	printf("%d-%d-",ssn_area_num, ssn_group_num);
	printf("%d.\n\n", ssn_serial_num);

	/*
	* Ouputs the subject's avg. # of movies watched per month
	*/

	printf("The subject watches too many movies with an average");
	printf(" of %f movies watched\nper month.\n\n",avg_movies);

	/*
	* Outputs the subject's avg. # of help sessions attended per 
	* month
	*/

	printf("The subject needs to study more with an average ");
	printf("of %f number of help\nsessions attended",avg_sessions);
	printf(" per month.\n\n");
} /*main*/
