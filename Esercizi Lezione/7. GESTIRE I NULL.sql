/* --- GESTIRE I NULL ---
Controlla se il valore è presente in una lista di valori */

SELECT ...
FROM ...
WHERE colonna IS NULL;

/*Es 17 - Pag 264: Mostra gli ordini non spediti */
SELECT * 
FROM orders
WHERE shippedDate IS NULL;

/*Es 18 - Pag 267: Mostra gli ordini creati dopo il 30/04/2005 e non spediti */
SELECT * 
FROM orders
WHERE orderDate > '2005-04-30' AND shippedDate IS NULL;

/* --- ESPRESSIONI- --- */

/*Es 19 - Pag 269: Mostra i prezzi di vendita senza l'iva (PREZZO/1.22) */
SELECT productName, MSRP/1.22 AS senzaIVA 
FROM products;

/*Es 20 - Pag 271: Mostra i prodotti con un margine (PREZZO - PREZZO ACQUISTO) superiore a 50 */
SELECT productName, MSRP, buyPrice 
FROM products
WHERE MSRP-buyPrice > 50;


