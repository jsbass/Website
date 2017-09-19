//Test text inputs

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int check_name(char name[]);

int main(){

    int i;
    char string[20];
    char str[20];

    printf("Do input");
    scanf("%39s",string);
    if(check_name(string)==-1)
    {
         printf("EOF found for some reason\n");
         return EXIT_FAILURE;
    }
    else if(check_name(string)==-2)
    {
        printf("non alphabetic character found in %s\n",string);
        return EXIT_SUCCESS;
    }

    for(i=0;i<100;i++){
        printf("i=%d, c=%c\n",i,string[0]-i);
    }

    printf("only alphabetic characters found in %s\n",string);

    return EXIT_SUCCESS;

}

int check_name(char name[]) {

	//Error check for end of file before expect number of inputs
	if (name==EOF)
	{
		//End of File found before gathering the specified
		//number of complete student data
		return -1;
	}
	//Make sure that there are only alphabetic characters in the 
        //name
	while(*name)
	{
		if((*name<97||*name>122)&&(*name<65||*name>90))
		{
			//non-alphabetic character found
			return -2;
		}
		name++;
	}
	
	return EXIT_SUCCESS;
	
}
