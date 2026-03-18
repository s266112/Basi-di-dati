/*		LIMITI		
Non voglio tutte le righe che soddisfano il filtro, solo le top N */

SELECT a1, a2, ... , an
FROM tab
WHERE ...
LIMIT numero

/*Posso usarlo anche per l'IMPAGINAZIONE:
Non voglio tutte le righe che soddisfano il filtro: SOLO LE PRIME N A PARTIRE DALLA RIGA X*/

SELECT a1, a2, ... , an
FROM tab
WHERE ...
LIMIT X, N

/*  X --> Dalla riga Xesima dei risultati (si parte da 0)
	N --> Quante righe prendere */