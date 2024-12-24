// c to x86 asm with 
// clang -arch x86_64 -masm=intel -o a.out day24.s
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int hash(char in[static 4]);
long calculate(int in, int gates[5000][4]);

int main (int argc, char * argv[])
{
    char *filename = "./inputs/input-24.txt";
    long result=0;
    int part=1;
    char buf[20];
    int gates[50000][4];
    int x,y,z,type;
    char out[4];
    FILE * fp;

    fp = fopen (filename, "r");

    memset(gates,-1,sizeof(gates));
    while(fgets(buf, 20, fp) != NULL)
    {
        if(buf[0]=='\n')
            break;
        x=hash(strtok(buf,":"));
        y=strtol(strtok(NULL,"\n"),NULL,10);
        gates[x][3]=y;
    }
    while(fgets(buf, 20, fp) != NULL)
    {
        if(buf[0]=='\n')
            break;
        x=hash(strtok(buf," "));
        type =*strtok(NULL," ");
        y=hash(strtok(NULL," "));
        z=hash(strtok(NULL,"\n")+3);
        gates[z][0]=x;
        gates[z][1]=y;
        gates[z][2]=type;
    }
    x=hash("z00");
    for(int i=0;gates[x][0]>-1;i++)
    {
        result+=(calculate(x, gates)<<i);
        snprintf(out,4,"z%02d",i+1);
        x=hash(out);
    }
    printf("%ld\n",result);
    return 0;
}

int hash(char in[static 4])
{
    int x,value=0;
    for(int i=0;in[i];i++)
    {
        value*=36;
        x=in[i]-48;
        if(x>11)
            x-=39;
        value+=x;
    }
    return value;
}

long calculate(int in, int gates[5000][4])
{
    int x,y;
    if(gates[in][3]>-1)
        return gates[in][3];
    x=calculate(gates[in][0],gates);
    y=calculate(gates[in][1],gates);
    switch(gates[in][2])
    {
      case 'A':
        gates[in][3]=x&y;
        return gates[in][3];
      case 'O':
        gates[in][3]=x|y;
        return gates[in][3];
      case 'X':
        gates[in][3]=x^y;
        return gates[in][3];
      default:
        return -1;
    }
}