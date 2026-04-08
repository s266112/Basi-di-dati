/* --- GESTIRE GLI ERRORI --- 
Voglio gestire gli errori nella SP

	- CONDIZIONE: Cosa voglio intercettare
	- CODICE: Cosa fare
	- AZIONE: Come comportarsi dopo aver eseguito il codice
		
        # CONTINUE → continua con il resto
		# EXIT → termina l’esecuzione
*/

DECLARE azione HANDLER FOR
condizione [BEGIN] codice [END];

/* --- CONDIZIONI ---

- codice errore MySql
	Es: 1062 (chiave duplicata)

- SQLSTATE 'codiceNumerico'
	Es: 22012 (divisione per zero)
    
 --- SCORCIATOIE IN SQLSTATE ---
 
SQLWARNING: SQLSTATE che iniziano con 01  
NOT FOUND: SQLSTATE che iniziano con 02  
SQLEXCEPTION: tutti gli altri errori
*/

/* --- SEGNALARE ERRORI ---
Posso lanciare errori manualmente messaggi di errore
*/

SIGNAL SQLSTATE 'codice'
SET MESSAGE_TEXT = 'testo'



/* Es 90 - Pag 596: Scrivere una SP che ritorni il numero di ordini di un cliente. Se non esiste, dare un errore */

DELIMITER $$

CREATE PROCEDURE sp_countOrders(customerNo int)
BEGIN
	DECLARE conteggio INT;
	SELECT count(*) INTO conteggio
	FROM customers
	WHERE customerNumber = customerNo;
	IF conteggio = 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore: cliente non esiste';
END IF;
SELECT count(*) FROM orders WHERE customerNumber = customers

END $$;

DELIMITER ;