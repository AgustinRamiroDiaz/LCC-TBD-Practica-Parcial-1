--I

--II

--AR
--2
π_(nombre) (σ_(C# = 'C1' v C# = 'C7') (σ_(J#=J1# ∨ J#=J2#) jugadores x partidas))

--3
π_(nombre) Jugador |x| (π_j1#,c#(partidas) U π_j2#,c#(partidas) / π_C# (σ_(C#='C1' ∨ C#='C7') Campeonatos))

--4
π_CNombre (sigma_j1.Nacionalidad=j2.nacionalidad 
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

pi_persona.nombre(σ_persona.fechaNac < p2.fechaNac and p2.nombreMadre=persona.nombreMadre and p2.nombrePadre=persona.rombreMadre and p2.FechaNac < FechaFin ∧ p2.FechaNac > FechaRealizacion ((σ_(NombreMadre=NombreMujer ∧ NombrePadre=NombreVaron ∧ (FechaNac < FechaFin ∧ FechaNac > FechaRealizacion)) persona x matrimonio) x rho_p2 (persona)))

--3
pi_Nombre persona - pi_xadre.Nombre
(
    sigma_(hije.NombreMadre=xadre.Nombre or hije.NombrePadre=xadre.Nombre) 
        (rho_hije (persona) x rho_xadre (persona))
)

--4
π_Nombre(persona) - (π_NombreMujer(matrimonio) U π_NombreVaron(matrimonio))

--5
tupla <- σ_(p1.NombreMadre = p2.Nombre) (rho_p1 (persona) x rho_p2 (persona)) --(persona, madre)
π_p2.nombre (σ_p1.sexo="varon" (tupla)) ⋂ π_p2.nombre (σ_p1.sexo="mujer" (tupla))

--6
pm <- (σ_(Sexo='Femenino' and NombreMadre=NombreMujer ∧ NombrePadre=NombreVaron ∧ (FechaNac < FechaFin ∧ FechaNac > FechaRealizacion)) persona x matrimonio)
pi_(NombreMujer, NombreVaron) matrimonio - pi_(nombreMujer, nombreVaron) pm

--7

mm <- sigma_(m1.fechaRealizacion<m2.fechaRealizacion and m1.NombreMujer=m2.NombreMujer and m1.NombreVaron=m2.NombreVaron) 
    (rho_m1 (matrimonio) x rho_m2 (matrimonio))

cch <-sigma_(nombrePadre=NombreVaron and nombreMadre=NombreMujer and FechaRealizacion<= FechaNac and FechaNac<=FechaFin) ((matrimonio - pi_m2 (mm)) x persona)

pi_nombrePadre(cch) U pi_nombreMadre(cch)

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