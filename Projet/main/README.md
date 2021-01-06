# PROJET C3P

Bonjour à toi jeune Padawan ! Si tu es ici, c'est pour utiliser ma super application créée dans le cadre 
de la matière C3P.

Pour utiiser ce magnifique programme, vous devrez construire un **fichier de configuration** ("conf.txt" à remplir)

### Voilà les règles à suivre :

- Vous devrez utiliser des mots prédéfinis pour construire le fichier.
- Vous devrez mettre un mot par ligne, sauf dans un cas (voir plus bas)
- Il ne devra y avoir aucun espace ou caractère spécial en trop dans une ligne.
- Voici la liste des opérations disponible pour remplir le fichier de configuration :
    - **Upper** -> Permet de mettre en majuscules toute la phrase que vous avez écrite.
    - **Lower** -> Permet de mettre en miniscules toute la phrase que vous avez écrite.
    - **UpperFirst** -> Met la première lettre du premier mot en majuscule.
    - **Capitalize** -> Met la première lettre de chaque mot en majuscule.
    - **Normalize** -> Enlève tous les accents présents dans la phrase.
    - **Reverse** -> Permet d'inverser totalement la phrase écrite.
    - **Split** -> Permet de séparer en 2 la phrase donnée.
    - **Copy** -> Permet de copier la phrase rentrée et de l'avoir en double.
    - **Concat** -> Permet de concaténer 2 phrases, séparées auparavant ou rentrées au début.

- En ce qui concerne la suite d'un **Split ou d'un Copy**, il y a deux possibilités, soit tu peux écrire un seul
mot qui sera affecté au deux mots que tu as après la séparation ou alors tu as la possibilité d'effectuer
deux actions différentes pour les deux mots, en écrivant par exemple "Upper,Lower", il suffira de mettre
une virgule entre les 2 mots que tu souhaites utiliser.
