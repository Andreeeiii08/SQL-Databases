DROP DATABASE IF EXISTS movies;
CREATE DATABASE IF NOT EXISTS movies;
USE movies;

CREATE TABLE pellicules (
    id_movie INT,
    titol VARCHAR(100) UNIQUE,
    any INT,
    vots INT,
    PRIMARY KEY(id_movie)
);

CREATE TABLE gèneres (
    id_genere INT PRIMARY KEY AUTO_INCREMENT,
    genere VARCHAR(100)	UNIQUE
)engine=innoDB;

CREATE TABLE països (
    id_pais INT PRIMARY KEY AUTO_INCREMENT,
    pais VARCHAR(100) UNIQUE
);

CREATE TABLE directors (
    id_director INT PRIMARY KEY AUTO_INCREMENT,
    director VARCHAR(100) UNIQUE
);

CREATE TABLE actors (
    id_actor INT PRIMARY KEY AUTO_INCREMENT,
    actor VARCHAR(100) UNIQUE
);

CREATE TABLE estudis (
    id_estudi INT PRIMARY KEY AUTO_INCREMENT,
    estudis VARCHAR(100) UNIQUE
);

CREATE TABLE repartiment (
    id_movie INT,
    id_actor INT,
    rol VARCHAR(200),
    FOREIGN KEY (id_movie) REFERENCES pellicules(id_movie),
    FOREIGN KEY (id_actor) REFERENCES actors(id_actor)
);

CREATE TABLE pellicules_gèneres (
    id_movie INT,
    id_genere INT,
    PRIMARY KEY (id_movie, id_genere),
    FOREIGN KEY (id_movie) REFERENCES pellicules(id_movie),
    FOREIGN KEY (id_genere) REFERENCES gèneres(id_genere)
);

CREATE TABLE pellicules_països (
    id_movie INT,
    id_pais INT,
    PRIMARY KEY (id_movie, id_pais),
    FOREIGN KEY (id_movie) REFERENCES pellicules(id_movie),
    FOREIGN KEY (id_pais) REFERENCES països(id_pais)
);

CREATE TABLE pellicules_directors (
    id_movie INT,
    id_director INT,
    PRIMARY KEY (id_movie, id_director),
    FOREIGN KEY (id_movie) REFERENCES pellicules(id_movie),
    FOREIGN KEY (id_director) REFERENCES directors(id_director)
);

CREATE TABLE pellicules_estudis (
    id_movie INT,
    id_estudi INT,
    PRIMARY KEY (id_movie, id_estudi),
    FOREIGN KEY (id_movie) REFERENCES pellicules(id_movie),
    FOREIGN KEY (id_estudi) REFERENCES estudis(id_estudi)
);

CREATE TEMPORARY TABLE IF NOT EXISTS universal(
    id_movie INT,
    titol VARCHAR(100),
    any INT,
    vots INT,
    genere VARCHAR(100),
    pais VARCHAR(100),
    director VARCHAR(100),
    estudis VARCHAR(100),
    actor VARCHAR(100),
    rol VARCHAR(255),
    PRIMARY KEY(id_movie)
);
