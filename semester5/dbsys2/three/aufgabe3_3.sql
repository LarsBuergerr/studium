--3

select s.matrikelnummer, s.name, s.getNotenschnitt() as Notenschnitt
from StudierenderTab s;

select p.studierender.name, p.note from PruefungsergebnisTab p;

select * from StudierenderTab;