/* --- VARIABILI -- 
Le variabili hanno tre livelli di visibilità:

# Globali (@@): Tutti le vedono

# Connessione (@): La connessione vede le proprie */

SET @variabile = 10;

/* # Locali (senza @): nascono e muoiono nella SP */

DECLARE nomeVariabile
tipoVariabile

SET nomeVariabile = valor



/* --- CONDIZIONI ---
Nelle stored procedure posso inserire IF:
*/

IF espressione THEN
	comandi
ELSEIF espressione THEN
	comandi
ELSE
	comandi
END IF;



/* Es 88 - Pag 587: Creare una SP che Prenda in Input il codice cliente e restituisca una stringa che vale:
			--> PLATINUM se il credito è > 50.000
			--> GOLD se il credito è > 10.000 e <= 50.000
			--> SILVER altrimenti 
*/

DELIMITER $$

CREATE PROCEDURE sp_getCustomerLevel(
IN custNo int(11),
OUT customerLevel varchar(10))
BEGIN
DECLARE creditlim double;
SELECT creditlimit INTO creditlim
FROM customers
WHERE customerNumber = custNo;
IF creditlim > 50000 THEN
SET customerLevel = 'PLATINUM';
ELSEIF creditlim >= 10000 THEN
SET customerLevel = 'GOLD';
ELSE
SET customerLevel = 'SILVER';
END IF;
END $$

DELIMITER ;


/* --- CICLI ---
Posso ripetere più volte la stessa operazione

Dettagli:
	- LEAVE: esce dal ciclo
	- ITERATE: procede con l’iterazione successiva
*/

WHILE espressione DO
comandi
END WHILE;

REPEAT
comandi
UNTIL espressione
END REPEAT;



/* Es 89 - Pag 590: SP che calcoli la serie di Fibonacci */

DELIMITER $$
CREATE PROCEDURE sp_fibonacci(IN n int, OUT out_fib int)
BEGIN
DECLARE m INT default 0;
DECLARE k INT default 1;
DECLARE i INT default 1;
DECLARE tmp INT;

WHILE (i<=n) DO
set tmp = m+k;
set m = k;
set k = tmp;
set i = i+1;
END WHILE;

SET out_fib = m;
END $$
DELIMITER ;