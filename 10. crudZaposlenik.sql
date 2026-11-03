DELIMITER $$


CREATE PROCEDURE Zaposlenik_Create(
    IN p_ime           VARCHAR(50),
    IN p_prezime       VARCHAR(50),
    IN p_plata         NUMERIC(10,2),
    IN p_pozicija      VARCHAR(50),
    IN p_telefon       VARCHAR(30),
    IN p_email         VARCHAR(100),
    IN p_smjena        ENUM('Jutarnja', 'Popodnevna', 'Noćna'),
    IN p_poslovnica_id INT
)
BEGIN
    INSERT INTO Zaposlenik (ime, prezime, plata, pozicija, telefon, email, smjena, poslovnica_id)
    VALUES (p_ime, p_prezime, p_plata, p_pozicija, p_telefon, p_email, p_smjena, p_poslovnica_id);

    SELECT LAST_INSERT_ID() AS novi_zaposlenik_id;
END$$

CREATE PROCEDURE Zaposlenik_ReadAll()
BEGIN
    SELECT
        z.zaposlenik_id,
        z.ime,
        z.prezime,
        z.pozicija,
        z.plata,
        z.smjena,
        z.telefon,
        z.email,
        z.poslovnica_id,
        p.naziv AS poslovnica
    FROM Zaposlenik z
    LEFT JOIN Poslovnica p ON z.poslovnica_id = p.poslovnica_id
    ORDER BY z.prezime, z.ime;
END$$


CREATE PROCEDURE Zaposlenik_ReadById(
    IN p_zaposlenik_id INT
)
BEGIN
    SELECT
        z.zaposlenik_id,
        z.ime,
        z.prezime,
        z.pozicija,
        z.plata,
        z.smjena,
        z.telefon,
        z.email,
        z.poslovnica_id,
        p.naziv AS poslovnica
    FROM Zaposlenik z
    LEFT JOIN Poslovnica p ON z.poslovnica_id = p.poslovnica_id
    WHERE z.zaposlenik_id = p_zaposlenik_id;
END$$


CREATE PROCEDURE Zaposlenik_Update(
    IN p_zaposlenik_id INT,
    IN p_ime           VARCHAR(50),
    IN p_prezime       VARCHAR(50),
    IN p_plata         NUMERIC(10,2),
    IN p_pozicija      VARCHAR(50),
    IN p_telefon       VARCHAR(30),
    IN p_email         VARCHAR(100),
    IN p_smjena        ENUM('Jutarnja', 'Popodnevna', 'Noćna'),
    IN p_poslovnica_id INT
)
BEGIN
    UPDATE Zaposlenik
    SET
        ime           = p_ime,
        prezime       = p_prezime,
        plata         = p_plata,
        pozicija      = p_pozicija,
        telefon       = p_telefon,
        email         = p_email,
        smjena        = p_smjena,
        poslovnica_id = p_poslovnica_id
    WHERE zaposlenik_id = p_zaposlenik_id;
END$$

CREATE PROCEDURE Zaposlenik_UpdateTelefon(
    IN p_zaposlenik_id INT,
    IN p_telefon       VARCHAR(30)
)
BEGIN
    UPDATE Zaposlenik
    SET
        telefon= p_telefon
    WHERE zaposlenik_id = p_zaposlenik_id;
END$$

CREATE PROCEDURE Zaposlenik_UpdatePlata(
    IN p_zaposlenik_id INT,
    in p_plata NUMERIC(10,2)
)
BEGIN
    UPDATE Zaposlenik
    SET
        plata = p_plata
    WHERE zaposlenik_id = p_zaposlenik_id;
END$$


CREATE PROCEDURE Zaposlenik_UpdateSmjena(
    IN p_zaposlenik_id INT,
    IN p_smjena ENUM('Jutarnja', 'Popodnevna', 'Noćna')
)
BEGIN
    UPDATE Zaposlenik
    SET 
        smjena = p_smjena
    WHERE zaposlenik_id = p_zaposlenik_id;
END$$


CREATE PROCEDURE Zaposlenik_Delete(
    IN p_zaposlenik_id INT
)
BEGIN
    DELETE FROM Zaposlenik
    WHERE zaposlenik_id = p_zaposlenik_id;


END$$


DELIMITER ;

-- Zaposlenik
-- CALL Zaposlenik_Create('Emir', 'Kovač', 1600.00, 'Farmaceutski tehničar', '061-300-001', 'emir.k@apoteka.ba', 'Jutarnja', 1);
-- CALL Zaposlenik_ReadAll();
-- CALL Zaposlenik_ReadById(1);
-- CALL Zaposlenik_Update(1, 'Emir', 'Kovač', 1700.00, 'Farmaceutski tehničar', '061-300-001', 'emir.k@apoteka.ba', 'Popodnevna', 2);
-- CALL Zaposlenik_UpdatePlata(1,1000);
-- CALL Zaposlenik_UpdateSmjena(1,'Noćna');
-- CALL Zaposlenik_UpdateTelefon(1,'062-100-200');
-- CALL Zaposlenik_Delete(1);
