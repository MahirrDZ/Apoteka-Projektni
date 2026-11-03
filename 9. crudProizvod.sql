DELIMITER $$

CREATE PROCEDURE Proizvod_Create(
    IN p_naziv        VARCHAR(100),
    IN p_proizvodjac  VARCHAR(100),
    IN p_cijena       DECIMAL(10,2),
    IN p_opis         TEXT,
    IN p_kategorija_id INT,
    IN p_dobavljac_id  INT
)
BEGIN
    INSERT INTO Proizvod (naziv, proizvodjac, cijena, opis, kategorija_id, dobavljac_id)
    VALUES (p_naziv, p_proizvodjac, p_cijena, p_opis, p_kategorija_id, p_dobavljac_id);

    SELECT LAST_INSERT_ID() AS novi_proizvod_id;
END$$


CREATE PROCEDURE Proizvod_ReadAll()
BEGIN
    SELECT
        p.proizvod_id,
        p.naziv,
        p.proizvodjac,
        p.cijena,
        p.opis,
        k.naziv AS kategorija,
        d.naziv AS dobavljac
    FROM Proizvod p
    LEFT JOIN Kategorija k ON p.kategorija_id = k.kategorija_id
    LEFT JOIN Dobavljac  d ON p.dobavljac_id  = d.dobavljac_id
    ORDER BY p.proizvod_id;
END$$


CREATE PROCEDURE Proizvod_ReadId(
    IN p_proizvod_id INT
)
BEGIN
    SELECT
        p.proizvod_id,
        p.naziv,
        p.proizvodjac,
        p.cijena,
        p.opis,
        p.kategorija_id,
        k.naziv AS kategorija,
        p.dobavljac_id,
        d.naziv AS dobavljac
    FROM Proizvod p
    LEFT JOIN Kategorija k ON p.kategorija_id = k.kategorija_id
    LEFT JOIN Dobavljac  d ON p.dobavljac_id  = d.dobavljac_id
    WHERE p.proizvod_id = p_proizvod_id;
END$$


CREATE PROCEDURE Proizvod_Update(
    IN p_proizvod_id   INT,
    IN p_naziv         VARCHAR(100),
    IN p_proizvodjac   VARCHAR(100),
    IN p_cijena        DECIMAL(10,2),
    IN p_opis          TEXT,
    IN p_kategorija_id INT,
    IN p_dobavljac_id  INT
)
BEGIN
    UPDATE Proizvod
    SET
        naziv         = p_naziv,
        proizvodjac   = p_proizvodjac,
        cijena        = p_cijena,
        opis          = p_opis,
        kategorija_id = p_kategorija_id,
        dobavljac_id  = p_dobavljac_id
    WHERE proizvod_id = p_proizvod_id;

END$$

CREATE PROCEDURE Proizvod_UpdateCijena(
    IN p_proizvod_id   INT,
    IN p_cijena        DECIMAL(10,2)
)
BEGIN
    UPDATE Proizvod
    SET  
        cijena = p_cijena
    WHERE proizvod_id = p_proizvod_id;

END$$


CREATE PROCEDURE Proizvod_Delete(
    IN p_proizvod_id INT
)
BEGIN
    DELETE FROM Proizvod
    WHERE proizvod_id = p_proizvod_id;

END$$

DELIMITER ;

-- Proizvod
-- CALL Proizvod_Create('Brufen 400mg', 'Abbott', 4.20, 'Protuupalni lijek', 2, 5);
-- CALL Proizvod_ReadAll();
-- CALL Proizvod_ReadId(1);
-- CALL Proizvod_Update(1, 'Brufen 400mg', 'Abbott', 4.50, 'Ažurirani opis', 2, 5);
-- CALL Proizvod_UpdateCijena(1,5.50);
-- CALL Proizvod_Delete(1);