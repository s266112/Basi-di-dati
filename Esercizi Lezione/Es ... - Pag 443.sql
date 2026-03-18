/*	LIMITI
ES ? : Mostrare i 5 clienti con il credito più elevato */

SELECT customernumber, customername, creditlimit
FROM customers
ORDER BY creditLimit DESC
LIMIT 5;