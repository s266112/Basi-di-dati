/* --- ORDINAMENTO ---
Stabilire l'ordine di presentazione dei risultati
	-> ASC: Crescente (E' DI DEFAULT!)
    -> DESC: Decrescente */ 
    
SELECT ...
FROM ...
WHERE ...
ORDER BY col1 [ASC/DESC], col2 [ASC/DESC], ...;

/* --- Funzione FIELD ----
Ritorna la posizione della stringa text nella lista str1, str2, str3...*/

SELECT ...
FROM ...
WHERE ...
FIELD(text, str1, str2, str3, ...);


/*Es 23 - Pag 279: Mostra i modellini ordinandoli per prezzo di vendita crescente */
SELECT productName, MSRP
FROM products
ORDER BY MSRP;

/*Es 24 - Pag 281: Mostra i clienti ordinandoli per paese crescente e credito massimo decrescente */
SELECT customerName, country, creditLimit
FROM customers
ORDER BY country, creditLimit DESC;

/*Es 25 - Pag 283: Mostra gli ordini ordinandoli in base allo status in cui si trovano (in corso, in attesa, cancellati, ecc) */
SELECT *
FROM orders
ORDER BY status;

/*Es 26 - Pag 285: Mostra gli ordini ordinandoli in base allo status in cui si trovano (in corso, in attesa, cancellati, ecc) --> USA LA FIELD*/
SELECT *
FROM orders
ORDER BY field(status, 'In Process', 'On Hold', 'Cancelled', 'Resolved', 'Disputed', 'Shipped');

/* --- RIGHE DUPLICATE ---
 Ogni tanto le query ritornano righe duplicate: come elimino i doppioni?*/
SELECT DISTINCT ...
FROM ...;

/*Es 26 - Pag 291: Mostra tutte le città in cui si trovano i miei clienti, ordinandole alfabeticamente */
SELECT DISTINCT city
FROM customers
ORDER BY city;

