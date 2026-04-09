/* --- TRIGGER ---
Operazioni da eseguire quando si verifica un certo evento 

- Non viene richiamata direttamente
- Parte automaticamente quando si effettua una operazione su una certa tabella (insert, delete, update)
- Possono essere legati ad eventi temporali
- limiti MySQL: non possono usare UDF, SP, prepared statements
*/

/* VANTAGGI 
- Ulteriore controllo dell’integrità dei dati
	# Controlli non possibili per limiti del motore (es: CHECK in MySql)
    # Controlli aggiuntivi sulla logica del programma
    
- Molto comodi per l’audit (registrazione) delle modifiche
*/


/* CREAZIONE DI UN TRIGGER 

	- Ogni trigger ha un nome
    - Ogni trigger è riferito ad una tabella
*/

CREATE TRIGGER nome quando
ON nomeTabella
FOR EACH ROW
BEGIN
	codice
END


/*  1. QUANDO USIAMO I TRIGGER?

- Che operazioni controlliamo?
	# INSERT
    # UPDATE
    # DELETE
    
- Quando devo eseguire i trigger?
# BEFORE -> Es: I dati sono coretti?
# AFTER -> Registro chi ha modificato i dati, ricalcolo valori
*/


/* 2. GRANULARITÀ 

- STATEMENT LEVEL (DEFAULT SQL SERVER):
	# Il trigger viene eseguito una volta sola per ogni comando che lo ha attivato, indipendentemente dal numero di tuple modificate
	# E' il modo più vicino all’approccio tradizionale dei comandi SQL, che sono di norma set-oriented
    
- ROW LEVEL:
	# FOR EACH ROW, unico per MySQL
	# Il trigger viene eseguito una volta per ciascuna tupla che è stata modificata dal comando
    # Consente di scrivere i trigger in modo più semplice
	# Può essere meno efficiente
*/

/* 3. OLD & NEW 
Permettono di distinguere il record prima e dopo la modifica

- OLD: valore precedente
	# Usabile nel DELETE
	# Usabile nel BEFORE UPDATE
    
    
- NEW: valore dopo le modifiche
	# Usabile nell’INSERT
	# Usabile nel BEFORE UPDATE --> Es: OLD.contactLastName
*/


/* Esempio 1: CREIAMO UNA TABELLA DI AUDIT */

CREATE TABLE employees_audit (
	id int(11) NOT NULL AUTO_INCREMENT,
	employeeNumber int(11) NOT NULL,
	lastname varchar(50) NOT NULL,
	changedon datetime DEFAULT NULL,
	changedBy varchar(50) DEFAULT NULL,
	action varchar(50) DEFAULT NULL,
	PRIMARY KEY (id)
)


/* Esempio 2: TRIGGER CHE REGISTRA LE MODIFICHE */

DELIMITER $$
CREATE TRIGGER trg_beforeUpdateEmployees
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
	INSERT INTO employees_audit
	SET action = 'update',
	employeeNumber = OLD.employeeNumber,
	lastname = OLD.lastname,
	changedon = NOW(),
	changedby = user();
END$$
DELIMITER ;


/* --- TRIGGER PER IL CONTROLLO DEI DATI --- 
Se qualcosa non va si segnala un errore.
La sintassi è la stessa vista nelle SP
*/

SIGNAL sqlstate '45001' SET message_text = "No way !";


/* --- CONFLITTI TRA TRIGGER --- 

--> Se vi sono più trigger associati allo stesso evento, SQL:1999 prescrive

	- Vengono eseguiti i trigger BEFORE statement-level
	- Vengono eseguiti i trigger BEFORE row-level
	- Si applica la modifica e si verificano i vincoli di integrità definiti sulla base di dati
	- Vengono eseguiti i trigger AFTER row-level
	- Vengono eseguiti i trigger AFTER statement-level
    
--> Se vi sono più trigger della stessa categoria, l'ordine di esecuzione viene scelto dal sistema in un modo che dipende dall'implementazione

	- SQL:1999 prevede che i trigger vengano gestiti in un Trigger Execution Context (TEC)
	- L’esecuzione dell’azione di un trigger può produrre eventi che fanno scattare altri trigger
	- In ogni istante possono esserci più TEC per una transazione, uno dentro l’altro, ma uno solo può essere attivo
	- Per i trigger row-level il TEC tiene conto di quali tuple sono già state considerate e quali sono da considerare
	- Si ha quindi una struttura a stack: TEC0 -> TEC1 -> … -> TECn
	- Quando un trigger ha considerato tutti gli eventi, il TEC si chiude e si passa al trigger successivo
*/





