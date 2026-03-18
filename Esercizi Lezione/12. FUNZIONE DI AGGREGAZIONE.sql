/* --- RAGGRUPPARE I DATI --- 
Voglio raggruppare le ennuple in sottogruppi in base ad uno o più valori */
    
SELECT a1, a2, ..., an
FROM tabella1
WHERE condizioni
GROUP BY a1, a2, ..., an;

/* Es 41 - Pag 373: Mostra tutti gli stati degli ordini esistenti */
SELECT status
FROM orders
GROUP BY status;

/* Es 42 - Pag 374: Mostra tutti gli stati degli ordini fatti prima del 31/12/2003 */
SELECT status
FROM orders
WHERE orderDate < "2003-12-31"
GROUP BY status;


/* --- FUNZIONI DI AGGREGAZIONE ---
Permettono di effettuare calcoli su tutti i valori che l'attributo assume nella query eseguita
AGGREGATORI:
		- COUNT: Conta il numero di valori presenti
        - SUM: Somma dei valori
        - AVG: Media dei valori
        - MAX/MIN: Massimo e minimo
*/

SELECT a1, a2, ..., an, aggregatore (ax)
FROM tabella1
WHERE condizioni;


/* Es 43 - Pag 379: Quanti dipendenti ci sono in azienda? */
SELECT count(*)
FROM employees;

/* Es 44 - Pag 382: Quanti capi ci sono in azienda? */
SELECT count(distinct reportsTo)
FROM employees;

/* Es 45 - Pag 384: Quanti pagamenti ho ricevuto? */
SELECT count(*)
FROM payments;

/* Es 46 - Pag 385: Quanti soldi ho ricevuto con i pagamenti? */
SELECT sum(amount)
FROM payments;

/* Es 47 - Pag 387: Qual'è il prezzo MEDIO di vendita di un prodotto? */
SELECT avg(MSRP)
FROM products;

/* Es 48 - Pag 390: Qual'è il prezzo MEDIO di vendita di un prodotto? Qual'è il MASSIMO? Qual'è il MINIMO?*/
SELECT avg(MSRP), max(MSRP), min(MSRP)
FROM products;


/* --- FUNZIONI DI AGGREGAZIONE E RAGGRUPPAMENTI ---
Voglio raggrupare le ennuple in sottogruppi in base ad uno o più valori, mostrando anche valori calcolati su ogni gruppo */

SELECT a1, a2, ..., an, aggregatore (ax)
FROM tabella1
WHERE condizioni;
GROUP BY a1, a2, ... ,an;

/* Es 49 - Pag 393: Mostra gli stati degli ordini e quanti ordini si trovano in ciascuno stato*/
SELECT status, count(*)
FROM orders
GROUP BY status;

/* Es 50 - Pag 395: Mostra quanti prodotti ho per ogni categoria ed il prezzo medio di vendita*/
SELECT productLine AS Categoria, COUNT(*) AS Numero_Prodotti, AVG(MSRP) AS Prezzo_Medio
FROM products
GROUP BY productLine;

/* Es 51 - Pag 399: Mostrare quanti ordini ho spedito nei vari mesi (una riga per mese ed Anno)*/
SELECT count(*), month(shippedDate), year(shippedDate)
FROM orders
WHERE shippedDate IS NOT NULL
GROUP BY year(shippedDate), month(shippedDate);

/* Es 52 - Pag 404: Mostrare per ogni ordine: il nome del cliente, la data dell'ordine ed il totale dell'ordine*/
SELECT c.customerName AS Nome_Cliente, o.orderDate AS data_ordine, SUM(d.quantityOrdered * d.priceEach) AS totale_ordine
FROM orderdetails d
INNER JOIN orders o USING (orderNumber)
INNER JOIN customers c USING (customerNumber)
GROUP BY o.orderNumber, c.customerName, o.orderDate;

/* Es 53 - Pag 406: Mostrare quanti ordini ha fatto ogni cliente, mettendo in cimq quelli più assidui */
SELECT count(*) nOrdini, customerNumber
FROM orders
GROUP BY customerNumber
ORDER BY nOrdini DESC;

/* Es 54 - Pagg 407 - 413: Mostrare l'estratto conto del cliente 124 (lo faccio un pezzo alla volta!)
		-> Pagamenti cliente: importo negativo
        -> Debiti cliente: importo positivo 
*/

/*Passo 1: Estrarre i pagamenti fatti con la relativa data*/
SELECT amount*-1 AS Pagamenti_Fatti, paymentDate AS Data_relativa
FROM payments
WHERE customerNumber = 124;

/*Passo 2: Prendere i totali degli ordini del cliente*/
SELECT sum(quantityOrdered*priceEach) AS ordini_totali, orderDate AS data
FROM orderdetails
INNER JOIN orders
USING (orderNumber)
WHERE customerNumber = 124
GROUP BY orderNumber;

/*Passo 3: Unire i due risultati, ordinandoli per data*/
SELECT amount*-1 AS Importo, paymentDate AS Data_operazione, 'PAGAMENTO' AS tipo
FROM payments
WHERE customerNumber = 124
UNION
SELECT sum(quantityOrdered*priceEach) AS Importo, orderDate AS Data_operazione, 'ORDINE' as tipo
FROM orderdetails
INNER JOIN orders
USING (orderNumber)
WHERE customerNumber = 124
GROUP BY orderNumber, orderDate
ORDER BY Data_operazione

/* --- FILTRARE DATI AGGREGATI --- 
Come applicare un filtro ai risultati di una funzione di aggregazione? */
    
SELECT a1, a2, ..., aggregatore (ax)
FROM tabella1
WHERE condizioni
GROUP BY a1, a2, ..., an
HAVING condizioni_aggregate;

/* Es 55 - Pag 415: Mostrare tutti gli ordini il cui totale è < 10.000 $ */
SELECT orderNumber, sum(quantityOrdered*priceEach) AS totale
FROM orderdetails
GROUP BY orderNumber
HAVING totale < 10000;

/* Es 56 - Pag 418: Mostrare tutti gli ordini il cui totale è < 10.000 $ e per i quali verranno spediti più di 100 pezzi */
SELECT orderNumber, sum(quantityOrdered) AS pezzi, sum(quantityOrdered*priceEach) AS totale
FROM orderdetails
GROUP BY orderNumber
HAVING totale < 10000 AND pezzi > 100;

/* Es 57 - Pag 420: Mostrare tutti gli ordini il cui totale è < 10.000 $ e che non sono stati spediti */
SELECT orderNumber, status, sum(quantityOrdered*priceEach) AS totale
FROM orderdetails
INNER JOIN orders
USING(orderNumber)
GROUP BY orderNumber
HAVING status <> 'Shipped' AND totale < 10000;

        













