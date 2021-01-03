#include <stdio.h>

#define CTEST_MAIN
#define CTEST_SEGFAULT
#define CTEST_COLOR_OK

#include "ctest.h"
#include "exo2.h"

CTEST(suite_compte, test_creation_compte) {
    compte* unCompte = create_compte();
    init_compte(unCompte,"test");
    ASSERT_EQUAL(0,unCompte->id);
    ASSERT_EQUAL(0,unCompte->solde);
    ASSERT_STR("test",unCompte->nomProprio);
    free_compte(unCompte);
}
CTEST(suite_compte, test_creation_deuxieme_compte) {
    compte* unAutreCompte = create_compte();
    init_compte(unAutreCompte,"test2");
    ASSERT_EQUAL(1,unAutreCompte->id);
    ASSERT_EQUAL(0,unAutreCompte->solde);
    ASSERT_STR("test2",unAutreCompte->nomProprio);
    free_compte(unAutreCompte);
}
CTEST(suite_compte, test_ajout_argent) {
    compte* unCompte = create_compte();
    init_compte(unCompte,"test");
    ajouter_argent(unCompte,100);
    ASSERT_EQUAL(100,unCompte->solde);
    ajouter_argent(unCompte,-100);
    ASSERT_EQUAL(100,unCompte->solde);
    free_compte(unCompte);
}

CTEST(suite_compte, test_retirer_argent) {
    compte* unCompte = create_compte();
    init_compte(unCompte,"test");
    ajouter_argent(unCompte,200);
    retirer_argent(unCompte,100);
    ASSERT_EQUAL(100,unCompte->solde);
    retirer_argent(unCompte,100);
    ASSERT_EQUAL(0,unCompte->solde);
    free_compte(unCompte);
}

int main(int argc, const char *argv[])
{
    int result = ctest_main(argc, argv);
    return result;
}