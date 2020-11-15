CREATE DATABASE IF NOT EXISTS Parcial2019;

USE Parcial2019;

DROP TABLE IF EXISTS asignacionViaje;
DROP TABLE IF EXISTS vuelo;
DROP TABLE IF EXISTS piloto;
DROP TABLE IF EXISTS aeropuerto;

create table piloto (
    CodPiloto       int unsigned    not null    auto_increment, 
    NombrePiloto    varchar(100)    not null,   
    Salario         int UNSIGNED    not null, 
    Compañia        varchar(100)    not null,
    Pais            varchar(100)    not null,
    PRIMARY KEY (CodPiloto)
);

create table aeropuerto (
    CodAerop        varchar(3)      not null,
    NombreAerop     varchar(100)    not null,
    Ciudad          VARCHAR(100)    not null,
    Pais            VARCHAR(100)    not null,
    PRIMARY KEY (CodAerop)
);

create table vuelo (
    CodVuelo        varchar(100)    not null, 
    CodAeropOrigen  varchar(100)    not NULL,
    CodAeropDestino varchar(100)    NOT NULL,
    HoraSalida      DATETIME        NOT NULL,
    PRIMARY KEY (CodVuelo),
    FOREIGN KEY (CodAeropOrigen) REFERENCES aeropuerto (CodAerop) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CodAeropDestino) REFERENCES aeropuerto (CodAerop) ON DELETE CASCADE ON UPDATE CASCADE
);

create table asignacionViaje (
    CodVuelo        varchar(100)    not null,
    Fecha           DATETIME        not null,
    CodPiloto       int unsigned    not null,
    IdAvion         int unsigned    not null,
    PRIMARY KEY (CodVuelo, Fecha),
    FOREIGN KEY (CodVuelo) REFERENCES vuelo(CodVuelo) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CodPiloto) REFERENCES piloto(CodPiloto) ON DELETE CASCADE ON UPDATE CASCADE
);

