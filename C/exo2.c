#include "exo2.h"
#include <stdlib.h>
#include <string.h>

compte* create_compte(){
    return malloc(sizeof(compte));
}

void init_compte(compte* unCompte, char * name){
    static int id_auto = 0;
    unCompte->solde=0;
    strcpy(unCompte->nomProprio,name);
    unCompte->id=id_auto;
    id_auto++;
}

void free_compte(compte* unCompte){
    free(unCompte);
}

void ajouter_argent(compte* unCompte, double montant){
    if(montant>0){unCompte->solde=unCompte->solde+montant;}
}

void retirer_argent(compte* unCompte, double montant){
    if(montant>0){unCompte->solde=unCompte->solde-montant;}
}