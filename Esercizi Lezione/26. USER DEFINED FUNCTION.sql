/* --- USER DEFINED FUNCTION --- 

-> Scalar Functions
	# Simile ad una built-in function
    # Ritorna un singolo valore costruito con una serie di statements

-> Multi-Statement Table-valued Functions
	# Contenuto simile ad una stored procedure
	# Referenziata come una Vista
    
-> In-line Table-valued Functions
	# Simile ad una Vista con parametri
	# Ritorna una tabella come risultato di uno statement SELECT singolo
*/

/* --- UDF VS SP ---
-> RISULTATI:
	# SP: Restituisce 0 o N valori
	# UDF: Restituisce sempre 1 valore
    
-> PARAMETRI:
	# SP: input/output
	# UDF: Solo input
    
--> MODIFICHE:
	# SP: Non puo modificare il DB
	# UDF: solo SELECT (MySql, Oracle: tutto, ma meglio evitare)
    
--> CHI CHIAMA CHI:
	# SP: può richiamare UDF
	# UDF: non può richiamare SP
    
--> SELECT:
	# SP: non può essere usata in una SELECT
	# UDF: può essere usata in una SELECT
    
--> RECORDSET:
	# SP: se ritorna una tabella non posso riusarla (no select)
	# UDF: posso usarla come una normale tabella
*/


/* --- COME DEFINIRE UNA UDF --- 
Si usa come una funzione normale (select, ecc) */

CREATE FUNCTION function_name
(param1 tipo1,param2 tipo2,...)
RETURNS tipo
[NOT] DETERMINISTIC
BEGIN
	statements
END;

/* --- DETERMINISTIC O NO? --- 
Aiuto il motore a capire come ottimizzare

--> DETERMINISTIC: Se l’input e lo stato del DB non variano, l’output non varia

--> NON DETERMINISTIC: L’output può variare anche se l’input non varia
																	# now()
																	# rand()
*/


/* --- DETERMINISTIC: E SE SBAGLIO? --- 
Il motore si fida

- dico Deterministic ma non lo è: risultati non corretti (l’execution planner può decidere che non occorre ricalcolare)

- dico NON Deterministic ma lo è: prestazioni peggiori (ricalcolo anche se non serve)
*/


/* Es 91 - Pag 616: Creare una UDF che riceve in input un numero e ne restituisca il doppio, ed usarla in una query */

CREATE FUNCTION udf_raddoppia (numero int)
RETURNS INT DETERMINISTIC
BEGIN
RETURN numero * 2;
END;


/* Es 92 - Pag 618: Creare una UDF che riceva il credito del cliente e restituisca il livello (PLATINUM, ...) */

CREATE FUNCTION udf_customerLevel
(p_creditLimit double)
RETURNS VARCHAR(10) DETERMINISTIC
BEGIN
DECLARE lvl varchar(10);

IF p_creditLimit > 50000 THEN
SET lvl = 'PLATINUM';
ELSEIF p_creditLimit >= 10000 THEN
SET lvl = 'GOLD';
ELSE
SET lvl = 'SILVER';
END IF;

RETURN (lvl);
END;



/* Es 93 - Pag 620: Creare una UDF che riceva il codice cliente e restituisca il numero di ordini che ha fatto */

CREATE FUNCTION udf_contaOrdini(cliente int)
RETURNS INT(11)
BEGIN
DECLARE conteggio INT;

SELECT count(*) INTO conteggio
FROM orders
WHERE customerNumber = cliente;

RETURN conteggio;
END;