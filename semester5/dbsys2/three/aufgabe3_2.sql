--2a
select pt.studierender.name
from PruefungsergebnisTab pt where pt.note < 2.0
and pt.vorlesung.name = 'Datenbanksysteme';


--2b
select s.name
from StudierenderTab s
where s.studiengang.fakultaet.dekan.name = 'Langweg';


--2c
select deref(column_value).name as profs
from Table(select f.professoren
            from FakultaetTab f
            where f.name = 'Informatik');