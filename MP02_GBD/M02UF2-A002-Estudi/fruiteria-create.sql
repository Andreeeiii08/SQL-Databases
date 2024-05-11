DROP DATABASE IF EXISTS `fruiteria`;

CREATE DATABASE IF NOT EXISTS `fruiteria`;

USE `fruiteria`;

CREATE TABLE categories (
	id_categoria INT(2) UNSIGNED ZEROFILL AUTO_INCREMENT PRIMARY KEY,
	nom_categoria VARCHAR(30)
)engine=InnoDB;

CREATE TABLE productes (
	id_producte INT(2) UNSIGNED ZEROFILL AUTO_INCREMENT PRIMARY KEY,
	nom_producte VARCHAR(50),
	preu DECIMAL(10, 2),
	stock INT,
	temporada ENUM('Hivern', 'Estiu', 'Anual'),
	id_categoria INT(2) UNSIGNED ZEROFILL,
	FOREIGN KEY (id_categoria) REFERENCES categories(id_categoria)
);

CREATE TABLE provincies (
	id_provincia INT(4) UNSIGNED ZEROFILL AUTO_INCREMENT PRIMARY KEY,
	nom_provincia VARCHAR(50)
);

CREATE TABLE municipis (
	id_municipi INT(4) UNSIGNED ZEROFILL AUTO_INCREMENT PRIMARY KEY,
	nom_municipi VARCHAR(50),
	id_provincia INT(4) UNSIGNED ZEROFILL,
	FOREIGN KEY (id_provincia)  REFERENCES provincies(id_provincia)
);

CREATE TABLE majoristes (
	id_majorista INT(4) UNSIGNED ZEROFILL AUTO_INCREMENT PRIMARY KEY,
	nom_empresa VARCHAR(50),
	persona_empresa VARCHAR(50),
	id_municipi INT(4) UNSIGNED ZEROFILL,
	id_provincia INT(4) UNSIGNED ZEROFILL, 
	adreça VARCHAR(50),
	telèfon INT(9),
	correu_electrònic VARCHAR(70),
	FOREIGN KEY (id_municipi)  REFERENCES municipis(id_municipi)
);

/*Cuando hablamos de compra me refiero a la compra que hacer el mayorista del producto*/
CREATE TABLE compres (
	id_compra INT(3) UNSIGNED ZEROFILL AUTO_INCREMENT PRIMARY KEY,
	data_compra DATE,
	id_majorista INT(3) UNSIGNED ZEROFILL,
	FOREIGN KEY (id_majorista)  REFERENCES majoristes(id_majorista)	
);

/*Tabla que me relaciona los productos con las compras*/
CREATE TABLE productes_i_compres (
	id_compra INT(3) UNSIGNED ZEROFILL,
	id_producte INT(2) UNSIGNED ZEROFILL,
	quantitat INT,
	preu_total DECIMAL (10, 2),
	PRIMARY KEY (id_compra, id_producte),
	FOREIGN KEY (id_compra) REFERENCES compres(id_compra),
	FOREIGN KEY (id_producte) REFERENCES productes(id_producte)
);

/*Esto es el mayorista que vende dicho producto*/
CREATE TABLE vendes (
	numero_ticket INT(8) UNSIGNED ZEROFILL AUTO_INCREMENT PRIMARY KEY,
	id_majorista INT(4) UNSIGNED ZEROFILL,
	dia DATE,
	hora TIME,
	preu DECIMAL(10, 2),
	FOREIGN KEY (id_majorista) REFERENCES majoristes(id_majorista)
);
