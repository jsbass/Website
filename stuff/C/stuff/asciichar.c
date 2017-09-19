// Displays the table of Ascii Characters

#include <stdlib.h>
#include <stdio.h>

int main(void){

    int ch=0,count=0;
    FILE *af;

    if(!(af=fopen("asciichar.txt","w")))
    {
        printf("Couldn't open to write \"asciichat.txt\"\n");
        printf("No chart file will be created");
    }
    for (ch=0;ch<256;ch++)
    {
        if (ch>31&&ch<127||ch>162&&ch<256)
        {
            printf("'%c\'=%d\t",ch,ch);
            fprintf(af,"'%c'=%d\t",ch,ch);
            count++;
        }
    if (count==7)
        {
            printf("\n");
            fprintf(af,"\n");
            count=0;
        }
    }
    if(count!=0)
    {
        printf("\n");
        fprintf(af,"\n");
    }
    fclose(af);
    return EXIT_SUCCESS;
}
