-- lab8_indexes.sql

-- Avant optimisation
EXPLAIN
SELECT e.nom, COUNT(i.id)
FROM ETUDIANT e
JOIN INSCRIPTION i ON i.etudiant_id = e.id
GROUP BY e.id;

-- Création d'un index
ALTER TABLE INSCRIPTION
ADD INDEX idx_etudiant_id(etudiant_id);

-- Après optimisation
EXPLAIN
SELECT e.nom, COUNT(i.id)
FROM ETUDIANT e
JOIN INSCRIPTION i ON i.etudiant_id = e.id
GROUP BY e.id;

-- Suppression de l'index si inutile
ALTER TABLE INSCRIPTION
DROP INDEX idx_etudiant_id;
