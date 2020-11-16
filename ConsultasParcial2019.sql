--I

--AR
--1 TODO REVISAR
(trabajaEn |x| realiza) / requiere

--2
pi curso (sigma departamento='RRHH'||departamento='Seguridad' Requiere)

--3
pi departamento Requiere - pi departamento (trabajaEn |x| requiere |x| realiza)

--SQL
--1
select empleado
from trabajaEn
where not exists 
(
    select curso
    from requiere 
    where requiere.departamento = trabajaEn.departamento
    and not in (select curso from realiza where trabajaEn.empleado = realiza.empleado) 
);


--2
select distinct curso
from requiere
where departamento = 'RRHH' or departamento = 'Seguridad'; 

--3
select departamento
from requiere
where 
not exists 
(
    select * 
    from trabajaEn, realiza 
    where trabajaEn.departamento = requiere.departamento and trabajaEn.empleado = realiza.empleado 
    and requiere.curso = realiza.curso
);

--II

--a

--1
select distinct ciudad, pais
from aeropuerto
where CodAerop in
    -- Códigos de aeropuertos a los cuales llegan vuelos desde Rosario, Argentina
    (select codAeropDestino
    from vuelo
    where codAeropOrigen = 
        -- Código del aeropuerto de Rosario, Argentina
        (select codAerop from aeropuerto where ciudad = "Rosario" and Pais = 'Argentina'));


--2
select codVuelo, horaSalida
from vuelo, aeropuerto as aOrigen, aeropuerto as aDestino
where vuelo.CodAeropOrigen = aOrigen.codAerop and vuelo.CodAeropDestino = aDestino.codAerop 
and aOrigen.Pais = aDestino.Pais;


--3
select *
from 
(select piloto.pais, count(compañia) as cant
from piloto, asignacionViaje, vuelo, aeropuerto as aOrigen, aeropuerto as aDestino
where piloto.CodPiloto = asignacionViaje.CodPiloto
and asignacionViaje.codVuelo = vuelo.CodVuelo
and vuelo.CodAeropOrigen = aOrigen.codAerop and vuelo.CodAeropDestino = aDestino.codAerop 
and piloto.Pais = aOrigen.Pais
and aOrigen.Pais <> aDestino.Pais
GROUP BY piloto.pais) as t
where t.cant > 10

