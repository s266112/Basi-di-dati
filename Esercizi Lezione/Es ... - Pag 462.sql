/*	-- MODIFICARE DATI --
Es ?: Cambiare prezzo di acquisto e vendita della '2001 Ferrari Enzo' */

UPDATE products
	SET msrp = 700, buyprice = 900
    WHERE productCode = '2001 Ferrari Enzo';