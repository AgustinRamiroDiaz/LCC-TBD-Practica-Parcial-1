--I

--II

--AR
--2
π_(nombre) (σ_(C# = 'C1' v C# = 'C7') (σ_(J#=J1# ∨ J#=J2#) jugadores x partidas))

--3
π_(nombre) Jugador |x| (π_j1#,c#(partidas) U π_j2#,c#(partidas) / π_C# (σ_(C#='C1' ∨ C#='C7') Campeonatos))

--4
π_CNombre (σ_j1.Nacionalidad=j2.nacionalidad 
    and j1.J#=partidas.J1# and j2.J#=partidas.J2# 
        (campeonatos |x| partidas x ρ_j1 (jugadores) x ρ_j2 (jugadores)))

--5
π_Nombre jugadores - π_Nombre (σ_(J#=J1# ∨ J#=J2#) jugadores x partidas))


π_(nombre) (Jugador |x| (π_j# (jugadores) - (π_j1#(partidas) U π_j2#(partidas))))

--SQL
--2
select Nombre from JUGADORES, PARTIDAS
where (jugadores.J# = Partidas.J1# or jugadores.J# = Partidas.J2#)
and (C# = 'C1' or C# ='C7');

--3
select Nombre from jugadores
where exists (select * from partidas where c# = 'C1' and (J# = J1# or J# = J2#))
AND   exists (select * from partidas where c# = 'C7' and (J# = J1# or J# = J2#))

--4
select CNombre from campeonatos, jugadores as j1, jugadores as j2, partidas
where campeonatos.C# = partidas.C# and j1.J# = partidas.J1# and j2.J# = partidas.J2#
and j1.nacionalidad = j2.nacionalidad

--5
select nombre from jugadores
where not exists 
(
    select * from partidas 
    where (J# = J1# or J# = J2#)
)
 
--III

--AR
--1
π_Nombre (σ_(NombreMadre=NombreMujer ∧ NombrePadre=NombreVaron ∧ (FechaNac > FechaFin ∨ FechaNac < FechaRealizacion)) persona x matrimonio)
-- me gusta el uno, me gusta tú.
--2
pm <- (σ_(NombreMadre=NombreMujer ∧ NombrePadre=NombreVaron ∧ (FechaNac < FechaFin ∧ FechaNac > FechaRealizacion)) persona x matrimonio)

π_persona.nombre(σ_persona.fechaNac < p2.fechaNac and p2.nombreMadre=persona.nombreMadre and p2.nombrePadre=persona.rombreMadre and p2.FechaNac < FechaFin ∧ p2.FechaNac > FechaRealizacion ((σ_(NombreMadre=NombreMujer ∧ NombrePadre=NombreVaron ∧ (FechaNac < FechaFin ∧ FechaNac > FechaRealizacion)) persona x matrimonio) x rho_p2 (persona)))
π_persona.nombre
    (σ
        (persona.fechaNac < p2.fechaNac and p2.nombreMadre=persona.nombreMadre and p2.nombrePadre=persona.rombreMadre and p2.FechaNac < FechaFin ∧ p2.FechaNac > FechaRealizacion) 
        ((σ
            (NombreMadre=NombreMujer ∧ NombrePadre=NombreVaron ∧ (FechaNac < FechaFin ∧ FechaNac > FechaRealizacion))
            persona x matrimonio
        ) x rho_p2 (persona))
    )

--3
π_Nombre persona - π_xadre.Nombre
(
    σ_(hije.NombreMadre=xadre.Nombre or hije.NombrePadre=xadre.Nombre) 
        (rho_hije (persona) x rho_xadre (persona))
)

--4
π_Nombre(persona) - (π_NombreMujer(matrimonio) U π_NombreVaron(matrimonio))

--5
tupla <- σ_(p1.NombreMadre = p2.Nombre) (rho_p1 (persona) x rho_p2 (persona)) --(persona, madre)
π_p2.nombre (σ_p1.sexo="varon" (tupla)) ⋂ π_p2.nombre (σ_p1.sexo="mujer" (tupla))

--6
pm <- (σ_(Sexo='Femenino' and NombreMadre=NombreMujer ∧ NombrePadre=NombreVaron ∧ (FechaNac < FechaFin ∧ FechaNac > FechaRealizacion)) persona x matrimonio)
π_(NombreMujer, NombreVaron) matrimonio - π_(nombreMujer, nombreVaron) pm

--7

mm <- σ_(m1.fechaRealizacion<m2.fechaRealizacion and m1.NombreMujer=m2.NombreMujer and m1.NombreVaron=m2.NombreVaron) 
    (rho_m1 (matrimonio) x rho_m2 (matrimonio))

cch <-σ_(nombrePadre=NombreVaron and nombreMadre=NombreMujer and FechaRealizacion<= FechaNac and FechaNac<=FechaFin) ((matrimonio - π_m2 (mm)) x persona)

π_nombrePadre(cch) U π_nombreMadre(cch)

-- TODO SQL



-- Ejercicios Adicionales
--1
--SQL
--a

select videoclub
from vidoteca
where pelicula in (select pelicula from gusta where aficionado = 'José Peréz');

select videoclub
from videoteca
where exists (select pelicula from gusta where aficionado = 'José Peréz' and gusta.pelicula = videoteca.pelicula);


--b
select aficionado
from socio, videoteca, gusta
where socio.videoclub = videoteca.videoclub 
and videoteca.pelicula = gusta.pelicula
and socio.aficionado = gusta.aficionado;

--c
select aficionado from (select aficionado from gusta) UNION (select aficionado from socio) where aficionado not in b;

--d
select videoclub
from videoteca
where pelicula = "A" or pelicula = "B"
group by videoclub
having count (*) = 2;

select videoclub
from videoteca
where exists (select * from videoclub as v2 where videoclub.videoteca=v2.videoteca and pelicula='A')
and   exists (select * from videoclub as v2 where videoclub.videoteca=v2.videoteca and pelicula='B')

select videoclub
from videoteca
where 'A' in (select pelicula from videoteca as v2 where videoteca.videoclub=v2.videoclub)
and   'B' in (select pelicula from videoteca as v2 where videoteca.videoclub=v2.videoclub)


--e
select distinct aficionado
from socio, gusta, videoteca
where socio.videoclub = videoteca.videoclub 
and videoteca.pelicula = gusta.pelicula
and socio.aficionado = gusta.aficionado;
GROUP BY socio.aficionado having (count(DISTINCT videoteca.videoclub) >= 2);

--2
--SQL
--a
select libreria# from ELL
    where editorial# in (select editorial# from editoriales where ciudad = "rosario");

--b
select editorial# from ELL
    where libreria = "P1" or libreria = "P3"
    group by editorial
    having count (*) = 2;

--c
select libreria# from ELL
    group by libreria#
    having count (distinct editorial#) = select count (editorial#) from editoriales;



--3
--AR
--a
π_(nombre, direccion) (guias |x| (π_(cod-guia)(guias) - π_(cod-guia)(partida)))


--b
π_nombre (guia |x| (π_(cod-guia)(partida) - π_(cod-guia) (σ_(cod-coto='C3' or cod-coto='C7') partida)))

--c
(π_(cod-guia) (σ_(cod-coto='C1') partida) ⋂ (π_(cod-guia) (σ_(cod-coto='C5') partida)

--d
e <- π_cod-especie Especies
π_cod-coto ((π_(cod-coto, cod-especie) partida) / e)

--SQL
--a
select nombre, direccion
from guias
where not exists (select * from partida where partida.cod-guia=guias.cod-guia)

select nombre, direccion from guias
    where cod-guia not in (select distinct cod-guia from partida);

--b
select nombre
from guias
where cod-guia not in (select cod-guia from partida where cod-coto='C3' or cod-coto='C7');

select nombre
from guias
where not exists (select * from partida where (cod-coto = 'C3' or cod-coto='C7') and (guias.cod-guia = partida.cod-guia));

--c
select nombre
from guias
where cod-guia in (select cod-guia from partida where cod-coto='C1')
and   cod-guia in (select cod-guia from partida where cod-coto='C5');

--d
select nombre
from cotos, partida
where cotos.cod-coto = partida.cod-coto
group by cotos.cod-coto
having count (distinct partida.cod-especie) = select count(especie.cod-especie) from especies;


--4
--AR

--a
π_nombre (σ_(grupo='C' or grupo='F') Alumnos)

--b
π_(nombre) (alumnos |x| ((π_(A#, P#) entrega) / (π_P# (σ_(curso = "3")) practicas)))

--c
2 <- π_a#(σ_(curso = "segundo") (practicas |x| entrega)))
3 <- π_a#(σ_(curso = "tercer") (practicas |x| entrega)))
π_(nombre) (alumnos |x| (2 ⋂ 3))

--d
\pi_(nombres) (Alumnos |x| (\pi_(#A) Alumno)) - (\pi_(A#) (σ_(curso <> 'segundo') (Entrega |x| Practicas))))

--e
π_a1.nombre (σ_(a1.grupo=a2.grupo and a2.A#='A25') (rho_a1 alumnos x rho_a2 alumnos))

gj <- π_grupo (σ_A#='A25' Alumnos)
π_nombre (Alumnos |x| gj)

--f
π_nombre (alumnos - (alumnos |x| (π_A# entrega)))

--SQL
--a
select nombre
from alumnos
where grupo = 'C' or grupo = 'F'

--b
select nombre
from alumnos, entrega, practicas
where alumnos.a# = entrega.a#
and practica.p# = entrega.p#
and curso = 'tercero'
GROUP BY entrega.a#
having count (distinct entrega.p#) = select count(practicas.p#) from practicas where curso = 'tercero';

select nombre
from alumnos
where not exists 
    (select * from practicas where curso="3" 
        and not exists 
            (select * from entrega where alumnos.A# = entrega.A# and practicas.P# = entrega.P#)
    )


--c
select nombre
from alumnos
where exists (select * from practicas, entrega where practica.p# = entrega.p# and entrega.A# = alumnos.A# and curso='2')
and exists (select * from practicas, entrega where practica.p# = entrega.p# and entrega.A# = alumnos.A# and curso='3')

select nombre from alumnos
    where   a#  in (select a# from entrega, practicas 
                    where entrega.p# = practicas.p#
                    and curso = "segundo")
    and     a#  in (select a# from entrega, practicas 
                    where entrega.p# = practicas.p#
                    and curso = "tercero")

--d
select nombre
from alumnos
where not exists (select * from practicas, entrega 
                 where practica.curso <> 'segundo' 
                 and alumno.a# = entrega.a#
                 and entrega.p# = practica.p#);


--e
select a1.nombre
from alumnos as a1, alumnos as a2
where a1.grupo = a2.grupo and a2.A#='A25';

select nombre
from alumnos
where grupo = (select grupo from alumnos where A#='A25')

--f
select nombre
from alumno
where not exists (select * from entrega where alumno.A# = entrega.A#)

select nombre from alumno
where a# not in (select distinct a# from entregas);