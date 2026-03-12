/*Esercizio 7: Elencare nome, cognome, media ponderata degli studenti di ingegneria */

use unidb;
SELECT  s.nome, s.cognome, sum(e.voto*c.cfu)/sum(c.cfu) as media_ponderata_voti
FROM studenti s
JOIN esami e on s.matricola = e.studente
JOIN corsi c on e.corso = c.codice
WHERE s.matricola LIKE "IN%"
GROUP BY s.matricola