//Prime experiments

#include <stdio.h>
#include <stdlib.h>

int main(){

    int* list;
    int diff[99];
    int i,n;
    FILE* pfile;
    FILE* dfile;

    //Get how many primes to find
    while (1)
    {
        printf("How many primes to process?: ");
        scanf("%d",&n);
        if (n<1)
        {
            printf("n should be a positive integer\n");
            printf("%d\n",n);
            continue;
        }
        break;
    }

    list = (int*)malloc(n*sizeof(int));

    //try to open file of primes
    if(!(pfile=fopen("primes.txt","r")))
    {
        printf("Could not open \"primes.txt\" to write.\n");
        return (-1);
    }

    //try to open diffs.txt
    if(!(dfile=fopen("diffs.txt","w")))
    {
        printf("Could not open \"diffs.txt\" to write.\n");
        return (-1);
    }


    printf("Primes:\n");
    for (i=0;i<n;i++)
    {
        fscanf(pfile,"%d",&list[i]);
        printf("%d\n",list[i]);
    }

    printf("Differences:\n");
    for (i=1;i<n;i++)
    {
        diff[i-1]=list[i]-list[i-1];
        fprintf(dfile,"%d\n",diff[i-1]);
        printf("%d\n",diff[i-1]);
    }

    return EXIT_SUCCESS;

}
