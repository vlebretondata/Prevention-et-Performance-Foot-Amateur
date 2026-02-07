-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- == ajouter des données à la marge == --  

    -- ajouter un nouveau joueur --
        INSERT INTO joueurs (id_joueur, prenom, nom, date_naissance, poste, date_arrivee)
        VALUES (1, 'Jean', 'Neymar', '1990-05-15', 'Attaquant', '2000-07-01');   

    -- ajouter un nouveau match --
        INSERT INTO matches (id_match, match_date, adversaire, localisation, buts_pour, buts_contre)
        VALUES (1, '2024-09-10', 'Rival FC', 'Domicile', 3, 1);

    -- ajouter un entraînement collectif --
        INSERT INTO entrainements_collectifs (id_entrainement, date_entrainement, type, duree_minutes, type_entrainement_co, difficulte_co) 
        VALUES (1, '2026-01-31', 'Collectif', 90, 'Tactique', 7);

    -- ajouter un entraînement individuel --
        INSERT INTO entrainements_individuels (id_entrainement, date_entrainement, objectif, duree_minutes, type_entrainement_ind, difficulte_ind) 
        VALUES (1, '2026-02-01', 'Améliorer la vitesse', 60, 'Cardio', 8);
        
    -- enregistrer la participation d'un joueur à un match --
        INSERT INTO participation_match (id, id_joueur, id_match, minutes_jouees, buts, passes_decisives)
        VALUES (1, 1, 1, 90, 2, 1);

    -- enregistrer la présence d'un joueur à un entraînement collectif --
        INSERT INTO presence_collectif (id, id_joueur, id_entrainement, present)
        VALUES (1, 1, 1, TRUE);
        
    -- enregistrer la présence d'un joueur à un entraînement individuel --
        INSERT INTO presence_individuel (id, id_joueur, id_entrainement, present)
        VALUES (1, 1, 1, TRUE);


-- == supprimer des données == --

    -- supprimer un joueur --
        DELETE FROM joueurs WHERE id_joueur = 1;

    -- supprimer un match --
        DELETE FROM matches WHERE id_match = 1;

    -- supprimer un entraînement collectif --
        DELETE FROM entrainements_collectifs WHERE id_entrainement = 1;

    -- supprimer un entraînement individuel --
        DELETE FROM entrainements_individuels WHERE id_entrainement = 1;

    -- supprimer la participation d'un joueur à un match --
        DELETE FROM participation_match WHERE id_joueur = 1 AND id_match = 1;

    -- supprimer la présence d'un joueur à un entraînement collectif --
        DELETE FROM presence_collectif WHERE id_joueur = 1 AND id_entrainement = 1;

    -- supprimer la présence d'un joueur à un entraînement individuel --
        DELETE FROM presence_individuel WHERE id_joueur = 1 AND id_entrainement = 1;



-- == ajouter des données en masse par import csv à l'aide de SQlite == --
    -- importer feuille de match --
        .mode csv
        .import feuille_de_match.csv participation_match
    -- importer feuille présence entraînement collectif --
        .mode csv
        .import presence_collectif.csv presence_collectif
    -- importer feuille présence entraînement individuel --
        .mode csv
        .import presence_individuel.csv presence_individuel
    -- import effectif joueurs pour nouvelle saison --
        .mode csv
        .import effectif_joueurs.csv joueurs

-- == mettre à jour des données == --

    -- mettre à jour les statistiques d'un joueur pour un match spécifique --
        UPDATE participation_match
        SET minutes_jouees = 90, buts = 2, passes_decisives = 1
        WHERE id_joueur = 1 AND id_match = 1;

    -- mettre à jour la présence d'un joueur à un entraînement collectif --
        UPDATE presence_collectif
        SET present = TRUE
        WHERE id_joueur = 1 AND id_entrainement = 1;

    -- mettre à jour la présence d'un joueur à un entraînement individuel --
        UPDATE presence_individuel
        SET present = TRUE
        WHERE id_joueur = 1 AND id_entrainement = 1;

    -- mettre à jour les détails d'un match --
        UPDATE matches
        SET buts_pour = 3, buts_contre = 1
        WHERE id_match = 1;

    -- mettre à jour les informations d'un joueur --
        UPDATE joueurs
        SET poste = 'Milieu de terrain'
        WHERE id_joueur = 1;

    -- mettre à jour les détails d'un entraînement collectif --
        UPDATE entrainements_collectifs
        SET type_entrainement_co = 'Physique', difficulte_co = 8
        WHERE id_entrainement = 1;

    -- mettre à jour les détails d'un entraînement individuel --
        UPDATE entrainements_individuels
        SET type_entrainement_ind = 'Renforcement musculaire', difficulte_ind = 9
        WHERE id_entrainement = 1;

    -- mettre à jour une blessure d'un joueur --
        UPDATE blessures
        SET gravite = 7, date_fin = '2026-02-10'
        WHERE id_blessure = 1;
                    

    


