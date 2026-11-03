DELIMITER $$

CREATE PROCEDURE Kupac_Create(
    IN p_ime               VARCHAR(50),
    IN p_prezime           VARCHAR(50),
    IN p_zdravstvena_broj  VARCHAR(50),
    IN p_telefon           VARCHAR(30)
)
BEGIN
    
        INSERT INTO Kupac (ime, prezime, zdravstvena_broj, telefon)
        VALUES (p_ime, p_prezime, p_zdravstvena_broj, p_telefon);
        SELECT LAST_INSERT_ID() AS novi_kupac_id;

END$$


CREATE PROCEDURE Kupac_ReadAll()
BEGIN
    SELECT kupac_id, ime, prezime, zdravstvena_broj, telefon
    FROM Kupac
    ORDER BY prezime, ime;
END$$


CREATE PROCEDURE Kupac_ReadById(
    IN p_kupac_id INT
)
BEGIN
    SELECT kupac_id, ime, prezime, zdravstvena_broj, telefon
    FROM Kupac
    WHERE kupac_id = p_kupac_id;
END$$


CREATE PROCEDURE Kupac_Update(
    IN p_kupac_id          INT,
    IN p_ime               VARCHAR(50),
    IN p_prezime           VARCHAR(50),
    IN p_zdravstvena_broj  VARCHAR(50),
    IN p_telefon           VARCHAR(30)
)
BEGIN
   
        UPDATE Kupac
        SET
            ime              = p_ime,
            prezime          = p_prezime,
            zdravstvena_broj = p_zdravstvena_broj,
            telefon          = p_telefon
        WHERE kupac_id = p_kupac_id;

  
END$$

CREATE PROCEDURE Kupac_UpdateTelefon(
    IN p_kupac_id          INT,
    IN p_telefon           VARCHAR(30)
)
BEGIN
   
        UPDATE Kupac
        SET telefon= p_telefon
        WHERE kupac_id = p_kupac_id;

  
END$$


CREATE PROCEDURE Kupac_Delete(
    IN p_kupac_id INT
)
BEGIN
    DELETE FROM Kupac
    WHERE kupac_id = p_kupac_id;

END$$

DELIMITER ;

-- Kupac
-- CALL Kupac_Create('Amira', 'Hodžić', 'ZK-999999', '061-111-222');
-- CALL Kupac_ReadAll();
-- CALL Kupac_ReadById(1);
-- CALL Kupac_Update(1, 'Amira', 'Hodžić', 'ZK-992999', '061-111-333');
-- CALL Kupac_UpdateTelefon(1,'061-111-444');
-- CALL Kupac_Delete(1);
