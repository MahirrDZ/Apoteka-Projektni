DELIMITER $$
 
CREATE TRIGGER StavkaNabavke_PoslijeUnosa
AFTER INSERT ON StavkaNabavke
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1 FROM Zaliha
        WHERE proizvod_id  = NEW.proizvod_id
          AND skladiste_id = NEW.skladiste_id
    ) THEN
        UPDATE Zaliha
        SET kolicina = kolicina + NEW.kolicina
        WHERE proizvod_id  = NEW.proizvod_id
          AND skladiste_id = NEW.skladiste_id;
    ELSE
        INSERT INTO Zaliha (proizvod_id, skladiste_id, kolicina)
        VALUES (NEW.proizvod_id, NEW.skladiste_id, NEW.kolicina);
    END IF;
END$$
 
DELIMITER ;

-- INSERT INTO StavkaNabavke (nabavka_id, proizvod_id, skladiste_id, kolicina) VALUES(1, 34, 8, 150)