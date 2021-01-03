typedef struct{
    int id;
    char nomProprio[100] ;
    double solde; 
}compte;

void init_compte(compte* unCompte, char * name);

compte* create_compte();

void free_compte(compte* unCompte);

void ajouter_argent(compte* unCompte, double montant);

void retirer_argent(compte* unCompte, double montant);