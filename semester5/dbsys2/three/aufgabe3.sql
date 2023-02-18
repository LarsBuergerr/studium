CREATE OR REPLACE TYPE PersonT AS OBJECT
(name VARCHAR2(40)) NOT FINAL;
/
CREATE OR REPLACE TYPE ProfessorT UNDER PersonT
(fachgebiet VARCHAR2(40),
buero CHAR(4)) FINAL;
/
CREATE OR REPLACE TYPE ProfessorenVA AS VARRAY(50) OF REF ProfessorT;
/
CREATE OR REPLACE TYPE FakultaetT AS OBJECT
(name VARCHAR2(20),
 dekan REF ProfessorT,
 professoren ProfessorenVA) FINAL;
/
CREATE OR REPLACE TYPE StudiengangT AS OBJECT
(name VARCHAR2(40),
fakultaet REF FakultaetT) FINAL;
/
CREATE OR REPLACE TYPE StudierenderT UNDER PersonT
(matrikelnummer VARCHAR(6),
 studiengang REF StudiengangT,
 MEMBER FUNCTION getNotenschnitt RETURN FLOAT) FINAL;
/

CREATE OR REPLACE TYPE BODY StudierenderT as
MEMBER FUNCTION getNotenschnitt RETURN FLOAT is
g FLOAT;
BEGIN
    select avg(p.note) into g 
    from PruefungsergebnisTab p
    where p.studierender.name = name;
    return round(g, 2);
    END;
END;
/
    

CREATE OR REPLACE TYPE VorlesungT AS OBJECT
(name VARCHAR2(40),
professor REF ProfessorT) FINAL;
/
DROP TABLE ProfessorTab;
DROP TABLE FakultaetTab;
DROP TABLE StudiengangTab;
DROP TABLE StudierenderTab;
DROP TABLE VorlesungTab;
DROP TABLE PRUEFUNGSERGEBNISTAB;

CREATE TABLE ProfessorTab OF ProfessorT;

CREATE TABLE FakultaetTab OF FakultaetT
(dekan SCOPE IS ProfessorTab);

CREATE TABLE StudiengangTab OF StudiengangT
(fakultaet SCOPE IS FakultaetTab);

CREATE TABLE StudierenderTab OF StudierenderT
(studiengang SCOPE IS StudiengangTab);

CREATE TABLE VorlesungTab OF VorlesungT
(professor SCOPE IS ProfessorTab);




-- number 1
--a
CREATE OR REPLACE TYPE PruefungsergebnisT AS OBJECT
(pruefungsdatum DATE,
 vorlesung REF VorlesungT,
 studierender REF StudierenderT,
 note float) FINAL;
 /
 --b
 DROP TABLE PruefungsergebnisTab;
 CREATE TABLE PruefungsergebnisTab OF PruefungsergebnisT
 (studierender SCOPE IS StudierenderTab,
  vorlesung SCOPE IS VorlesungTab,
  CONSTRAINT check_grade CHECK(note IN (1.0, 1.3, 1.7, 2.0, 2.3, 2.7, 3.0, 3.3, 3.7, 4.0))
  );
--c 
-----------------------------------------------Professoren
INSERT INTO ProfessorTab VALUES(
  'Eck',
  'DatenbankBoss',
  'O102');
  
INSERT INTO ProfessorTab VALUES(
  'Langweg',
  'ITSecurity',
  'O187');

INSERT INTO ProfessorTab VALUES(
  'Axthelm',
  'Mathematik',
  'O111');
  
INSERT INTO ProfessorTab VALUES(
  'Staehle',
  'TheoretischeInformatik',
  'O001');
