# Design Document

Par Vincent LE BRETON

Présentation vidéo: <URL HERE>

## Périmètre (Scope)

Dans cette section, vous devez répondre aux questions suivantes :

* Quel est l’objectif de votre base de données ?

Cette base de données est conçue comme un outil d’aide à la décision, permettant au staff et aux responsables sportifs d’appuyer leurs choix sur des données factuelles, sans se substituer à une expertise médicale ou technique.

L’objectif de cette base de données est de gérer (turn-over, statistiques, etc.) et d’analyser le suivi sportif et médical d’une équipe de football amateur, afin de mieux comprendre la charge de jeu, la disponibilité des joueurs et la survenue des blessures.

* Quelles personnes, quels lieux, quels objets, etc. sont inclus dans le périmètre de votre base de données ?

- les joueurs de l’équipe de football
- les matchs disputés par l’équipe
- les entraînements collectifs et individuels
- les performances individuelles des joueurs lors des matchs (buts, passes décisives, minutes jouées)
- les présences aux entraînements
- les blessures des joueurs, avec leur gravité, leur durée et le contexte dans lequel elles ont eu lieu (match, entraînement ou hors activité)

* Quelles personnes, quels lieux, quels objets, etc. sont en dehors du périmètre de votre base de données ?

- le staff (entraîneurs, médecins, kinésithérapeutes, ostéopathes, etc.)
- les données environnementales comme la météo ou la saisonnalité
- les antécédents médicaux détaillés des joueurs
- les statistiques d’effort avancées (VMA, sprints à haute intensité, données GPS, etc.)

## Exigences fonctionnelles

Dans cette section, vous devez répondre aux questions suivantes :

* Que doit pouvoir faire un utilisateur avec votre base de données ?

- enregistrer et consulter les joueurs de l’équipe
- créer et consulter des matchs et leurs résultats
- renseigner les statistiques individuelles des joueurs par match
- gérer les entraînements collectifs et individuels
- suivre la présence ou l’absence des joueurs aux entraînements
- enregistrer des blessures et suivre leur évolution dans le temps
- identifier les joueurs indisponibles à une date donnée
- effectuer des analyses simples sur le temps de jeu, la fréquence des blessures ou la charge sportive

* Qu’est-ce qui dépasse le périmètre de ce qu’un utilisateur doit pouvoir faire avec votre base de données ?

- d’effectuer des diagnostics médicaux ou des recommandations de soins
- de prédire les riques de blessures à l’aide de modèles statistiques avancés 
- d’automatiser l’import de données externes
- de remplacer un outil professionnel de suivi médical ou sportif

## Représentation

### Entités

Dans cette section, vous devez répondre aux questions suivantes :

* Quelles entités allez-vous choisir de représenter dans votre base de données ?

- Joueurs, pour stocker les informations générales sur les joueurs
- Matchs, pour représenter les rencontres disputées
- Entraînements collectifs, pour les séances de groupe
- Entraînements individuels, pour les séances personnalisées
- Participation aux matchs, pour enregistrer les performances individuelles
- Présence aux entraînements, pour suivre l’assiduité
- Blessures, pour assurer le suivi des problèmes physiques des joueurs

* Quels attributs ces entités auront-elles ?

- des identifiants numériques pour assurer l’unicité des enregistrements
- des dates pour représenter les événements dans le temps
- des valeurs numériques pour les statistiques et la gravité des blessures 
- des contraintes (clés étrangères, valeurs bornées, unicité) afin de       garantir la cohérence des données

* Pourquoi avez-vous choisi ces types de données ?

les dates permettent un suivi temporel précis, les entiers facilitent les calculs statistiques, et les chaînes de caractères sont adaptées aux informations descriptives.

* Pourquoi avez-vous choisi ces contraintes ?

Pour eviter les incohérences et fiabilisier les données stockées afin d'avoir une analyse précise

### Relations

Dans cette section, vous devez inclure votre diagramme entité–relation et décrire les relations entre les entités de votre base de données.



    JOUEURS ||--o{ PARTICIPATION_MATCH : participe
    MATCHES ||--o{ PARTICIPATION_MATCH : concerne

    JOUEURS ||--o{ PRESENCE_COLLECTIF : assiste
    ENTRAINEMENTS_COLLECTIFS ||--o{ PRESENCE_COLLECTIF : planifie

    JOUEURS ||--o{ PRESENCE_INDIVIDUEL : suit
    ENTRAINEMENTS_INDIVIDUELS ||--o{ PRESENCE_INDIVIDUEL : concerne

    JOUEURS ||--o{ BLESSURES : subit
    MATCHES ||--o{ BLESSURES : provoque
    ENTRAINEMENTS_COLLECTIFS ||--o{ BLESSURES : provoque
    ENTRAINEMENTS_INDIVIDUELS ||--o{ BLESSURES : provoque


## Optimisations

Dans cette section, vous devez répondre aux questions suivantes :

* Quelles optimisations (par exemple, index, vues) avez-vous créées Pourquoi ?

Des index peuvent être créés sur les clés étrangères et sur les colonnes de dates afin d’améliorer les performances lors des recherches fréquentes (recherche de blessures par joueur, indisponibilités à une date donnée, historique des matchs).
Des vues peuvent également être utilisées pour simplifier l’analyse des statistiques des joueurs ou le suivi des blessures en cours.

## Limitations

Dans cette section, vous devez répondre aux questions suivantes :

* Quelles sont les limites de votre conception ?

Cette base de données reste volontairement simple et ne couvre pas tous les aspects du suivi médical ou sportif.
Elle ne permet pas de décrire précisément les soins, les traitements ou l’évolution clinique détaillée des blessures.

* Que votre base de données pourrait-elle mal représenter ou ne pas représenter correctement ?

- les causes exactes et multiples des blessures ;
- la fatigue physique ou mentale des joueurs ;
- les interactions complexes entre charge d’entraînement et risque de blessure.

cela reste restreint pour un club amateur car les joueurs ont des contraintes professionnel propre à chacun
