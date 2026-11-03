DELIMITER $$

CREATE PROCEDURE Poslovnica_Create(
    IN p_naziv          VARCHAR(100),
    IN p_adresa         VARCHAR(150),
    IN p_grad           VARCHAR(100),
    IN p_telefon        VARCHAR(30),
    IN p_radno_vrijeme  ENUM('08:00 - 16:00', '07:30 - 21:00', '24/7')
)
BEGIN
    INSERT INTO Poslovnica (naziv, adresa, grad, telefon, radno_vrijeme)
    VALUES (p_naziv, p_adresa, p_grad, p_telefon, p_radno_vrijeme);

    SELECT LAST_INSERT_ID() AS nova_poslovnica_id;
END$$


CREATE PROCEDURE Poslovnica_ReadAll()
BEGIN
    SELECT poslovnica_id, naziv, adresa, grad, telefon, radno_vrijeme
    FROM Poslovnica
    ORDER BY grad, naziv;
END$$

CREATE PROCEDURE Poslovnica_ReadById(
    IN p_poslovnica_id INT
)
BEGIN
    SELECT poslovnica_id, naziv, adresa, grad, telefon, radno_vrijeme
    FROM Poslovnica
    WHERE poslovnica_id = p_poslovnica_id;
END$$


CREATE PROCEDURE Poslovnica_Update(
    IN p_poslovnica_id  INT,
    IN p_naziv          VARCHAR(100),
    IN p_adresa         VARCHAR(150),
    IN p_grad           VARCHAR(100),
    IN p_telefon        VARCHAR(30),
    IN p_radno_vrijeme  ENUM('08:00 - 16:00', '07:30 - 21:00', '24/7')
)
BEGIN
    UPDATE Poslovnica
    SET
        naziv         = p_naziv,
        adresa        = p_adresa,
        grad          = p_grad,
        telefon       = p_telefon,
        radno_vrijeme = p_radno_vrijeme
    WHERE poslovnica_id = p_poslovnica_id;

   
END$$

CREATE PROCEDURE Poslovnica_UpdateRadnoVrijeme(
    IN p_poslovnica_id  INT,
    IN p_radno_vrijeme  ENUM('08:00 - 16:00', '07:30 - 21:00', '24/7')
)
BEGIN
    UPDATE Poslovnica
    SET
        radno_vrijeme = p_radno_vrijeme
    WHERE poslovnica_id = p_poslovnica_id;

   
END$$

CREATE PROCEDURE Poslovnica_Delete(
    IN p_poslovnica_id INT
)
BEGIN
    DELETE FROM Poslovnica
    WHERE poslovnica_id = p_poslovnica_id;

END$$

DELIMITER ;

-- Poslovnica
-- CALL Poslovnica_Create('Apoteka Novo Sarajevo', 'Zmaja od Bosne 1', 'Sarajevo', '033-500-100', '07:30 - 21:00');
-- CALL Poslovnica_ReadAll();
-- CALL Poslovnica_ReadById(1);
-- CALL Poslovnica_Update(1, 'Apoteka Centar', 'Titova 12', 'Sarajevo', '033-500-101', '07:30 - 21:00');
-- CALL Poslovnica_UpdateRadnoVrijeme(1,'24/7');
    -- CALL Poslovnica_Delete(1);
