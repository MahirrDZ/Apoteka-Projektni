CREATE VIEW Top10Proizvoda AS
SELECT
    p.proizvod_id,
    p.naziv,
    SUM(st.kolicina) AS ukupno_prodano,
    SUM(st.kolicina * st.cijena) AS ukupan_prihod
FROM StavkaTransakcije st
JOIN Proizvod    p ON st.proizvod_id   = p.proizvod_id
JOIN Transakcija t ON st.transakcija_id = t.transakcija_id
WHERE
    t.datum  >= NOW() - INTERVAL 30 DAY
    AND t.status = 'Zavrseno'
GROUP BY
    p.proizvod_id, p.naziv
ORDER BY
    ukupno_prodano DESC
LIMIT 10;

-- SELECT * FROM Top10Proizvoda