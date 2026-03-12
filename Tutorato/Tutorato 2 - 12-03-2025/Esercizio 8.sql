/*Esercizio 8: Per ciascun corso, quanti studenti di ingegneria hanno sostenuto l'esame in ciascun anno solare?
Quale è stato il voto massimo? Quante lodi? Elencare in ordine crescente di corso e anno */

use unidb;
SELECT  c.nome AS nome, year(e.data) AS anno, 
		count(e.corso) AS n_esami, 
		max(e.voto) AS voto_max, 
        sum(e.lode) AS n_lodi 
FROM corsi c
JOIN esami e on c.codice = e.corso
JOIN studenti s on e.studente = s.matricola
WHERE s.matricola LIKE "IN%"
GROUP BY c.nome, anno
ORDER BY c.nome, anno