-----------------------------------------------Fakult�ten
INSERT INTO FakultaetTab VALUES(
  'Informatik',
  (SELECT REF(p) FROM ProfessorTab p WHERE name = 'Langweg'),
  ProfessorenVA((SELECT REF(p) FROM ProfessorTab p where name = 'Eck'), (SELECT REF(p) FROM ProfessorTab p where name = 'Langweg'))
);

    
INSERT INTO FakultaetTab VALUES(
  'Mathematik',
  (SELECT REF(p) FROM ProfessorTab p WHERE name = 'Axthelm'),
  ProfessorenVA((SELECT REF(p) FROM ProfessorTab p where name = 'Axthelm'), (SELECT REF(p) FROM ProfessorTab p where name = 'Staehle'))
);


-----------------------------------------------Vorlesungen     
INSERT INTO VorlesungTab VALUES(
    'Datenbanksysteme',
    (SELECT REF(p) FROM ProfessorTab p WHERE name = 'Eck'));

INSERT INTO VorlesungTab VALUES(
    'ITSecurity',
    (SELECT REF(p) FROM ProfessorTab p WHERE name = 'Langweg'));

INSERT INTO VorlesungTab VALUES(
    'Mathe2',
    (SELECT REF(p) FROM ProfessorTab p WHERE name = 'Axthelm'));

-----------------------------------------------Studiengang
INSERT INTO StudiengangTab VALUES(
    'AIN',
    (SELECT REF(f) FROM FakultaetTab f WHERE name = 'Informatik'));

    
INSERT INTO StudiengangTab VALUES(
    'MATHE',
    (SELECT REF(f) FROM FakultaetTab f WHERE name = 'Mathematik'));


-----------------------------------------------Studierende
INSERT INTO StudierenderTab VALUES(
    'Stuhlmann',
    '301810',
    (SELECT REF(sg) FROM StudiengangTab sg WHERE name = 'AIN'));

INSERT INTO StudierenderTab VALUES(
    'BliBLaBLub',
    '123456',
    (SELECT REF(sg) FROM StudiengangTab sg WHERE name = 'MATHE'));


-----------------------------------------------Pruefungsergebnisse
INSERT INTO PruefungsergebnisTab VALUES(
    TO_DATE('10-05-2001', 'DD-MM-YYYY'),
    (SELECT REF(v) FROM VorlesungTab v WHERE name = 'Datenbanksysteme'),
    (SELECT REF(s) FROM StudierenderTab s WHERE matrikelnummer = '301810'),
    1.3);

INSERT INTO PruefungsergebnisTab VALUES(
    TO_DATE('10-05-2001', 'DD-MM-YYYY'),
    (SELECT REF(v) FROM VorlesungTab v WHERE name = 'Datenbanksysteme'),
    (SELECT REF(s) FROM StudierenderTab s WHERE matrikelnummer = '123456'),
    3);
    
INSERT INTO PruefungsergebnisTab VALUES(
    TO_DATE('15-05-2001', 'DD-MM-YYYY'),
    (SELECT REF(v) FROM VorlesungTab v WHERE name = 'Mathe2'),
    (SELECT REF(s) FROM StudierenderTab s WHERE matrikelnummer = '123456'),
    3.7);

INSERT INTO PruefungsergebnisTab VALUES(
    TO_DATE('15-05-2001', 'DD-MM-YYYY'),
    (SELECT REF(v) FROM VorlesungTab v WHERE name = 'Mathe2'),
    (SELECT REF(s) FROM StudierenderTab s WHERE matrikelnummer = '301810'),
    2.7);
    
INSERT INTO PruefungsergebnisTab VALUES(
    TO_DATE('15-10-2001', 'DD-MM-YYYY'),
    (SELECT REF(v) FROM VorlesungTab v WHERE name = 'Mathe2'),
    (SELECT REF(s) FROM StudierenderTab s WHERE matrikelnummer = '123456'),
    1.0);

INSERT INTO PruefungsergebnisTab VALUES(
    TO_DATE('15-10-2001', 'DD-MM-YYYY'),
    (SELECT REF(v) FROM VorlesungTab v WHERE name = 'Mathe2'),
    (SELECT REF(s) FROM StudierenderTab s WHERE matrikelnummer = '301810'),
    1.7);


