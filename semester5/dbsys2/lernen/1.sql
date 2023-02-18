drop table verkauf_2dc;

CREATE TABLE Verkauf_2DC (
    AGE varchar2(50),
    PRODUKTGRUPPENNAME varchar2(50),
    ANZAHL varchar2(50),
    CONSTRAINT Verkauf_2DC_pk PRIMARY KEY(AGE, PRODUKTGRUPPENNAME, ANZAHL)
);

--kleines cube by beispiel
select p.bezeichnung, k.land from 
Verkauf v, Produkt p, Kunde k where
v.produktid = p.produktid and
v.kundenid = k.kundenid
group by cube(p.bezeichnung, k.land);

select p.bezeichnung, k.land from 
Verkauf v, Produkt p, Kunde k where
v.produktid = p.produktid and
v.kundenid = k.kundenid
group by rollup(p.bezeichnung, k.land);

--1.2
select decode(grouping(k.age), 1, 'alle', k.age) as Altersgruppe, 
       decode(grouping(p.produktgruppenname),1, 'alle', p.produktgruppenname) as Produktgruppenname, 
       sum(v.anzahl) as Summe
from Verkauf v, Kunde k, Produkt p
where v.kundenid = k.kundenid and
v.produktid = p.produktid and
extract (year from v.datum) = 2023
group by cube(k.age, p.produktgruppenname);


insert into verkauf_2dc(
select decode(grouping(k.age), 1, 'alle', k.age) as Altersgruppe, 
       decode(grouping(p.produktgruppenname),1, 'alle', p.produktgruppenname) as Produktgruppenname, 
       sum(v.anzahl) as Summe
from Verkauf v, Kunde k, Produkt p
where v.kundenid = k.kundenid and
v.produktid = p.produktid and
extract (year from v.datum) = 2023
group by cube(k.age, p.produktgruppenname)
);

select * from verkauf;

select * from verkauf_2dc;

--aufgabe 1.3
select * from verkauf_2dc
pivot(
    sum(anzahl)
    for produktgruppenname
    in (
        'Laptop',
        'Smartphone'
        )
);


--aufgabe 1.4
select decode(grouping(v.datum), 1, 'alle', trunc(months_between(sysdate, vk.geburtsdatum) / 12)) as Jahrgang, 
       decode(grouping(v.datum), 1, 'alle', extract(year from v.datum)) as Jahr,
       decode(grouping(p.produktgruppenname), ,
       sum(v.anzahl) as Summe
from Verkauf v, Verkaeufer vk, Produkt p where
v.verkaeuferid = vk.verkaeuferid and
v.produktid = p.produktid
group by rollup(vk.geburtsdatum, v.datum, p.produktgruppenname);


commit;