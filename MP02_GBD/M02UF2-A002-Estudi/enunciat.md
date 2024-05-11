# M02UF2-A002-Estudi

## Nom de la base de dades: fruiteria

## Nota final: al ser una activitat extra, no té nota

## Data de publicació: 23.04.2024

## Data d'entrega: 30.04.2024 (data de l'exàmen)

## Enunciat:

Base de dades `fruiteria`

Volem crear una base de dades per a gestionar els productes que compren i venen en una fruiteria de barri. No només venen Fruites, sinó també, Verdures, Fruits secs, Edulcorants, Cereals, Llegums, Ous, Begudes, Olis i Salses i/o condiments alimentaris, en un futur aquestes categories podrien augmentar o disminuir si ens interessés o bé afegir altres atributs que les puguin complementar.

Les compres dels nostres productes es faran a un o diversos majoristes, ja que un mateix majorista podrà vendre productes de una o més categories, cosa que voldrem tenir registrat, cas per cas.


Cada producte només pertany a una categoria en particular i volem saber a més del seu codi, nom i categoria, el preu actual de venda, el seu stock o romanent i la temporada a la que pertany el producte (Hivern, Estiu o Anual)

Dels majoristes, ens interessa el nom de l'empresa i el del seu representant o persona de contacte, què és amb qui farem les compres. Volem saber en quina ciutat o municipi està situada l'empresa (i aquesta ciutat o municipi estarà relacionada amb la seva província), la seva adreça, un telèfon de contacte i un correu electrònic.

Cada vegada que fem una compra de productes a un majorista, haurem de generar la nostra comanda amb la data en que la generem i cada producte per a cada majorista que comprem en una mateixa data formarà part de la mateixa comanda. De cada compra necessitem saber quants productes comprem i el seu preu de compra en aquell moment, ja que una vegada tinguem els productes al magatzem, el preu actual s'haurà d'actualitzar un 20% per sobre del preu de compra, de forma automàtica.

En el cas de les vendes, al ser a un client minorista final, no es generaran factures ni necessitarem dades dels clients, farem servir un sistema de tiquets amb un número únic per tiquet que es generaran amb la data i hora de la venda. Cada venda a un client contindrà cadascun dels productes amb la seva quantitat i el preu unitari, què, com en el cas de les compres, no podrem tenir productes repetits en un mateix tiquet, per això fem servir el camp quantitat. El preu de venda de cada producte, anirà variant amb el temps i mai hauria de ser inferior al preu actual de producte. Els tiquets, també inclouran un camp `descompte` que per defecte serà 0, però que en algun cas, degut a promocions, el podríem modificar.

Pels municipis i províncies a nivell d'Estat que farem servir, els podem extraure d'aquesta web:
https://www.ine.es/daco/daco42/codmun/cod_num_muni_provincia_ccaa.htm

S'ha de presentar l'arxiu o arxius:

fruiteria-create.sql : Creació de la base de dades
fruiteria-insert.sql : Dades amb un mínim de 7 registres per taula
fruiteria-png : L'esquema de la base de dades obtingut mitjançant enginyeria inversa
fruiteria-check.txt : Un describe de cada taula i un Select * de cada taula.

Els arxius han de tenir extensió .sql, .png i .txt cap altre format