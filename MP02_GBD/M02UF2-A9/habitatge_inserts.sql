LOAD DATA LOCAL INFILE '/home/usuari/sql/habitatge/municipi_com_prov.csv' 
INTO TABLE municipis
CHARACTER SET utf8mb3
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(codi_municipi, nom_municipi, @dummy, @dummy, @dummy, @dummy, UTM_X, UTM_Y, longitud, latitud, point);

LOAD DATA LOCAL INFILE '/home/usuari/sql/habitatge/houses_barcelona.csv' 
INTO TABLE habitatges_general
FIELDS TERMINATED BY ','
ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(descripció, @dummy, @dummy, nombre_banys, @dummy, @dummy, estat_conservacio, @dummy, @dummy, @dummy, @dummy, @dummy, id_habitatge, @dummy, @dummy, @dummy, @dummy, superfície_habitatge, @dummy, @dummy, preu_venda, nombre_dormitoris)
/*Faig que la superfície de la terrasa sigui un 10% de la superfície original del habitatge.*/
SET superfície_terrasa = superfície_habitatge * 0.1;

LOAD DATA LOCAL INFILE '/home/usuari/sql/habitatge/houses_girona.csv' 
INTO TABLE habitatges_general
FIELDS TERMINATED BY ','
ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(descripció, @dummy, @dummy, nombre_banys, @dummy, @dummy, estat_conservacio, @dummy, @dummy, @dummy, @dummy, @dummy, id_habitatge, @dummy, @dummy, @dummy, @dummy, superfície_habitatge, @dummy, @dummy, preu_venda, nombre_dormitoris)
/*Com al CSV no hi ha cap dada de la superfície de la terrasa, he agafat el 10% de la superfície habitatge.*/
SET superfície_terrasa = superfície_habitatge * 0.1;

LOAD DATA LOCAL INFILE '/home/usuari/sql/habitatge/houses_barcelona.csv' 
INTO TABLE característiques
FIELDS TERMINATED BY ','
ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@dummy, aire_condicionat, @dummy, @dummy, @dummy, ximenea, @dummy, @dummy, @parquing, @dummy, @calefacció, @dummy, id_habitatge, @dummy, ascensor, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, traster, piscina)
/*Es suposa que amb Trim faig que si parquing del CSV està buit, fica 0. Si té text, fica 1.*/
SET parquing = IF(TRIM(@parquing) <> '', 0, 1),
/*Faig el mateix amb la calefacció.*/
calefacció = IF(TRIM(@calefacció) <> '', 0, 1);

LOAD DATA LOCAL INFILE '/home/usuari/sql/habitatge/houses_girona.csv' 
INTO TABLE característiques
FIELDS TERMINATED BY ','
ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@dummy, aire_condicionat, @dummy, @dummy, @dummy, ximenea, @dummy, @dummy, @parquing, @dummy, @calefacció, @dummy, id_habitatge, @dummy, ascensor, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, traster, piscina)
/*Repito estratègia: quadre de text buit = FALSE (0), quadre amb text = TRUE (1)*/
SET parquing = IF(TRIM(@parquing) <> '', 0, 1),
calefacció = IF(TRIM(@calefacció) <> '', 0, 1);

LOAD DATA LOCAL INFILE '/home/usuari/sql/habitatge/houses_barcelona.csv' 
INTO TABLE energia
FIELDS TERMINATED BY ','
ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, id_habitatge);

LOAD DATA LOCAL INFILE '/home/usuari/sql/habitatge/houses_girona.csv' 
INTO TABLE energia
FIELDS TERMINATED BY ','
ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, id_habitatge);

/*Para discriminar entre cases i pisos faig una taula temporal. El criteri és: si té jardí, és una casa, sino és un pis.*/
CREATE TEMPORARY TABLE temp_habitatges (
	id_habitatge INT,
	jardí INT,
	superfície INT
);

/*Cargo les dades en la taula temporal.*/
LOAD DATA LOCAL INFILE '/home/usuari/sql/habitatge/houses_barcelona.csv' 
INTO TABLE temp_habitatges
FIELDS TERMINATED BY ','
ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, jardí, @dummy, id_habitatge, @dummy, @dummy, @dummy, @dummy, superfície);

LOAD DATA LOCAL INFILE '/home/usuari/sql/habitatge/houses_girona.csv' 
INTO TABLE temp_habitatges
FIELDS TERMINATED BY ','
ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, jardí, @dummy, id_habitatge, @dummy, @dummy, @dummy, @dummy, superfície);

/*Selecciono les dades que m'interessen de les temporals. En el cas de la casa, igual que abans, la superfície del jardí i del garatge serán un tant % del la superfície total.*/
INSERT INTO casa (id_habitatge, superfície_garatge, superfície_jardí) SELECT id_habitatge, superfície * 0.1 AS superfície_garatge, superfície * 0.2 AS superfície_jardí FROM temp_habitatges WHERE jardí = 1;
INSERT INTO pis (id_habitatge) SELECT id_habitatge FROM temp_habitatges WHERE jardí = 0;

/*Elimino la taula ja que no la necessito per res més. Quan feia proves no l'esborrava i s'acumulaven les dades.*/

DROP TEMPORARY TABLE temp_habitatges;

/*Aquí genero dades aleatories. Com en cap CSV té informació sobre si té mobles o no i si es té disponibilitat de lloguer, amb el rand genero aquestes dades. L'update actualitza taules amb la nova informació.*/
UPDATE característiques
SET mobles = ROUND(RAND());
UPDATE habitatges_general
SET disponibilitat_lloguer = ROUND(RAND()),
/*Això tampoc estava al CSV, así que m'he autogenerat les dades de contrucció.*/
any_construcció = YEAR(NOW()) - FLOOR(RAND() * 50);

