/*  --- ESERCIZI VARI --- */

/*Es 1 - Mostrare nome e cognome del venditore che ha chiuso l'ordine maggiore e totale dell'ordine */
SELECT 
    firstName AS Nome_Venditore, 
    lastName AS Cognome_Venditore, 
    sum(quantityOrdered * priceEach) AS Totale_Ordine
FROM orderdetails
JOIN orders USING (orderNumber)
JOIN customers USING (customerNumber)
JOIN employees ON salesRepEmployeeNumber = employeeNumber
GROUP BY orderNumber
ORDER BY Totale_Ordine DESC
LIMIT 1;

/*Es 2: Mostrare nome e cognome del venditore che ha chiuso l'ordine maggiore e di quello che ha gestito l'ordine minore, mostrare anche il totale  dell'ordine */
(SELECT 
    firstName AS Nome_Venditore, 
    lastName AS Cognome_Venditore, 
    sum(quantityOrdered * priceEach) AS Totale_Ordine, 'MASSIMO' AS Tipo_record
FROM orderdetails
JOIN orders USING (orderNumber)
JOIN customers USING (customerNumber)
JOIN employees ON salesRepEmployeeNumber = employeeNumber
GROUP BY orderNumber
ORDER BY Totale_Ordine DESC
LIMIT 1)
					UNION
(SELECT
	firstName AS Nome_Venditore, 
    lastName AS Cognome_Venditore, 
    sum(quantityOrdered * priceEach) AS Totale_Ordine, 'MINIMO' AS Tipo_Record
FROM orderdetails
JOIN orders USING (orderNumber)
JOIN customers USING (customerNumber)
JOIN employees ON salesRepEmployeeNumber = employeeNumber
GROUP BY orderNumber
ORDER BY Totale_Ordine ASC
LIMIT 1);

/*Es 3: Mostrare nome e cognome dei venditori che gestiscono un cliente che ha effettuato un ordine con importo superiore alla media degli ordini registrati.alter
		Mostrare anche nome del cliente, numero dell'ordine e l'ordine totale ordinando per totale ordine DESC. */        
SELECT 
    e.firstName AS Nome_Venditore, 
    e.lastName AS Cognome_Venditore, 
    c.customerName AS Nome_Cliente, 
    o.orderNumber AS Numero_Ordine, 
    SUM(od.quantityOrdered * od.priceEach) AS Totale_Ordine
FROM employees AS e
JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders AS O USING (customerNumber)
JOIN orderdetails AS od USING (orderNumber)
GROUP BY o.orderNumber
HAVING Totale_Ordine >= (
    SELECT AVG(sub_totale)
    FROM (
        SELECT SUM(quantityOrdered * priceEach) AS Sub_totale
        FROM orderdetails
        GROUP BY orderNumber
    ) AS media_ordini
)
ORDER BY Totale_Ordine DESC;

/*Es 4: Mostra il numero dell'ordine, codice prodotto, nome prodotto e totale ordinato di quel prodotto per il prodotto migliore per ogni ordine, ordinando per numero dell'ordine */
SELECT
	od.orderNumber AS Numero_Ordine,
    p.productCode AS Codice_Prodotto,
    p.productName AS Nome_Prodotto,
    od.quantityOrdered AS Quantità_Ordinata,
    od.priceEach AS Prezzo_Unitario,
	(od.quantityOrdered * od.priceEach) AS Totale_Prodotto
FROM orderdetails AS od
JOIN products AS p ON od.productCode = p.productCode
WHERE (quantityOrdered*priceEach) >= (
	SELECT max(quantityOrdered*priceEach) FROM orderdetails od2
    WHERE od.orderNumber = od2.orderNumber)
ORDER BY od.orderNumber





    
    
    