#include <stdio.h>
#include <stdlib.h>

/* 1 */
typedef struct{
    unsigned char memoire[4096];
    unsigned char registres[16];
    unsigned short pseudo_registre;
    unsigned short program_counter; 
}chip8;

/* 2 */
chip8* create_chip8(){
    return malloc(sizeof(chip8));
}

/* 3 */
void init_chip(chip8* machine){
    for(int i=0;i < 4096;i++)
    {
        (*machine).memoire[i] = 0;
    }
    for(int i=0;i < 16;i++)
    {
        (*machine).registres[i] = 0;
    }
    (*machine).pseudo_registre = 0;
    (*machine).program_counter = 0;
}

int readfile(chip8* vm){
    FILE *fp = fopen("test_opcode.ch8","r");
    int nbLues = fread(vm->memoire,1,4096,fp);
    fclose(fp);
    return nbLues;
} 

short concatenate(unsigned char a, unsigned char b){
    unsigned short concat = a;
    concat = concat << 8; 
    concat = concat | b;
    return concat;
}

short retourInstrcution(chip8* vm){
    unsigned char a = vm->memoire[vm->program_counter];
    unsigned char b = vm->memoire[vm->program_counter+1];
    unsigned short concat = concatenate(a,b);
    vm->program_counter = vm->program_counter + 2;
    return concat;
}



int main(){
    chip8* VM = create_chip8();
    int nbLues = 0;
    init_chip(VM);
    printf("%d\n",VM->program_counter);
    nbLues = readfile(VM);
    printf("%d\n",nbLues);
    unsigned short ab = retourInstrcution(VM);
    printf("%x\n",ab);
    free(VM);
    return 0;
}


/* on recupere une instruction et passe à une autre*/