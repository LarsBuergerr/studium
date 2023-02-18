--Aufgabe 1.2
select decode(grouping(k.age),1, 'alle', k.age) as Altersgruppe,
       decode(grouping(p.Produktgruppenname), 1, 'alle', p.Produktgruppenname) as Produktgruppe,
       sum(v.anzahl) as Summe
from Verkauf v,  Kunde k, Produkt p
where v.produktid = p.produktid and v.kundenid = k.kundenid
and  extract(year from v.datum) = '2023'
group by cube(k.age, p.Produktgruppenname);

DROP TABLE VERKAUF_2DC;

CREATE TABLE Verkauf_2DC (
    AGE varchar2(50),
    PRODUKTGRUPPENNAME varchar2(50),
    ANZAHL varchar2(50),
    CONSTRAINT Verkauf_2DC_pk PRIMARY KEY(AGE, PRODUKTGRUPPENNAME, ANZAHL)
);

insert into verkauf_2DC(
select decode(grouping(k.age),1, 'alle', k.age) as Altersgruppe,
       decode(grouping(p.Produktgruppenname), 1, 'alle', p.Produktgruppenname) as Produktgruppe,
       sum(v.anzahl) as Summe
from Verkauf v,  Kunde k, Produkt p
where v.produktid = p.produktid and v.kundenid = k.kundenid
and  extract(year from v.datum) = '2022'
group by cube(k.age, p.Produktgruppenname)
);
--Aufgabe 1.3

select * from verkauf_2DC;
--Eigene Lösung
select * from
    (select age, bezeichnung, anzahl from kunde, produkt, verkauf
    where kunde.kundenid = verkauf.kundenid and produkt.produktid = verkauf.produktid)
pivot(
    sum(anzahl)
    for bezeichnung
    in ('PutinPhone',
        'MerkelPhone',
        'TrumpPhone',
        'JohnsonLaptop',
        'MaechtelMiner')
);

--Ansatz von 1.2
select * from(
    select decode(grouping(k.age),1, 'alle', k.age) as Altersgruppe,
           decode(grouping(p.Produktgruppenname), 1, 'alle', p.Produktgruppenname) as Produktgruppe,
           sum(v.anzahl) as Anzahl
        from Verkauf v,  Kunde k, Produkt p
    where v.produktid = p.produktid and v.kundenid = k.kundenid
    and  extract(year from v.datum) = '2022'
    group by cube(k.age, p.Produktgruppenname))
pivot(
    sum(anzahl)
    for Produktgruppe
    in ('Smartphone',
        'Miner',
        'Laptop')
);

--Aufgabe 1.4
select decode(grouping(vk.geburtsdatum),1,'all', trunc(months_between(current_date, vk.geburtsdatum) / 12)) as age,
       decode(grouping(v.datum), 1, 'all', extract(year from v.datum)) as year, 
       decode(grouping(p.produktgruppenname), 1, 'all', p.produktgruppenname) as produktname, 
       sum(p.preis * v.anzahl) as summe
from verkauf v, verkaeufer vk, produkt p
where v.verkaeuferid = vk.verkaeuferid and v.produktid = p.produktid
group by rollup(vk.geburtsdatum, v.datum, p.produktgruppenname)
order by summe desc, age asc;


--Aufgabe 1.4
SELECT 
    DECODE(grouping(vk.geburtsdatum), 1, 'all', TRUNC(months_between(sysdate,vk.Geburtsdatum) / 12)) as AGE, 
    DECODE(grouping(v.datum), 1, 'all', EXTRACT(YEAR FROM v.DATUM)) as VERKAUFSJAHR,
    DECODE(grouping(p.Produktgruppenname), 1, 'all', p.Produktgruppenname) as PRODUKTGRUPPENNAME,
    SUM(p.Preis * v.Anzahl) as UMSATZ
FROM 
    Verkaeufer vk, Verkauf v, Produkt p
WHERE
    v.Verkaeuferid = vk.Verkaeuferid
AND v.Produktid = p.Produktid
GROUP BY ROLLUP(vk.Geburtsdatum, p.Produktgruppenname, v.Datum)
ORDER BY UMSATZ DESC, AGE ASC;

commit;



