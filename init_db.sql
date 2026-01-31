-- Script de création de la base de données (à exécuter dans psql ou pgAdmin)
-- CREATE DATABASE todo_db;

-- Connexion à la base de données
-- \c todo_db;

-- Création de la table des statuts
CREATE TABLE IF NOT EXISTS statuts (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE
);

-- Insertion des statuts par défaut
INSERT INTO statuts (nom) VALUES ('A FAIRE'), ('EN COURS'), ('TERMINE'), ('ANNULE') ON CONFLICT (nom) DO NOTHING;

-- Création de la table des tâches
CREATE TABLE IF NOT EXISTS taches (
    id SERIAL PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    description TEXT,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_echeance TIMESTAMP,
    statut_id INTEGER REFERENCES statuts(id),
    priorite VARCHAR(20) DEFAULT 'MOYENNE' -- BASSE, MOYENNE, HAUTE
);
