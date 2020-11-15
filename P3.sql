CREATE DATABASE IF NOT EXISTS P3;

USE P3;

DROP TABLE IF EXISTS SPJ;
DROP TABLE IF EXISTS S;
DROP TABLE IF EXISTS P;
DROP TABLE IF EXISTS J;


create table S(
    SID          int UNSIGNED    not null    AUTO_INCREMENT,
    SNombre     VARCHAR(100)    not null,
    Situacion   int UNSIGNED    not null,
    Ciudad      VARCHAR(100)    not null,
    PRIMARY KEY (SID)
);


create table P(
    PID          int UNSIGNED    not null    AUTO_INCREMENT,
    PNombre     VARCHAR(100)    not null,
    Color       VARCHAR(100)    not null,
    Peso        int UNSIGNED    not null,
    Ciudad      VARCHAR(100)    not null,
    PRIMARY KEY (PID)
);

create table J(
    JID          int UNSIGNED    not null    AUTO_INCREMENT,
    JNombre     VARCHAR(100)    not null,
    Ciudad      VARCHAR(100)    not null,
    PRIMARY KEY (JID)
);


create table SPJ(
    SID         int UNSIGNED    not null,
    PID         int UNSIGNED    not null,
    JID         int UNSIGNED    not null,
    Cant        int unsigned    not null,
    PRIMARY KEY (SID, PID, JID),
    FOREIGN KEY (SID) REFERENCES S (SID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (PID) REFERENCES P (PID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (JID) REFERENCES J (JID) ON DELETE CASCADE ON UPDATE CASCADE
);

insert into S values (default, 'Salazar', 20, 'Londres');
insert into S values (default, 'Jaimes', 10, 'París');
insert into S values (default, 'Bernal', 30, 'París');
insert into S values (default, 'Corona', 20, 'Londres');
insert into S values (default, 'Aldana', 30, 'Atenas');

insert into P values (default, 'Tuerca', 'Rojo', 12, 'Londres');
insert into P values (default, 'Perno', 'Verde', 17, 'París');
insert into P values (default, 'Burlete', 'Azul', 17, 'Roma');
insert into P values (default, 'Burlete', 'Rojo', 14, 'Londres');
insert into P values (default, 'Leva', 'Azul', 12, 'París');
insert into P values (default, 'Engranaje', 'Rojo', 19, 'Londres');

insert into J values (default, 'Clasificador', 'París');
insert into J values (default, 'Perforadora', 'Roma');
insert into J values (default, 'Lectora', 'Atenas');
insert into J values (default, 'Consola', 'Atenas');
insert into J values (default, 'Compaginador', 'Londres');
insert into J values (default, 'Terminal', 'Oslo');
insert into J values (default, 'Cinta', 'Londres');

insert into SPJ values (1, 1, 1, 200);
insert into SPJ values (1, 1, 4, 700);
insert into SPJ values (2, 3, 1, 400);
insert into SPJ values (2, 3, 2, 200);
insert into SPJ values (2, 3, 3, 200);
insert into SPJ values (2, 3, 4, 500);
insert into SPJ values (2, 3, 5, 600);
insert into SPJ values (2, 3, 6, 400);
insert into SPJ values (2, 3, 7, 800);
insert into SPJ values (2, 5, 2, 100);
insert into SPJ values (3, 3, 1, 200);
insert into SPJ values (3, 4, 2, 500);
insert into SPJ values (4, 6, 3, 300);
insert into SPJ values (4, 6, 7, 300);
insert into SPJ values (5, 2, 2, 200);
insert into SPJ values (5, 2, 4, 100);
insert into SPJ values (5, 5, 5, 500);
insert into SPJ values (5, 5, 7, 100);
insert into SPJ values (5, 1, 4, 100);
insert into SPJ values (5, 3, 4, 200);
insert into SPJ values (5, 4, 4, 800);
insert into SPJ values (5, 5, 4, 400);
insert into SPJ values (5, 6, 4, 500);