LOAD DATA LOCAL INFILE '/home/usuari/sql/raspi_json_movies.csv' 
INTO TABLE pellicules
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES 
(id_movie, titol, any, vots);

LOAD DATA LOCAL INFILE '/home/usuari/sql/raspi_json_movies.csv' 
INTO TABLE gèneres
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES 
(@dummy, @dummy, @dummy, @dummy, genere);

LOAD DATA LOCAL INFILE '/home/usuari/sql/raspi_json_movies.csv' 
INTO TABLE països
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES 
(@dummy, @dummy, @dummy, @dummy, @dummy, pais);

LOAD DATA LOCAL INFILE '/home/usuari/sql/raspi_json_movies.csv' 
INTO TABLE directors
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES 
(@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, director);

LOAD DATA LOCAL INFILE '/home/usuari/sql/raspi_json_movies.csv' 
INTO TABLE actors
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES 
(@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, actor);

LOAD DATA LOCAL INFILE '/home/usuari/sql/raspi_json_movies.csv' 
INTO TABLE estudis
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES 
(@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, estudis);

LOAD DATA LOCAL INFILE '/home/usuari/sql/raspi_json_movies.csv' 
INTO TABLE repartiment
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES 
(@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, rol);

LOAD DATA LOCAL INFILE '~/sql/raspi_json_movies.csv' INTO TABLE universal
FIELDS TERMINATED BY '\t' 
ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES 
(id_movie, titol, any, vots, genere, pais, director, estudis, actor, rol);

INSERT INTO pellicules_directors
SELECT pe.id_movie,d.id_director FROM universal u JOIN pellicules pe ON (u.id_movie = pe.id_movie) JOIN directors d ON (u.director = d.director) ORDER BY pe.id_movie;

UPDATE directors SET director = NULLIF(director, '') WHERE director = '';

UPDATE directors
SET director = REPLACE(REPLACE(REPLACE(director, '"', ''),'[', ''),']', '')
WHERE director LIKE '%"%' OR director LIKE '"%';

INSERT INTO pellicules_gèneres(id_movie, id_genere)
SELECT pe.id_movie,g.id_genere FROM universal u JOIN pellicules pe ON (u.id_movie = pe.id_movie) JOIN gèneres g ON (u.genere = g.genere) ORDER BY pe.id_movie;

UPDATE gèneres SET genere = NULLIF(genere, '') WHERE genere = '';

INSERT INTO pellicules_països
SELECT pe.id_movie, pa.id_pais FROM universal u JOIN pellicules pe ON (u.id_movie = pe.id_movie) JOIN països pa ON (u.pais = pa.pais) ORDER BY pe.id_movie;

UPDATE països SET pais = NULLIF(pais, '') WHERE pais = '';

INSERT INTO pellicules_estudis
SELECT pe.id_movie, es.id_estudi FROM universal u JOIN pellicules pe ON (u.id_movie = pe.id_movie) JOIN estudis es ON (u.estudis = es.estudis) ORDER BY pe.id_movie;

UPDATE estudis SET estudis = NULLIF(estudis, '') WHERE estudis = '';

UPDATE estudis
SET estudis = REPLACE(REPLACE(SUBSTRING_INDEX(estudis, ',', 1), '[', ''),'"', '')
WHERE estudis LIKE '%"%' OR estudis LIKE '"%';
 
INSERT INTO repartiment
SELECT u.id_movie, a.id_actor, u.rol FROM universal u JOIN pellicules pe ON (u.id_movie = pe.id_movie) JOIN actors a ON (u.actor = a.actor) ORDER BY pe.id_movie;

UPDATE repartiment SET rol = NULLIF(rol, '') WHERE rol = '';

DROP TEMPORARY TABLE IF EXISTS universal;
