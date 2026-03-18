/*	--- LIMITI ---	
Non voglio tutte le righe che soddisfano il filtro, solo le top N */

SELECT a1, a2, ... , an
FROM tab
WHERE ...
LIMIT numero;


/* Es 64 - Pag 440: Mostrare i primi 5 clienti (codice cliente, nome e limite di credito) */
SELECT  
	customerNumber AS Codice_cliente,
    customerName AS Nome_Cliente,
    creditLimit AS Limite_credito
FROM customers
LIMIT 5;

/* Es 65 - Pag 442: Mostrare i 5 clienti con il credito più alto */
SELECT  
	customerNumber AS Codice_cliente,
    customerName AS Nome_Cliente,
    creditLimit AS Limite_credito
FROM customers
ORDER BY creditLimit DESC
LIMIT 5;

/*Posso usarli anche per l'IMPAGINAZIONE:
Non voglio tutte le righe che soddisfano il filtro: SOLO LE PRIME N A PARTIRE DALLA RIGA X

	X --> Dalla riga Xesima dei risultati (si parte da 0)
	N --> Quante righe prendere */

SELECT a1, a2, ... , an
FROM tab
WHERE ...
LIMIT X, N;

/* Es 66 - Pag 445 : Mostrare il secondo prodotto più costoso (buyprice) in listino */
SELECT 
	productName AS nome_prodotto,
    buyprice AS Prezzo
FROM products
ORDER BY buyprice DESC
LIMIT 1, 1;

