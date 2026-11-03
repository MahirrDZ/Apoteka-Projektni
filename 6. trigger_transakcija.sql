DELIMITER $$

CREATE TRIGGER StavkaTransakcije_PoslijeUnosa
AFTER INSERT ON StavkaTransakcije
FOR EACH ROW
BEGIN
  
    IF (
        SELECT z.kolicina FROM Zaliha z
        JOIN Skladiste s ON z.skladiste_id = s.skladiste_id
        JOIN Transakcija t ON s.poslovnica_id = t.poslovnica_id
        WHERE t.transakcija_id = NEW.transakcija_id
          AND z.proizvod_id = NEW.proizvod_id
        LIMIT 1
    ) < NEW.kolicina THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Greška: Nema dovoljno proizvoda na zalihi.';
    END IF;

    UPDATE Zaliha
    SET kolicina = kolicina - NEW.kolicina
    WHERE proizvod_id = NEW.proizvod_id
      AND skladiste_id = (
          SELECT * FROM (
              SELECT s.skladiste_id FROM Skladiste s
              JOIN Transakcija t ON s.poslovnica_id = t.poslovnica_id
              WHERE t.transakcija_id = NEW.transakcija_id
              LIMIT 1
          ) AS tmp
      );
END$$

DELIMITER ;
-- INSERT INTO StavkaTransakcije (transakcija_id, proizvod_id, kolicina, cijena) VALUES(73, 59, 12, 8.40);