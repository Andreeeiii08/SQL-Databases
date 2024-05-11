DROP DATABASE IF EXISTS `habitatge`;

CREATE DATABASE IF NOT EXISTS `habitatge`;

USE `habitatge`;

CREATE TABLE comarques (
	codi_comarca INT PRIMARY KEY,
	nom_comarca CHAR(50)
);

CREATE TABLE provincies (
	codi_provincia INT PRIMARY KEY,
	nom_provincia VARCHAR(50),
	codi_comarca INT,
	FOREIGN KEY (codi_comarca) REFERENCES comarques(codi_comarca)
);

CREATE TABLE municipis (
	codi_municipi INT PRIMARY KEY,
	nom_municipi CHAR(50),
	codi_provincia INT,
	codi_ine INT,
	latitud DECIMAL(10, 8),
	longitud DECIMAL(10, 8),
	UTM_X INT(10),
	UTM_Y INT(10),
	point VARCHAR(50),
	FOREIGN KEY (codi_provincia) REFERENCES provincies(codi_provincia)
);

CREATE TABLE habitatges_general (
	id_habitatge INT PRIMARY KEY,
	numero_plantes INT,
	nombre_dormitoris INT,
	nombre_banys INT,
	superfície_habitatge DECIMAL(10, 2),
	superfície_terrasa DECIMAL(10, 2),
	any_construcció YEAR,
	estat_conservacio CHAR(30),
	preu_venda DECIMAL(10,2),
	disponibilitat_lloguer BOOL,
	descripció VARCHAR(140),
	data_actualizació TIMESTAMP default current_timestamp
);

/*Taula que em relaciona els habitatges amb els municipis i els seus derivats (provincies, comarca i comunitat autonoma).*/
CREATE TABLE habitatge_municipi (
	id_habitatge INT,
	codi_municipi INT,
	FOREIGN KEY (id_habitatge) REFERENCES habitatges_general(id_habitatge),
	FOREIGN KEY (codi_municipi) REFERENCES municipis(codi_municipi)
);

CREATE TABLE casa(
	id_casa INT PRIMARY KEY AUTO_INCREMENT,
	id_habitatge INT,
	tipus_casa ENUM('Aïllada', 'Adosada', 'Finca rústica', 'Masia', 'Castell'),
	superfície_garatge DECIMAL(10, 2),
	superfície_jardí DECIMAL(10, 2),
	FOREIGN KEY (id_habitatge) REFERENCES habitatges_general(id_habitatge)
);

CREATE TABLE pis(
	id_pis INT PRIMARY KEY AUTO_INCREMENT,
	id_habitatge INT,
	tipus_pis ENUM('Àtic', 'Dúplex', 'Estudi', 'Loft'),
	FOREIGN KEY (id_habitatge) REFERENCES habitatges_general(id_habitatge)
);

CREATE TABLE característiques(
	id_habitatge INT,
	aire_condicionat BOOL,
	ascensor BOOL,
	calefacció BOOL,
	mobles BOOL,
	parquing BOOL,
	piscina BOOL,
	traster BOOL,
	ximenea BOOL,
	FOREIGN KEY (id_habitatge) REFERENCES habitatges_general(id_habitatge)
);

CREATE TABLE energia(
	id_habitatge INT,
	certificat_energètic ENUM('A', 'B', 'C', 'D', 'E', 'F', 'G'),
	consum_energètic DECIMAL(10, 2),
	emissons_energètiques DECIMAL(10, 2),
	FOREIGN KEY (id_habitatge) REFERENCES habitatges_general(id_habitatge)
);