/*Per la taula d'energia, no tinc res que importar. Per tant, genero les columnes al atzar:*/
UPDATE energia
SET
	certificat_energètic =
		CASE ROUND (RAND() * 6)
			WHEN 0 THEN 'A'
			WHEN 1 THEN 'B'
			WHEN 2 THEN 'C'
			WHEN 3 THEN 'D'
			WHEN 4 THEN 'E'
			WHEN 5 THEN 'F'
			ELSE 'G'
		END,
	consum_energètic = ROUND(RAND() * 1000),
	emissons_energètiques = ROUND(RAND() * 500);

/*Repito el mateix codi tant per a casa com per a pis.*/
UPDATE pis
SET
	tipus_pis =
		CASE ROUND (RAND() * 3)
			WHEN 0 THEN 'Àtic'
			WHEN 1 THEN 'Dúplex'
			WHEN 2 THEN 'Estudi'
			ELSE 'Loft'
		END;
UPDATE casa
SET
	tipus_casa =
		CASE ROUND (RAND() * 4)
			WHEN 0 THEN 'Aïllada'
			WHEN 1 THEN 'Adosada'
			WHEN 2 THEN 'Finca rústica'
			WHEN 3 THEN 'Masia'
			ELSE 'Castell'
		END;

/*Vaig intentar seleccionar el text del CSV per el nombre de pissos, però no em surt de cap forma. Per no deixar nulls, ho genero a l'atzar:*/
UPDATE habitatges_general
SET numero_plantes = ROUND(FLOOR(RAND()*4));

/*Per fer els municipis vaig tenir problemes per importar dades correspondent PKs. Tenint en compte que m'ha anat bé fer taules temporals*/

CREATE TEMPORARY TABLE temp_situació (
	id_municipi INT,
	nom_municipi VARCHAR(50),
	id_provincia INT,
	nom_provincia VARCHAR(50),
	id_comarca INT,
	nom_comarca VARCHAR(50)
);

/*Per ficar la comarca a dins de les taules provincies i comarques i assegurar-me que les FK coincideixen, importo el CSV i faig un SELECT DISTINCT.*/

LOAD DATA LOCAL INFILE '/home/usuari/sql/habitatge/municipi_com_prov.csv' 
INTO TABLE temp_situació
CHARACTER SET utf8mb3
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id_municipi, nom_municipi, id_provincia, nom_provincia, id_comarca, nom_comarca);

INSERT INTO provincies (codi_provincia, nom_provincia) SELECT DISTINCT id_provincia, nom_provincia FROM temp_situació; 
INSERT INTO comarques (codi_comarca, nom_comarca) SELECT DISTINCT id_comarca, nom_comarca FROM temp_situació;

/*Actualizo les FK de altres taules.*/
UPDATE municipis AS m
JOIN temp_situació AS ts ON m.codi_municipi = ts.id_municipi
SET m.codi_provincia = ts.id_provincia;

UPDATE provincies AS p
JOIN temp_situació AS ts ON p.codi_provincia = ts.id_provincia
SET p.codi_comarca = ts.id_comarca;

/*Esborro la taula temporal perquè ja no les necessito.*/
DROP TEMPORARY TABLE temp_situació;

/*Creo el codi INE amb els primers números del codi municipi i els últims del codi provincies*/
UPDATE municipis
SET codi_ine = LPAD(CONCAT(SUBSTRING(codi_municipi, 1, 2), LPAD(codi_provincia, 2, '0')), 5, '0');

/*Part final: taula habitatge_municipi. Com els habitatges estàn a Catalunya, he aprofitat que en la taula "municipis" només hi ha informació completa de llocs catalans. Per tant, de 2965 municipis que tinc en total, m'he quedat amb 503. He fet un "SELECT * FROM municipis WHERE UTM_X !=0;", ja que si és 0, és que està fora de Catalunya al no tenir aqueta informació i ser 0. He intentat aprofitar aquesta informació però no vaig poder*/

DROP TEMPORARY TABLE IF EXISTS tmp_habitatges;

CREATE TEMPORARY TABLE tmp_habitatges (
  id_habitatge INT,
  municipi VARCHAR(100)
);

LOAD DATA LOCAL INFILE '/home/usuari/sql/habitatge/houses_barcelona.csv'
INTO TABLE tmp_habitatges
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, id_habitatge, @dummy, @dummy, municipi);

LOAD DATA LOCAL INFILE '/home/usuari/sql/habitatge/houses_girona.csv'
INTO TABLE tmp_habitatges
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, id_habitatge, @dummy, @dummy, municipi);


CREATE TEMPORARY TABLE tmp_municipis AS
SELECT codi_municipi, nom_municipi FROM municipis;

CREATE TEMPORARY TABLE tmp_habitatges_ids AS
SELECT th.id_habitatge, tm.codi_municipi
FROM tmp_habitatges th
JOIN tmp_municipis tm ON th.municipi = tm.nom_municipi;

INSERT INTO habitatge_municipi (id_habitatge, codi_municipi)
SELECT * FROM tmp_habitatges_ids;

DROP TEMPORARY TABLE IF EXISTS tmp_habitatges;
DROP TEMPORARY TABLE IF EXISTS tmp_municipis;
DROP TEMPORARY TABLE IF EXISTS tmp_habitatges_ids;

/*FI DE LA TASCA.*/
