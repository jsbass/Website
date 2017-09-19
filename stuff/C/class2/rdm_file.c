//generates a random "grades.txt" file for proj2

#include <stdlib.h>
#include <stdio.h>

int main(void){

    int i,n,max_n,u,l;
    char fname[20];
    FILE *gf;
    time_t sec;

    time(&sec);
    srandom((unsigned int) sec);
    srandom(random());
    
    //Describe the program to the user
    printf("\n");
    printf("This program creates a file with a list of randomly generated numbers\n");
    printf("The first line contains the number of random elements in the file\n");
    printf("Each line afterwards contains a single element\n");

    //Ask for file output name
    printf("Output File name: ");
    scanf("%19s",fname);

    //Ask for the max number of elements
    printf("Max # of elements: ");
    scanf("%d",&max_n);
    n = random()%max_n+1;

    //Ask for lower and upper limits on random numbers
    printf("Upper limit of elements: ");
    scanf("%d",&u);
    printf("Lower limit of elements: ");
    scanf("%d",&l);

    if(!(gf = fopen(fname,"w")))
    {
        printf("Could not open \"%s\" to be written\n",fname);
        return EXIT_FAILURE;
    }

    //Output number of elements to first line
    fprintf(gf,"%d\n",n);

    //Output each element
    for (i=1;i<=n;i++)
    {
        fprintf(gf,"%d\n",random()%(u-l)+l);
    }

    printf("File created that contains %d elements\n",n);

    if(gf!=NULL)
        fclose(gf);

    return EXIT_SUCCESS;

}
