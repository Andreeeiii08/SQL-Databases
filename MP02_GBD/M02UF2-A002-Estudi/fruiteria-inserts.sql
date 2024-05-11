/*Creo las categorias de cada fruta.*/
INSERT INTO categories(nom_categoria) VALUES
('fruites'),
('verdures'),
('fruits secs'),
('edulcorants'),
('cereals'),
('llegums'),
('ous'),
('begudes'),
('olis'),
('salses'),
('condiments alimentaris');

/*Para los municipios y provincias, aprovecho el CSV de la anterior tarea puntuable. Los meto en una tabla temporal.*/

CREATE TEMPORARY TABLE temp_prov (
	id_municipi INT,
	nom_municipi VARCHAR(50),
	id_provincia INT,
	nom_provincia VARCHAR(50)
);

LOAD DATA LOCAL INFILE '/home/usuari/sql/habitatge/municipi_com_prov.csv' 
INTO TABLE municipis
CHARACTER SET utf8mb3
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id_municipi, nom_municipi);

LOAD DATA LOCAL INFILE '/home/usuari/sql/habitatge/municipi_com_prov.csv' 
INTO TABLE temp_prov
CHARACTER SET utf8mb3
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id_municipi, nom_municipi, id_provincia, nom_provincia);

INSERT INTO provincies (id_provincia, nom_provincia) SELECT DISTINCT id_provincia, nom_provincia FROM temp_prov; 

UPDATE municipis AS m
JOIN temp_prov AS tp ON m.id_municipi = tp.id_municipi
SET m.id_provincia = tp.id_provincia;

/*Esborro la taula temporal perquè ja no les necessito.*/
DROP TEMPORARY TABLE temp_prov;

/*Se pedían 7 registros por tabla, así que he hecho 7. He sacado los datos con un "SELECT id_municipi, id_provincia FROM municipis order by rand() limit 7;"*/
INSERT INTO majoristes (nom_empresa, persona_empresa, id_municipi, id_provincia, adreça, telèfon, correu_electrònic) VALUES
('Mariscos Recio', 'Antonio Recio', 1257, 0005, 'Calle Mirador de Montepinar 7', 612435657, 'arecio@mariscosrecio.es'),
('Frutería Cuestista', 'Juan Cuesta', 1277, 0028, 'Calle Desengaño 21', 623445875, 'jcuesta@fruteriacuestista.com'),
('Supermercado barato 123', 'Arataki Itto', 0540, 0003, 'Carretera de Inazuma 69', 784123834, 'aitto@arataki.cat'),
('Drinks with Fidelito', 'Fidel Martínez', 2083, 0009, 'Calle de los Miedos Sagrados 3', 623134674, 'fmartinez@drinksfidelito.es'),
('Los Mercados Lápida', 'Elvira Lápida', 2209, 0044, 'Plaza de Vista Gentil', 601234987, 'elapida@lapida.com'),
('El Bar de Moe', 'Moe Szyslak', 1737, 0026, 'Calle de Springfield 21', 740433424, 'mszyslak@barmoe.es'),
('LeBlanc', 'Ren Amamiya Joker', 3147, 0037, 'Avenida de Yongen-Jaya', 534555234, 'ramamiya@leblanc.com');

/*Mi frutería es muy pobre porque solo tiene un producto por cada categoría.*/
INSERT INTO productes (nom_producte, preu, stock, temporada, id_categoria) VALUES
('poma',  1.5, 100, 'Estiu', 1),
('enciam', 1.0, 55, 'Estiu', 2),
('nous', 3.0, 80, 'Anual', 3),
('sucre', 2.5, 120, 'Anual', 4),
('cereals', 3.0, 56, 'Anual', 5),
('llenties', 1.4, 34, 'Hivern', 6),
('ous de gallina', 1.0, 150, 'Anual', 7),
('Coca-Cola', 2.5, 100, 'Anual', 8),
('oli oliva', 6.0, 12, 'Anual', 9),
('salsa barbacoa', 4.5, 34, 'Anual', 10),
('sal', 0.5, 123, 'Anual', 11);

/*Con esto, por cada mayorista, hago una compra. La data de la compra lo he autogenerado.*/
INSERT INTO compres (data_compra, id_majorista)
SELECT DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365)DAY), id_majorista FROM majoristes;

/*Relación de productos y compras. He hecho los cálculos a mano.*/
INSERT INTO productes_i_compres (id_compra, id_producte, quantitat, preu_total) VALUES
(001, 001, 12, 18),
(002, 004, 23, 57.5),
(003, 005, 34, 102),
(004, 003, 5, 15),
(005, 007, 12, 12),
(006, 011, 100, 50),
(007, 010, 33, 148.5);

/*Genero datos al azar para las vendas. Todo pasa en el mismo momento porque intenté ponerlo aleatorio pero me salían cosas imposibles como un día de 45 horas o compras hechas en 2025.*/
INSERT INTO vendes (id_majorista, dia, hora, preu)
SELECT id_majorista, CURDATE(), CURTIME(), ROUND(RAND() * 1000, 2) FROM majoristes ORDER BY RAND() LIMIT 10;
