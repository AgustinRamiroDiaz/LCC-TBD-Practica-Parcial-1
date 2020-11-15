--1
select * from J;

--2
select * from J 
where Ciudad = 'Londres';

--3
select distinct SID from SPJ
where JID = 1
order by SID;

--4
select * from spj
where 300 <= cant and cant <= 750;

--5
select distinct color, ciudad from p;

--6
select SID, PID, JID from s, p, j
where s.Ciudad = p.Ciudad and p.Ciudad = j.Ciudad; 

--7
select SID, PID, JID from s, p, j
where not (s.Ciudad = p.Ciudad and p.Ciudad = j.Ciudad);

--8
select SID, PID, JID from s, p, j
where s.Ciudad <> p.Ciudad and p.Ciudad <> j.Ciudad and j.Ciudad <> s.Ciudad;

--9
select distinct PID from spj, s
where spj.SID = s.SID
and s.Ciudad = 'Londres';

--10
select p.pid from spj, s, p, j
where p.pid = spj.pid and spj.sid = s.sid and spj.jid = j.jid
and s.Ciudad = 'Londres' and j.Ciudad = 'Londres';

--11
select distinct s.Ciudad, j.Ciudad 
from s, p, j, spj
where p.pid = spj.pid and spj.sid = s.sid and spj.jid = j.jid;


--12
select distinct p.pid
from s, p, j, spj
where p.pid = spj.pid and spj.sid = s.sid and spj.jid = j.jid
and s.Ciudad = j.Ciudad;

--13
select distinct j.jid
from s, p, j, spj
where p.pid = spj.pid and spj.sid = s.sid and spj.jid = j.jid
and s.Ciudad <> j.Ciudad;

--14
select distinct spj1.pid as p1, spj2.pid as p2
from spj as spj1, spj as spj2
where spj1.sid = spj2.sid 
and spj1.pid < spj2.pid;

--15
select count(distinct jid)
from spj
where sid = 1;

--16
select sum(cant) 
from spj
where sid = 1 and pid = 1;

--17
select pid, jid, sum(cant)
from spj
group by pid, jid;

--18
select distinct pid 
from spj
where jid
group by pid, jid
having AVG(cant) > 320;

--19
select * from spj 
where cant is not null;

--20
select jid 
from j
where Ciudad like '_o%';

--21
select JNombre
from j
where jid in
    (select jid from spj where sid = 1);

--22
select distinct Color 
from p
where pid in 
    (select pid from spj where sid = 1); 

--23
select distinct pid from spj where jid in 
    (select jid from j where Ciudad = 'Londres');

--24
select distinct jid 
from spj
where pid in (select pid from spj where sid = 1);

--25
select distinct sid 
from spj
where pid in 
    --partes suministradas por al menos uno de los proveedores que suministran por lo menos una parte roja
    (select pid from spj where sid in 
        --proveedores que suministran por lo menos una parte roja
        (select sid from spj where pid in
            --partes rojas
            (select pid from p where Color = 'Rojo')));

--26
select sid
from s
where Situacion < (select Situacion from s where sid = 1);

--27
select jid
from j
where Ciudad =
    (select min(Ciudad) from j);

--28
select distinct pid
from spj
where exists (select * from j where spj.jid = j.jid and Ciudad = 'Londres');

--29    TODO REVISAR ????????????????
select distinct spjx.jid
from spj as spjx
where exists (select * from spj as spjy where spjx.jid = spjy.jid and sid = 1);

--30
select jid
from j
where not exists 
(
    select * from spj where spj.jid = jid 
    and pid in (select pid from p where color = 'Rojo')
    and sid in (select sid from s where Ciudad = 'Londres')
);