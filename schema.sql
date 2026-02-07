-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it


    -- Table des joueurs --

        CREATE TABLE joueurs (
            id_joueur INTEGER PRIMARY KEY,
            prenom TEXT NOT NULL,
            nom TEXT NOT NULL,
            date_naissance DATE NOT NULL,
            poste TEXT NOT NULL,
            date_arrivee DATE NOT NULL);


    -- Table des matchs --

        CREATE TABLE matches (
            id_match INTEGER PRIMARY KEY,
            match_date DATE NOT NULL,
            adversaire TEXT NOT NULL,
            localisation TEXT NOT NULL,
            buts_pour INTEGER DEFAULT 0 CHECK (buts_pour >= 0),
            buts_contre INTEGER DEFAULT 0 CHECK (buts_contre >= 0));

    -- Entraînements collectifs --

        CREATE TABLE entrainements_collectifs (
            id_entrainement INTEGER PRIMARY KEY,
            date_entrainement DATE NOT NULL,
            type TEXT,
            duree_minutes INTEGER CHECK (duree_minutes > 0),
            type_entrainement_co TEXT,
            difficulte_co INTEGER CHECK (difficulte_co BETWEEN 1 AND 10));

    -- Entraînements individuels --

        CREATE TABLE entrainements_individuels (
            id_entrainement INTEGER PRIMARY KEY,
            date_entrainement DATE NOT NULL,
            objectif TEXT,
            duree_minutes INTEGER CHECK (duree_minutes > 0),
            type_entrainement_ind TEXT,
            difficulte_ind INTEGER CHECK (difficulte_ind BETWEEN 1 AND 10));

    -- Participation des joueurs aux matchs --

        CREATE TABLE participation_match (
            id INTEGER PRIMARY KEY,
            id_joueur INTEGER NOT NULL,
            id_match INTEGER NOT NULL,
            minutes_jouees INTEGER CHECK (minutes_jouees BETWEEN 0 AND 120),
            buts INTEGER DEFAULT 0 CHECK (buts >= 0),
            passes_decisives INTEGER DEFAULT 0 CHECK (passes_decisives >= 0),

            FOREIGN KEY (id_joueur) REFERENCES joueurs(id_joueur),
            FOREIGN KEY (id_match) REFERENCES matches(id_match),
            UNIQUE (id_joueur, id_match));

    -- Présence aux entraînements collectifs --

        CREATE TABLE presence_collectif (
            id INTEGER PRIMARY KEY,
            id_joueur INTEGER NOT NULL,
            id_entrainement INTEGER NOT NULL,
            present INTEGER NOT NULL CHECK (present IN (0, 1)),
            FOREIGN KEY (id_joueur) REFERENCES joueurs(id_joueur),
            FOREIGN KEY (id_entrainement) REFERENCES entrainements_collectifs(id_entrainement),
            UNIQUE (id_joueur, id_entrainement)
    
    -- Présence aux entraînements individuels --

        CREATE TABLE presence_individuel (
            id INTEGER PRIMARY KEY,
            id_joueur INTEGER NOT NULL,
            id_entrainement INTEGER NOT NULL,
            FOREIGN KEY (id_joueur) REFERENCES joueurs(id_joueur),
            FOREIGN KEY (id_entrainement) REFERENCES entrainements_individuels(id_entrainement),
            UNIQUE (id_joueur, id_entrainement));

    -- Blessures --

        CREATE TABLE blessures (
            id_blessure INTEGER PRIMARY KEY,
            id_joueur INTEGER NOT NULL,
            date_blessure DATE NOT NULL,
            type_blessure TEXT NOT NULL,
            gravite INTEGER CHECK (gravite BETWEEN 1 AND 10),
            date_debut DATE NOT NULL,
            date_fin DATE,
            id_match INTEGER,
            id_entrainement_collectif INTEGER,
            id_entrainement_individuel INTEGER,
            FOREIGN KEY (id_joueur) REFERENCES joueurs(id_joueur),
            FOREIGN KEY (id_match) REFERENCES matches(id_match),
            FOREIGN KEY (id_entrainement_collectif) REFERENCES entrainements_collectifs(id_entrainement),
            FOREIGN KEY (id_entrainement_individuel) REFERENCES entrainements_individuels(id_entrainement));

    -- Index pour optimiser les requêtes --

        CREATE INDEX idx_participation_joueur ON participation_match(id_joueur);
        CREATE INDEX idx_blessures_joueur ON blessures(id_joueur);
        CREATE INDEX idx_blessures_dates ON blessures(date_debut, date_fin);
        CREATE INDEX idx_matches_date ON matches(match_date);


