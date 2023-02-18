drop table pers;
drop table abt;

/* DDL fuer Oracle */

CREATE TABLE abt
( anr               char(3) PRIMARY KEY,
  aname             varchar2(20) NOT NULL,
  ort               varchar2(20) NOT NULL );

CREATE TABLE pers
( pnr               integer NOT NULL,
  name              varchar2(20) NOT NULL,
  jahrg             integer,
  eindat            date,
  gehalt            integer NOT NULL,
  beruf             varchar2(20),
  anr               char(3) NOT NULL,
  vnr               integer,
  CONSTRAINT pers_pk PRIMARY KEY(pnr),
  CONSTRAINT pers_fk1 FOREIGN KEY (anr) REFERENCES abt(anr),
  CONSTRAINT pers_fk2 FOREIGN KEY (vnr) REFERENCES pers(pnr),
  CONSTRAINT persGehalt CHECK (gehalt > 0),
  CONSTRAINT persjahrgang CHECK (jahrg > 1900 AND jahrg < 2100)
);


/* DML */

INSERT INTO abt(anr, aname, ort) VALUES ('K51', 'Entwicklung', 'Erlangen');
INSERT INTO abt(anr, aname, ort) VALUES ('K53', 'Buchhaltung', 'Nuernberg');
INSERT INTO abt(anr, aname, ort) VALUES ('K55', 'Personal',    'Nuernberg');

INSERT INTO pers VALUES
(123, 'Mueller', 1958, TO_DATE('01.09.1980', 'DD.MM.YYYY'), 68000, 'Programmierer', 'K51', NULL );

INSERT INTO pers VALUES
(406, 'Coy', 1950, TO_DATE('01.03.1986', 'DD.MM.YYYY'), 80000, 'Kaufmann', 'K55', 123);

INSERT INTO pers VALUES
(829, 'Schmidt', 1960, TO_DATE('01.06.1990', 'DD.MM.YYYY'), 74000, 'Kaufmann', 'K53', 123);

INSERT INTO pers VALUES
(874, 'Abel', NULL, TO_DATE('01.05.1994', 'DD.MM.YYYY'), 62000, 'Software Entwickler', 'K55', 829); 

INSERT INTO pers VALUES
(503, 'Junghans', 1975, NULL, 55000, 'Programmierer', 'K51', 123);

INSERT INTO pers VALUES
(569, 'Junghans', 1975, NULL, 55000, 'Programmierer', 'K51', 123);

commit;

--a) 
--unperformant
SELECT COUNT(DISTINCT pnr)
FROM Pers p
WHERE NOT EXISTS
    (SELECT * FROM pers p2
     WHERE p.anr = p2.anr AND p.pnr != p2.pnr);
     
--speedy gonzales
select p.name
from pers p
left join pers p2 on p.anr = p2.anr
and p.pnr != p2.pnr
where p2.pnr is null;


--b)
--unperformant
select a.aname
from abt a
where not exists
    (select * from pers p
     where p.anr = a.anr
     and beruf = 'Programmierer');
     

--speedy gonzales
select a.aname
from abt a
left join pers p on p.anr = a.anr
    and p.beruf = 'Programmierer'
    where p.pnr is null;


--c)
--unperformant
SELECT COUNT(DISTINCT p.pnr)
FROM pers p
    WHERE p.gehalt > (SELECT AVG(gehalt)
    FROM pers WHERE beruf = 'Programmierer');

--speedy gonzales
select count(p.pnr)
FROM pers p
    WHERE p.gehalt > (SELECT AVG(gehalt)
    FROM pers WHERE beruf = 'Programmierer');
    

--d)
--unperformant
SELECT Name
FROM Pers p1
WHERE p1.jahrg < (SELECT p2.jahrg FROM pers p2
    WHERE p2.pnr = p1.vnr);
    
    
--speedy gonzales
select p1.name
from pers p1, pers p2
where p2.pnr = p1.vnr 
and p1.jahrg < p2.jahrg;



--e)
--unperformant
SELECT DISTINCT name
FROM Pers
WHERE name != 'Junghans'
AND beruf = ANY(SELECT beruf FROM Pers
    WHERE name = 'Junghans')
AND anr = ANY(SELECT anr FROM Pers
    WHERE name = 'Junghans');
    
--speedy gonzales
select distinct p1.name
from pers p1, pers p2
where p1.name != 'Junghans' and p2.name = 'Junghans'
and p1.beruf = p2.beruf
and p1.anr = p2.anr;


--f)
--unperformant
SELECT DISTINCT name
FROM Pers p1
WHERE NOT EXISTS (SELECT * FROM Pers p2
    WHERE p1.name = p2.name
    AND p1.pnr != p2.pnr);
    

--speedy gonzales
select distinct p1.name
from pers p1
left join pers p2 on p1.pnr != p2.pnr
and p1.name = p2.name
where p2.pnr is null;


--g)
--unperformant
select p1.name
from pers p1
left join pers p2 on p1.pnr != p2.pnr
and p1.name = p2.name 
where
p2.pnr is null;

--unperformant
SELECT DISTINCT p.name
FROM Pers p
WHERE EXISTS (SELECT * FROM Abt a
    WHERE p.name = a.aname);
    
    
--speedy gonzales
select p.name
from pers p
left join abt a on p.name != a.aname
where a.aname is null;