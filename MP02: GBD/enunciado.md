# M02UF3-A2 - movies: Import-export data

## Nom de la base de dades: movies

## Nota final: 7,4/10

## Data de publicació: 21.02.2024

## Data d'entrega: 28.02.2024

## Enunciat:

He fet una exportació a CSV simplificant l'extracció.
En el cas dels actors i actrius, apareixen tants registres com pel·lícules a les que pertany cadascú i el role (rol) que interpreta.

a. (36%) Crea una BBDD de nom movies, en la que es puguin distribuir les dades de l'arxiu CSV fent servir qualsevol taula temporal que necessites fins a distribuir totes les columnes en taules normalitzades. L'arxiu de creació de taules es dirà: movies-create.sql

Suposarem què:
Cada pel·lícula podria tenir més d'un gènere, més d'un país origen, més d'un director i evidentment més d'un actor/actriu principal (cadascú amb el seu rol interpretatiu o representatiu).
Suposarem que cada pel·lícula només tindrà uns estudis de producció.

b. (40%) Crea un arxiu per inserir les dades a les taules (utilitzant LOAD DATA LOCAL INFILE i les comandes necessaries SQL). L'arxiu d'importació de dades es dirà: movies-insert.sql
c. (10%) Genera l'arxiu d'esquema de taules en mysql Workbench de nom: movies-schema.png
d. (14%) Crea una exportació de la base de dades que separaràs en dos arxius independents.
Un per a les taules: movies-taules-dump.sql
Un per a les dades: movies-dades-dump.sql
En l'arxiu export.txt que també hauràs d'adjuntar, indicaràs les dues comandes que has fet servir per obtenir cadascun dels arxius amb mysqldump

Per crear les còpies de seguretat o exportació de taules i dades, has de fer servir una comanda externa amb el client: mysqldump

