//Takes a file of integers and sorts them from low to high as well as
//giving some typical stats

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void){

    int i,j,tmp,n,sum=0,err,input;
    float avg;
    int *list;
    char ch,ufname[100],ftype[4],tag[12]="-sorted.txt",temp[100];
    char* sfname=(char*)NULL;                   //sorted file name
    FILE* ufile=(FILE*)NULL;                    //user's file
    FILE* sfile=(FILE*)NULL;                    //sorted file

    while (1)
    {
        printf("Please choose an input method\n");
        printf("Keyboard (K or k), File (F or f), Quit (Q or q)\n");
        ch = getchar();
        if (ch=='k'||ch=='K'||ch=='f'||ch=='F')
            break;
        else if (ch=='Q'||ch=='q')
            return EXIT_SUCCESS;
        else
            printf("Invalid input detected\n");
        // end if (ch=='k'||...)
    }

    //User chose keyboard input
    if (ch=='k'||ch=='K'){
        //Get User input file name
        while(1) {
            printf("Please specify a file name (ie 'list.txt'): ");
            scanf("%99s",&ufname);
            //Check that the user include filename with extension
            if (strlen(ufname)>4)
            {
                strcpy(temp,ufname);
                for (i=strlen(ufname)-4;i<=strlen(ufname);i++)
                    ftype[i-strlen(ufname)+4]=ufname[i];

				//Check that the file is of type .txt
                if (!(strcmp(ftype,".txt")))
                    break;
                else
                    printf("Please use .txt for a file type\n");
            }
            else {
                printf("File name must be at least 5 characters");
                printf(" long including the file type extension\n");
            }
        } //end while(1)

        printf("file name is:\t%s\n",ufname);

		//Dynamically allocate space for sfname
		sfname = (char *)malloc((strlen(ufname)+7)*sizeof(char));

		//Put file name in sfname
        strcpy(sfname,temp);
        printf("file name is:\t%s\n",sfname);

        //Try to open user input file
        if(!(sfile=fopen(sfname,"w"))) {
            printf("Could not open %s to write\n",sfname);
            return EXIT_SUCCESS;
        }

        //Get number of elements from user
        printf("How many items are in the list? ");
        scanf("%d",&n);

        //Initialize dynamic array
        if((list=(int *) malloc(n*sizeof(int)))==NULL) {
            printf("Memory allocation error\n");
            return EXIT_SUCCESS;
        }

        //Get each element from the user
        for (i=0;i<n;i++) {
            printf("What is item %d? ",i+1);
            scanf("%d",&list[i]);
        }
    } //end keyboard input section

	//User chose file
	if (ch=='f'||ch=='F'){
		//Get user's input file name
		while(1) {
            printf("Please specify a file name (ie 'list.txt'): ");
            scanf("%99s",&ufname);
            //Check that the user include filename with extension
            if (strlen(ufname)>4) {
                strcpy(temp,ufname);
                for (i=strlen(ufname)-4;i<=strlen(ufname);i++)
                    ftype[i-strlen(ufname)+4]=ufname[i];

				//Check that the file is of type .txt
                if (!(strcmp(ftype,".txt")))
                    break;
                else
                    printf("Please use .txt for a file type\n");
            }
            else {
                printf("File name must be at least 5 characters");
                printf(" long including the file type extension\n");
            }
        } //end while(1)
		strcpy(ufname,temp);
		
		//Try to open ufile
		if(!(ufile=fopen(ufname,"r"))) {
			printf("Could not open %s to read\n",ufname);
			return EXIT_SUCCESS;
		}
		
		//Dynamically allocate space for sfname
		sfname = (char *)malloc((strlen(ufname)+7)*sizeof(char));
		
		//add sorted tag to name
		for (i=0;i<strlen(ufname)-4;i++)
			sfname[i]=ufname[i];
		strcat(sfname,tag);
		printf("tagged filename:\t%s\n",sfname);
		
		//Try to open sorted file to write
		if(!(sfile=fopen(sfname,"w"))) {
			printf("Could not open %s to write\n",sfname);
			return EXIT_SUCCESS;
		}
		
		//Get number of elements from the file
		fscanf(ufile,"%d",&n);
		printf("# of elements:\t%d\n",n);
		
		//Initialize the list array
		if((list=(int *) malloc(n*sizeof(int)))==NULL){
			printf("Memory allocation error\n");
			return EXIT_SUCCESS;
		}
		
		//Get each element from the file
		for (i=0;i<n;i++) {
			err=fscanf(ufile,"%d",&list[i]);
			if (err==EOF||list[i]==(int)"avg:\n")
            {
                //End of File found before gathering the specified 
                //number of grades
                printf("%d elements not found.\n",n);
                printf("Continuing with the %d ",i);
                printf("elements that were found.\n");
                n=i;
                break;
            } //end if(fscanf(...)==EOF)
		}
	} //end file input
	
	//Perform Computations on data
	
	//Sort list
    for (i=0;i<n;i++)
        for(j=i;j<n;j++)
            if(list[i]>list[j]) {
                tmp=list[i];
                list[i]=list[j];
                list[j]=tmp;
            }

    // Calculate stats
    //Average
    for (i=0;i<n;i++)
        sum+=list[i];
    avg=(float)sum/(float)n;
    printf("The average is:\t%.2f\n",avg);

    //Output data to file
    fprintf(sfile,"%d\n",n);
    for (i=0;i<n;i++)
        fprintf(sfile,"%d\n",list[i]);
    fprintf(sfile,"sum:\n");
    fprintf(sfile,"%d\n",sum);
    fprintf(sfile,"avg:\n");
    fprintf(sfile,"%f\n",avg);
	
	//Close open files
	if (ufile != NULL)
		fclose(ufile);
	if (sfile != NULL)
		fclose(sfile);
		
    return EXIT_SUCCESS;
}
