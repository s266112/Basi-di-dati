/*Esercizio 5: Qual'è la data piu recente in cui è stat sostenuto l'esame di ciascun professore?*/

use unidb;
SELECT max(e.data), p.nome, p.cognome
FROM professori p
LEFT JOIN corsi c on p.matricola = c.professore
LEFT JOIN esami e on c.codice = e.corso
GROUP BY p.matricola
ORDER BY max(e.data) DESC;
