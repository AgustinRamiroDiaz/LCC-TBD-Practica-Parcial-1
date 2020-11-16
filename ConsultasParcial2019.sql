--I

--AR
--1 
pi Empleado, Departamento, Curso
    (sigma 
        trabajaEn.departamento!=requiere.departamento or 
        realiza.curso=requiere.curso 
            (trabajaEn |x| realiza) x requiere)
/ requiere

E D C
E D C

'Agus'  'Ñoquis'    'RCP'
'Agus'  'Ñoquis'    'BaB'
'Litma' 'RRHH'      'CS'
'Facu'   'RRHH'     'xd'

'Ñoquis'    'RCP'
'Ñoquis'    'BaB'
'Ñoquis'    'xd'
'RRHH'      'CS'

'Agus'  'Ñoquis'    'RCP'       'Ñoquis'    'RCP'
                                'Ñoquis'    'BaB'
                                'RRHH'      'CS'
                                'Ñoquis'    'xd'
'Agus'  'Ñoquis'    'BaB'       'Ñoquis'    'RCP'
                                'Ñoquis'    'BaB'
                                'RRHH'      'CS'
                                'Ñoquis'    'xd'
'Litma' 'RRHH'      'CS'        'Ñoquis'    'RCP'
                                'Ñoquis'    'BaB'
                                'RRHH'      'CS'
                                'Ñoquis'    'xd'
'Facu'   'RRHH'     'xd'        'Ñoquis'    'RCP'
                                'Ñoquis'    'BaB'
                                'RRHH'      'CS'
                                'Ñoquis'    'xd'                


'Agus'  'Ñoquis'            'Ñoquis'    'RCP'
                            'Ñoquis'    'BaB'
                            'RRHH'      'CS'
'Litma' 'RRHH'              'Ñoquis'    'RCP'
                            'Ñoquis'    'BaB'
                            'RRHH'      'CS'
                            'Ñoquis'    'xd'
'Facu'  'RRHH'              'Ñoquis'    'RCP'
                            'Ñoquis'    'BaB'
                            'Ñoquis'    'xd'

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

--b

--4 
CVuelos <- pi codVuelo (sigma codAerop=codAeropOrigen and pais='Paraguay' vuelo x aeropuerto)
(pi NombrePiloto, codvuelo (asignacionViaje |x| piloto)) / CVuelos

--5
pi NombrePiloto (piloto |x| asignacionViaje |x| (sigma codAerop=codAeropDestino and pais='Chile' vuelo x aeropuerto))
intersección
pi NombrePiloto (piloto |x| asignacionViaje |x| (sigma codAerop=codAeropDestino and pais='Uruguay' vuelo x aeropuerto))

--6
vuelosJG <- pi codVuelo ((sigma NombrePiloto='Juan González' piloto) |x| asignacionViaje)
sigma NombrePiloto!='Juan González' ((pi NombrePiloto, codvuelo (asignacionViaje |x| piloto)) / vuelosJG)