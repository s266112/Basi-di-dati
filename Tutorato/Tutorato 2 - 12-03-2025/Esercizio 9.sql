/*Esercizio 9: Distribuzione dei voti, e raggrupparli per 30 e loded */

use unidb;
SELECT  c.nome, e.voto, e.lode, count(e.voto)
FROM corsi c
JOIN esami e ON e.corso = c.codice
GROUP BY c.nome, e.voto, e.lode
ORDER BY c.nome, e.voto