--SQL
--a
select distinct Bar 
from sirve, gusta
where sirve.cerveza = gusta.cerveza
and persona = 'Juan';

--b
select distinct persona 
from sirve, gusta, frecuenta
where sirve.cerveza = gusta.cerveza 
and gusta.persona = frecuenta.persona 
and sirve.bar = frecuenta.bar;

--c
select distinct frecuenta.persona
from frecuenta
where bar not in
    (select bar from sirve
    where cerveza not in (select cerveza from gusta where gusta.persona = frecuenta.persona))

--d

select distinct persona
from frecuenta where
where bar not in
    (select bar
    from sirve, gusta
    where sirve.cerveza = gusta.cerveza 
    and gusta.persona = frecuenta.persona);

--e
select distinct sirve.bar
from sirve
where sirve.cerveza='Miller'
and sirve.precio=(select precio from sirve as s where s.bar='HardRock' and s.cerveza='Bud')

--f
select persona
from frecuenta
group by persona
having count(distinct bar) = (select count(distinct bar) from sirve)


--AR
--a
pi_bar sigma_persona='Juan' (sirve |x| gusta)

--b
pi_persona (frecuenta |x| sirve |x| gusta)

--c
pi_persona frecuenta - pi_persona (frecuenta - (pi_persona, bar (sirve |x| gusta)))

--d
pi_persona gusta - pi_persona (frecuenta |x| sirve |x| gusta)

--e
phr <- pi_precio (sigma_bar='Hardrock' and cerveza='Bud' Sirve)
pi_bar (sigma_cerveza='Miller' and precio = phr sirve)

--f
frecuenta / (pi_bar sirve)