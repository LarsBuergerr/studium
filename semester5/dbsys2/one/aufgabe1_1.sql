--Dimensionstabelle

DROP TABLE Produkt;
DROP TABLE Kunde;
DROP TABLE Verkaeufer;
DROP TABLE Filiale;
DROP TABLE Verkauf;


CREATE TABLE Produkt( 
    preis Integer, 
    bezeichnung varchar2(50), 
    herstellerland varchar2(50), 
    herstellername varchar2(50), 
    produktgruppenname varchar2(50),
    produktid Integer NOT NULL,
    CONSTRAINT produkt_pk PRIMARY KEY (produktid)
);

CREATE TABLE Kunde( 
    age Integer, 
    land varchar2(50),
    kundenid Integer NOT NULL,
    CONSTRAINT kunde_pk PRIMARY KEY (kundenid)
);

CREATE TABLE Filiale( 
    filialleiter varchar2(50), 
    stadtname varchar2(50), 
    bezirkname varchar2(50), 
    landname varchar2(50),
    filialid Integer NOT NULL,
    CONSTRAINT filiale_id PRIMARY KEY (filialid)
);

CREATE TABLE Verkaeufer( 
    name varchar2(50), 
    geburtsdatum Date, 
    fachgebiet varchar2(50),
    verkaeuferid Integer NOT NULL,
    CONSTRAINT verkaeufer_id PRIMARY KEY (verkaeuferid)
);

--Faktentabelle
CREATE TABLE Verkauf(
    rechnungsid Integer NOT NULL,
    anzahl Integer, 
    datum Date,
    produktid Integer, 
    kundenid Integer,
    filialid Integer,
    verkaeuferid Integer,
    CONSTRAINT verkauf_pid_fk FOREIGN KEY(produktid) REFERENCES Produkt(produktid),
    CONSTRAINT verkauf_kid_fk FOREIGN KEY(kundenid) REFERENCES Kunde(kundenid),
    CONSTRAINT verkauf_fid_fk FOREIGN KEY(filialid) REFERENCES Filiale(filialid),
    CONSTRAINT verkauf_vid_fk FOREIGN KEY(verkaeuferid) REFERENCES Verkaeufer(verkaeuferid),
    CONSTRAINT verkauf_pk PRIMARY KEY(rechnungsid)
);

INSERT INTO Produkt VALUES(10, 'PutinPhone', 'Russland', 'SmartPutin', 'Smartphone', 0);
INSERT INTO Produkt VALUES(20, 'TrumpPhone', 'Vereinigte Staaten von Amerika', 'SmartTrump', 'Smartphone', 1);
INSERT INTO Produkt VALUES(30, 'MerkelPhone', 'Deutschland', 'SmartMerkel', 'Smartphone', 2);
INSERT INTO Produkt VALUES(40, 'JohnsonLaptop', 'Vereinigtes Koenigreich', 'PartyJohnson', 'Laptop', 3);
INSERT INTO Produkt VALUES(50, 'MaechtelMiner', 'Deutschland', 'BitcoinMaechtel', 'Miner', 4);

--Kunden
INSERT INTO Kunde VALUES(2, 'China', 0);
INSERT INTO Kunde VALUES(187, 'Taiwan', 1);
INSERT INTO Kunde VALUES(69, 'Ukraine', 2);

--Filiale
INSERT INTO Filiale VALUES('OskarSpastenhagen', 'Konstanz', 'Fuerstenberg', 'Deutschland', 0);
INSERT INTO Filiale VALUES('NadineSnitcherhagen', 'Bielefeld', 'GibtsNicht', 'Deutschland', 1);
INSERT INTO Filiale VALUES('OskekBorkenlagen', 'Spastenhausen', 'Idiotenviertel', 'Legoland', 2);

--Verkaeufer
INSERT INTO Verkaeufer VALUES ('Oskek',  CURRENT_DATE, 'HatErNicht', 0);
INSERT INTO Verkaeufer VALUES ('Borkek', CURRENT_DATE, 'SameAsOskek', 1);
INSERT INTO Verkaeufer VALUES ('Bence',  TO_DATE( '30-08-2001', 'DD-MM-YYYY' ), 'Laptops', 2);
INSERT INTO Verkaeufer VALUES ('Michi', TO_DATE( '01-02-1999', 'DD-MM-YYYY' ), 'Miner', 3);

--Verkaeufe
INSERT INTO Verkauf VALUES (0, 1, CURRENT_DATE, 0, 0, 0, 0);
INSERT INTO Verkauf VALUES (1, 2, CURRENT_DATE, 1, 1, 1, 0);
INSERT INTO Verkauf VALUES (2, 3, CURRENT_DATE, 2, 2, 2, 1);
INSERT INTO Verkauf VALUES (3, 4, CURRENT_DATE, 3, 0, 0, 1);
INSERT INTO Verkauf VALUES (4, 5, CURRENT_DATE, 3, 1, 1, 1);
INSERT INTO Verkauf VALUES (5, 6, CURRENT_DATE, 0, 0, 0, 2);
INSERT INTO Verkauf VALUES (6, 7, CURRENT_DATE, 1, 1, 1, 2);
INSERT INTO Verkauf VALUES (7, 8, CURRENT_DATE, 2, 2, 2, 2);
INSERT INTO Verkauf VALUES (8, 9, CURRENT_DATE, 3, 0, 0, 3);
INSERT INTO Verkauf VALUES (9, 10, CURRENT_DATE, 3, 1, 1, 3);
INSERT INTO Verkauf VALUES (10, 4, CURRENT_DATE, 3, 0, 0, 3);

