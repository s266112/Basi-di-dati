/*	SUBQUERY - CORRELATE
ES ? : Mostrare i prodotti il cui prezzo di acquisto è superiore alla media della linea cui afferiscono */

SELECT productname, buyprice
FROM products AS p
WHERE buyPrice > (SELECT AVG(buyprice)
FROM products
WHERE productline = p.productline)