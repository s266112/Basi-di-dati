/* Esercizio 4: Contare il numero di studenti per ciascun corso di laurea (in ordine
decrescente) */

use unidb;
SELECT substring(matricola, 1, 4) as s, count(*) 
FROM studenti
GROUP BY s order by s

