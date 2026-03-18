/*	LIMITI
ES ? : Mostrare i primi 5 clienti (codice cliente, nome e limite di credito) */

SELECT customernumber, customername, creditlimit
FROM customers
LIMIT 5;