/*	--- MODIFICARE DATI ---
Come posso modificare n-uple esistenti? 

- Ogni campo puo assumere un valore espicito, o il risultato di una funzione, sottoquery, ecc...
- Se non uso la clausola WHERE, aggiorno tutte le n-uple della tabella*
*/

UPDATE tabella
SET col1 = valore1
[, col2 = val2...]
[WHERE condizione]
