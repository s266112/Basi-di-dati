/*Esercizio 6: Elencare nome, cognome, media aritmetica degli studenti di ingegneria */

use unidb;
SELECT  s.nome, s.cognome, avg(e.voto) as media_voti
FROM studenti s
JOIN esami e on s.matricola = e.studente
WHERE s.matricola LIKE "IN%"
GROUP BY s.matricola
