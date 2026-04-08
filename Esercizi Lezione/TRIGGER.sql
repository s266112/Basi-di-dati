/*	--- TRIGGER ---
Operazioni da eseguire quando si verifica un certo evento */


/*	1. CREAZIONE DI UN TRIGGER
	- Ogni trigger ha un nome
    - Ogni trigger è riferito ad una tabella */
    
CREATE TRIGGER nome, quando
ON nomeTabella
FOR EACH ROW
BEGIN
	codice
END;

/* # Che operazioni controllo col trigger?
	- INSERT;
    - UPDATE;
    - DELETE

	# Quando eseguo il trigger?
    - BEFORE: I dati sono corretti?
    - AFTER: Registro chi ha modificato i dati, ricalcolo valori */
    
/* # OLD & NEW:
Permettono di distinguere il record prima e dopo la modifica
	-> OLD: Valore precedente
		- Usabile nel DELETE
        - Usabile nel BEFORE UPDATE
        
	-> NEW: Valore dopo le modifiche
		- Usabile nell'INSERT
        - Usabile nel BEFORE UPDATE */
        
/*Es ?: Pag 633: Creare un trigger che verifiri che non venga incrementato il limite di credito */
CREATE TRIGGER trg_beforeUpdateCustomer
BEFORE UPDATE ON customers
FOR EACH ROW BEGIN
	IF NEW.creditLimit > OLD.creditLimit THEN
		SIGNAL sqlstate '45001' SET message_text = "Basta creo un nuovo Trigger"
	END IF
END;




