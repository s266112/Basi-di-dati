/*	LIMITI
ES ? : Mostrare il secondo prodotto più costoso (buyprice) in listino */

SELECT productName, buyprice
FROM products
ORDER BY buyprice DESC
LIMIT 1, 1;