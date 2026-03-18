/*	-- AGGIUNGERE DATI --	
Es ? : Duplicare l'ordine 10425/*

/* 1. Creare l'ordine 10426 (a mano, tabella orders)*/
INSERT INTO orders
	VALUE (10426, '2014-11-11', '2014-11-30', 
		null, 'In process', 'Duplica 10425', 119);

/* 2. Prendere tutte le righe di 10425 (orderdetails) */
SELECT 10426 AS numero, productCode,
	quantityOrdered, priceEach, orderLineNumber
FROM orderdetails
WHERE orderNumber = 10425;

/* 3. Inserire tutte ueste n-uple nella tabella (orderdetails)*/
INSERT INTO orderdetails
SELECT 10426 AS numero, productCode,
	quantityOrdered, priceEach, orderLineNumber
FROM orderdetails
WHERE orderNumber = 10425;


