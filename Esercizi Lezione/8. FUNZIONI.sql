/* --- FUNZIONI- --- 

1. STRINGHE: Comandi che "lavorano" sul testo:
	- Lenght (): Calcola la lunghezza di una stringa (quanti caratteri ci sono)
    - Reverse (): Inverte l'ordine delle lettere (Es: "CIAO" diventa "OAIC")
    - Right (): Estrae un certo numeri di caratteri partendo da destra
    - Trim (): Rimuove gli spazi vuoti all'inizio o alla fine del testo
    ...
    
2. FUNZIONI MATEMATICHE: Permettono di gestire i numeri
	- Round(numero, decimali): Arrotonda un numero
    - Truncate (numero, decimali): Taglia i decimali senza arrotondare
    - Abs (numero): Restituisce il valore assoluto
    ...
    
3. DATA E ORA: 
	- Now (): Mi da la data e l'ora in questo preciso istante
	- Day (): Mostra il giorno 
    - Mouth (): Mostra il mese
    - Year (): Mostra l'anno
    - Monthname (): Mi da il nome esteso del mese
    - Datediff (data1, data2): Calcola quanti giorni passano tra due date
    ...
*/

/*Es 21 - Pag 274: Mostra i prodotti con nomi di almeno 15 caratteri */
SELECT productName, LENGTH(productName)
FROM products
WHERE LENGTH(productName) >= 15;

/*Es 22 - Pag 276: Mostra i prodotti ordinati nel mese di GENNAIO */
SELECT *
FROM orders
WHERE MONTH(orderDate) = 1;