/* --- INTERVALLI ---
 Seleziona i valori compresi tra X e Y (inclusi) */

SELECT attributo
FROM tabella
WHERE colonna BEtWEEN X AND Y;

 /*Es 13 - Pag 252: Mostra i pagamenti con importi compresi tra 5.000 ed 8.000 */
 SELECT *
 FROM payments
 WHERE amount BETWEEN 5000 AND 8000;
 
  /*Es 14 - Pag 255: Prendi tutti i dipendenti il cui nome inizia con una lettera tra B ed F */
 SELECT * 
 FROM employees
 WHERE firstName BETWEEN 'B' AND 'F'