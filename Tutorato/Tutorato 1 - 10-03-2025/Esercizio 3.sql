/* Esercizio 3 : Elencare i professori che non insegnano nessun corso */
use unidb;
SELECT p.nome, p.cognome
FROM professori p
LEFT JOIN corsi c ON p.matricola = c.professore
WHERE c.codice is NULL