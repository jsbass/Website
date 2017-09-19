//This function will take an array of structure items and sort them based on
//the "last" field. This field must exist and must have the students last
//name in it in order for the function to sort correctly. When complete,
//the structure will be in alphabetical order based on the last name only.
//B. Carlson,  19 June, 2014,  CS1313

/*Sample of what the structure should look like.
struct student
{
  char last[20];
  char first[20];
  int grade;
  char letter;
};
*/

//This is the function declaration you should put above main().
int Alph_order(struct student[], int);

//-----------------------------------------------------------------------------
//Put the array of student entries in alphabetical order.
int Alph_order(struct student students[], int num)
{
  int i, j;
  struct student temp;

  if(num<1 || students==NULL)
  {
    printf("\n\tError sorting!\n");
    return -1;
  }

  for(i=0; i<num-1; i++)
    for(j=i+1; j<num; j++)
      if((strcmp(students[i].last, students[j].last))>0)
      {
        temp=students[i];
        students[i]=students[j];
        students[j]=temp;
      }
  return 0;
}
