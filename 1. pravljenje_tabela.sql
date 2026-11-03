CREATE TABLE Kategorija (
    kategorija_id INT AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(100) NOT NULL
);
CREATE TABLE Poslovnica (
    poslovnica_id INT AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(100) NOT NULL,
    adresa VARCHAR(150) NOT NULL,
    grad VARCHAR(100) NOT NULL,
    telefon VARCHAR(30),
	radno_vrijeme ENUM(
		'08:00 - 16:00',
		'07:30 - 21:00',
		'24/7'
	) DEFAULT '08:00 - 16:00'

);

CREATE TABLE Dobavljac (
    dobavljac_id INT AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(100) NOT NULL,
    telefon VARCHAR(30) NOT NULL,
    email VARCHAR(100) 

);

CREATE TABLE Proizvod (
    proizvod_id INT AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(100) NOT NULL,
	proizvodjac VARCHAR(100) NOT NULL,
    cijena DECIMAL(10,2) NOT NULL,
    opis TEXT,

    kategorija_id INT,
    dobavljac_id INT,

    FOREIGN KEY (kategorija_id) REFERENCES Kategorija(kategorija_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    FOREIGN KEY (dobavljac_id) REFERENCES Dobavljac(dobavljac_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE Kupac (
    kupac_id INT AUTO_INCREMENT PRIMARY KEY,
    ime VARCHAR(50) NOT NULL,
    prezime VARCHAR(50) NOT NULL,
    zdravstvena_broj VARCHAR(50) NOT NULL UNIQUE,
    telefon VARCHAR(30)
);

CREATE TABLE Zaposlenik (
    zaposlenik_id INT AUTO_INCREMENT PRIMARY KEY,
    ime VARCHAR(50) NOT NULL,
    prezime VARCHAR(50) NOT NULL,
    plata NUMERIC(10,2)  DEFAULT 1027.00,
    pozicija VARCHAR(50) DEFAULT 'Farmaceutski tehničar',
	telefon VARCHAR(30) NOT NULL,
	email VARCHAR(100) NOT NULL,
    smjena ENUM('Jutarnja', 'Popodnevna', 'Noćna') NOT NULL,
    poslovnica_id INT,
    
    FOREIGN KEY (poslovnica_id) REFERENCES Poslovnica(poslovnica_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
    
);

CREATE TABLE Skladiste (
    skladiste_id INT AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(100) NOT NULL,
    lokacija VARCHAR(150),
    poslovnica_id INT,
    
    FOREIGN KEY (poslovnica_id) REFERENCES Poslovnica(poslovnica_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE Zaliha (
    proizvod_id INT NOT NULL,
    skladiste_id INT NOT NULL,
    kolicina INT NOT NULL DEFAULT 0,
    PRIMARY KEY (proizvod_id, skladiste_id),

    FOREIGN KEY (proizvod_id) REFERENCES Proizvod(proizvod_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (skladiste_id) REFERENCES Skladiste(skladiste_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Transakcija (
    transakcija_id INT AUTO_INCREMENT PRIMARY KEY,
    datum DATETIME DEFAULT CURRENT_TIMESTAMP,
    kupac_id INT,
    zaposlenik_id INT,
    poslovnica_id INT,
    ukupno DECIMAL(10,2) DEFAULT 0,
    status VARCHAR(20) DEFAULT 'Zavrseno',
	
    FOREIGN KEY (kupac_id) REFERENCES Kupac(kupac_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    FOREIGN KEY (zaposlenik_id) REFERENCES Zaposlenik(zaposlenik_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
        
	FOREIGN KEY (poslovnica_id) REFERENCES Poslovnica(poslovnica_id)
		ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE StavkaTransakcije (
    stavka_id INT AUTO_INCREMENT PRIMARY KEY,
    
    transakcija_id INT NOT NULL,
    proizvod_id INT NOT NULL,
    
    kolicina INT NOT NULL,
    cijena DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (transakcija_id) REFERENCES Transakcija(transakcija_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (proizvod_id) REFERENCES Proizvod(proizvod_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Recept (
    recept_id INT AUTO_INCREMENT PRIMARY KEY,
    kupac_id INT,
    proizvod_id INT,
    datum_izdavanja DATE NOT NULL,
    doktor VARCHAR(100) NOT NULL,
    ustanova VARCHAR(100),
    kolicina INT NOT NULL DEFAULT 1,

    FOREIGN KEY (kupac_id) REFERENCES Kupac(kupac_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    FOREIGN KEY (proizvod_id) REFERENCES Proizvod(proizvod_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


CREATE TABLE Nabavka (
    nabavka_id INT AUTO_INCREMENT PRIMARY KEY,
    datum DATETIME DEFAULT CURRENT_TIMESTAMP,
    dobavljac_id INT,

    FOREIGN KEY (dobavljac_id) REFERENCES Dobavljac(dobavljac_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);
CREATE TABLE StavkaNabavke (
    stavka_nabavke_id INT AUTO_INCREMENT PRIMARY KEY,

    nabavka_id INT NOT NULL,
    proizvod_id INT,
    skladiste_id INT,

    kolicina INT NOT NULL,

    FOREIGN KEY (nabavka_id) REFERENCES Nabavka(nabavka_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (proizvod_id) REFERENCES Proizvod(proizvod_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    FOREIGN KEY (skladiste_id) REFERENCES Skladiste(skladiste_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);