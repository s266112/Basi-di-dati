/*Esercizio 9: Calcolare la distribuzione dei voti per ciascun corso, ordinando per corso e 
per voto (dal 18 al 30L) */

use unidb;
SELECT  c.nome, e.voto, e.lode, count(e.voto)
FROM corsi c
JOIN esami e ON e.corso = c.codice
GROUP BY c.nome, e.voto, e.lode
ORDER BY c.nome, e.voto