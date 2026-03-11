/* Esercizio 2 : Elencare nome e cognome degli studenti che hanno preso 30 e lode
nell'esame "Basi di Dati" */

use unidb;
SELECT s.nome, s.cognome
FROM studenti s
INNER JOIN esami e ON s.matricola = e.studente
INNER JOIN corsi c ON e.corso = c.codice
WHERE c.nome = 'Basi di Dati' AND e.voto = 30 and e.lode = 1;