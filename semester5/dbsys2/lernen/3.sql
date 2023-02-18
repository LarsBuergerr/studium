select s.name from StudierenderTab s where
s.studiengang.fakultaet.dekan.name = 'Langweg';


select deref(column_value).name
from FakultaetTab f, Table(f.professoren)
where f.name = 'Informatik';


select f.professoren from FakultaetTab f;