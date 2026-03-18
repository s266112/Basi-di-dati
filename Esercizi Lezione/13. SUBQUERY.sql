/* --- SUBQUERY --- 
Posso annidare le quesry una dentro l'altra

Per ADESSO:
-> Le subquery vivono di vita propria
-> Posso scriverle separatamente, poi incorporarle
*/
    
SELECT a1, a2, ..., an (QUERY singolo valore)
FROM (QUERY)
WHERE a1 > (QUERY singolo valore) AND a2 IN (QUERY singolo attributo);

/* ESERCIZI: SUBQUERY - SINGOLO VALORE*/

/* Es 58 - Pag 423: Mostrare per ogni articolo il prezzo di vendita ed il prezzo del prodotto più caro */
SELECT 	productName AS Prodotto, 
		MSRP AS Prezzo_Listino, 
        (SELECT max(MSRP) FROM products) AS Prezzo_massimo_assoluto
FROM products;


/* Es 59 - Pag 425: Mostrare i dati del pagamento più alto ricevuto */
SELECT 	customerNumber AS ID_Cliente, 
		checkNumber AS Numero_assegnato, 
        amount AS Importo_record
FROM payments
WHERE amount = (SELECT max(amount) FROM payments);


/* Es 60 - Pag 427: Mostrare i pagamenti superiori alla media */
SELECT 	customerNumber AS ID_Cliente, 
		checkNumber AS Numero_Assegnato, 
        amount AS Importo_Sopra_media
FROM payments
WHERE amount > (SELECT AVG(amount) FROM payments);


/* Es 61 - Pag 430: Mostrare i clienti che non hanno fatto ordini */
SELECT customerName AS Cliente_Inattivo
FROM customers
WHERE customerNumber NOT IN (SELECT DISTINCT customernumber FROM orders);

/* ESERCIZI: SUBQUERY - FROM */

/* Es 62 - Pag 432: Mostrare il numero massimo, minimo e medio di pezzi inseriti negli ordini */
SELECT  max(Totale_pezzi) AS Massimo_Pezzi,
		min(Totale_pezzi) AS Minimo_Pezzi,
        floor(AVG(Totale_pezzi)) AS Media_Pezzi
FROM (SELECT orderNumber, 
SUM(quantityOrdered) AS Totale_pezzi
FROM orderdetails
GROUP BY orderNumber) AS Tabella_Temporanea_ordini;

/* --- SUBQUERY CORRELATE --- 
- Non eseguibile "da sola"
- Eseguita per ogni riga della query principale
- Visibilità variabili: solo da query a subquery*/

SELECT a1, a2, ..., an
	FROM tab1 WHERE
    a1 > (SELECT c1
    FROM tab2
    WHERE tab2.c2 > tab1.a1);
    
    
/* Es 63 - Pag 436: Mostrare i prodotti il cui prezzo di acquisto è superiore alla media della linea cui afferiscono */
SELECT  
	productName AS nome_prodotto, 
    buyprice AS Prezzo_acquisto
FROM products AS p
WHERE buyprice > (SELECT AVG(buyprice)
FROM products
WHERE productline = p.productline);


/*	--- EXISTS ---
Operatore booleano (per Where): Ritorna vero se una sottoquery ha valori*/

SELECT a1, a2 ..., an
FROM tab
WHERE EXISTS (QUERY singolo valore)









