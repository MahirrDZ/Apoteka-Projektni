DELIMITER $$
 
CREATE PROCEDURE Transakcija_GrupnaPromjenaStatusa(
    IN t_id_od     INT,
    IN t_id_do     INT,
    IN t_novi_status VARCHAR(20)
)
BEGIN
 
    IF t_id_od > t_id_do THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Greška: id_od ne smije biti veći od id_do.';
    END IF;
 
  
    IF t_novi_status NOT IN ('Zavrseno', 'Otkazano', 'Na cekanju', 'U obradi') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Nevažeći status. Dozvoljeni: Zavrseno, Otkazano, Na cekanju, U obradi.';
    END IF;
 
 
    UPDATE Transakcija
    SET status = t_novi_status
    WHERE transakcija_id BETWEEN t_id_od AND t_id_do;

    SELECT
        t_id_od          AS od_id,
        t_id_do          AS do_id,
        t_novi_status    AS novi_status;
END$$
 
DELIMITER ;

-- call transakcija_grupnapromjenastatusa (10,20,'U obradi');