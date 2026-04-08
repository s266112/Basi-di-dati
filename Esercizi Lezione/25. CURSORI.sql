/* --- CURSORI --- 
Permettono di processare singole righe di un resultset

Caratteristiche:
	- READ-ONLY: Non posso aggiornare i dati usando il cursore
    - NON-SCROLLABLE: Posso scorrere il dataset senza cambiare l'ordinamento
    - ASENSITIVE: Puntano a dati reali, non ad una copia
				  Rapidi a crearsi, ma modifiche fatte ai dati da altre connessioni si ripercuotono sul cursore
                  
                  
/* --- DEFINIZIONE CURSORE --- 
Definisco il nome del cursore e la query che userà */

DECLARE nomeCursore CURSOR FOR
SELECT ...;

/* --- APERTURA --- 
Apro il cursore, eseguo la query */

OPEN nomeCursore;



/* --- LETTURA --- 
Uso il cursore in un ciclo */

FETCH nomeCursore INTO var1, var2, ...;



/* --- CHIUSURA --- 
Chiudo il cursore (libero memoria) */

CLOSE nomeCursore;



/* --- QUANDO SMETTO DI USARE IL CURSORE? ---
Uso un handler: quando non altri dati, si verifica NOT FOUND
Terminerò il ciclo quando finisced == 1  */

DECLARE CONTINUE HANDLER
FOR NOT FOUND
SET finished = 1;



/* Es 91 - Pag 607: Creare una SP che ritorni in un singolo valore tutti gli indirizzi E-Mail dei dipendenti */

DELIMITER $$

CREATE PROCEDURE sp_buildEmailList(INOUT email_list varchar(4000))
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE v_email varchar(100) DEFAULT "";

	DECLARE email_cursor CURSOR FOR SELECT email FROM employees;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
	OPEN email_cursor;
	WHILE (finished = 0) DO
		FETCH email_cursor INTO v_email;
        IF finished = 0 THEN
			SET email_list = CONCAT(v_email, ";", email_list);
		END IF;
END WHILE;
CLOSE email_cursor;
END $$

DELIMITER ;