-- == requêtes de sélection == --

    -- récupérer la liste des joueurs --
        SELECT * FROM joueurs;

    -- récupérer la liste des matchs --
        SELECT * FROM matches;

    -- récupérer les détails d'un match spécifique --
        SELECT * FROM matches WHERE id_match = 1;

    -- récupérer les statistiques d'un joueur spécifique --
        SELECT * FROM joueurs WHERE id_joueur = 1;

    -- récupérer la liste des joueurs ayant participé à un match spécifique --
        SELECT j.prenom, j.nom, pm.minutes_jouees, pm.buts, pm.passes_decisives
        FROM joueurs j  
        JOIN participation_match pm ON j.id_joueur = pm.id_joueur
        WHERE pm.id_match = 1;

    -- récupérer la liste des joueurs présents à un entraînement collectif spécifique --
        SELECT j.prenom, j.nom, pc.present
        FROM joueurs j  
        JOIN presence_collectif pc ON j.id_joueur = pc.id_joueur
        WHERE pc.id_entrainement = 1;

    -- récupérer la liste des joueurs présents à un entraînement individuel spécifique --
        SELECT j.prenom, j.nom, pi.present
        FROM joueurs j  
        JOIN presence_individuel pi ON j.id_joueur = pi.id_joueur
        WHERE pi.id_entrainement = 1;

    -- récupérer les statistiques globales d'un joueur (total des buts et passes décisives) --
        SELECT j.prenom, j.nom,
               SUM(pm.buts) AS total_buts,
               SUM(pm.passes_decisives) AS total_passes_decisives 
        FROM joueurs j
        JOIN participation_match pm ON j.id_joueur = pm.id_joueur
        WHERE j.id_joueur = 1
        GROUP BY j.id_joueur;

    -- récupérer les matchs où l'équipe a gagné --
        SELECT * FROM matches
        WHERE buts_pour > buts_contre;

    -- récupérer les matchs où l'équipe a perdu --
        SELECT * FROM matches
        WHERE buts_pour < buts_contre;

    -- récupérer les matchs nuls --
        SELECT * FROM matches
        WHERE buts_pour = buts_contre;
    


--== requêtes par 'view' == --
    -- Vue des statistiques cumulées par joueur --
        CREATE VIEW vue_stats_joueurs AS
            SELECT j.id_joueur,j.prenom,j.nom,
                COUNT(pm.id_match) AS matchs_joues,
                SUM(pm.minutes_jouees) AS minutes_totales,
                SUM(pm.buts) AS total_buts,
                SUM(pm.passes_decisives) AS total_passes_decisives
            FROM joueurs j
            LEFT JOIN participation_match pm 
            ON j.id_joueur = pm.id_joueur
            GROUP BY j.id_joueur;

    -- Vue de l'historique des blessures par joueur --
        CREATE VIEW vue_blessures_joueurs AS
            SELECT j.id_joueur,j.prenom,j.nom,b.type_blessure,b.gravite,b.date_debut,b.date_fin,
                CASE
                    WHEN b.id_match IS NOT NULL THEN 'Match'
                    WHEN b.id_entrainement_collectif IS NOT NULL THEN 'Entraînement collectif'
                    WHEN b.id_entrainement_individuel IS NOT NULL THEN 'Entraînement individuel'
                    ELSE 'Inconnu'
            END AS contexte_blessure
            FROM blessures b
            JOIN joueurs j ON j.id_joueur = b.id_joueur;
