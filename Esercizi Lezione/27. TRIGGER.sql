/* --- TRIGGER ---
Operazioni da eseguire automaticamente quando si verifica un evento su una tabella

- Non vengono richiamati direttamente
- Si attivano quando eseguiamo:
	# INSERT
    # UPDATE
    # DELETE
- Sono associati ad una specifica tabella

Limiti MySQL:
- Non possono usare UDF
- Non possono usare stored procedure
- Non possono usare prepared statements
*/


/* --- VANTAGGI ---
- Maggiore controllo sull’integrità dei dati
	# Posso fare controlli che il DBMS non supporta (es: CHECK in MySQL)

- Controlli sulla logica applicativa
	# Evito dati incoerenti

- Audit (registrazione modifiche)
	# Posso tracciare chi modifica cosa
*/


/* --- CREAZIONE DI UN TRIGGER ---
- Ogni trigger ha un nome
- È associato ad una tabella
*/

CREATE TRIGGER nome_trigger
BEFORE | AFTER INSERT | UPDATE | DELETE
ON nomeTabella
FOR EACH ROW
BEGIN
	codice
END;


/* --- QUANDO USARE I TRIGGER ---
- Operazioni:
	# INSERT
    # UPDATE
    # DELETE

- Momento:
	# BEFORE → controllo dati (validazione)
    # AFTER → log, aggiornamenti, ricalcoli
*/


/* --- GRANULARITÀ ---
- STATEMENT LEVEL:
	# Una volta per query

- ROW LEVEL (MySQL):
	# FOR EACH ROW
	# Una volta per ogni tupla modificata
*/


/* --- OLD & NEW ---
Servono per accedere ai dati prima/dopo la modifica

- OLD:
	# valore prima della modifica
	# usabile in DELETE e UPDATE

- NEW:
	# valore dopo la modifica
	# usabile in INSERT e UPDATE

Esempio:
# OLD.salary → valore vecchio
# NEW.salary → valore nuovo
*/


/* ========================================================= */
/* --- ESEMPIO: TABELLA DI AUDIT --- */
/* ========================================================= */

CREATE TABLE employees_audit (
	id int(11) NOT NULL AUTO_INCREMENT,
	employeeNumber int(11) NOT NULL,
	lastname varchar(50) NOT NULL,
	changedon datetime DEFAULT NULL,
	changedBy varchar(50) DEFAULT NULL,
	action varchar(50) DEFAULT NULL,
	PRIMARY KEY (id)
);


/* ========================================================= */
/* --- TRIGGER CHE REGISTRA LE MODIFICHE --- */
/* ========================================================= */

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


/* TEST */
UPDATE employees
SET lastName = 'Phan'
WHERE employeeNumber = 1056;


/* ========================================================= */
/* --- CONTROLLO DATI --- */
/* ========================================================= */

-- Se qualcosa non va → errore

SIGNAL sqlstate '45001'
SET message_text = "No way !";


/* Esempio logico: NON permettere aumento creditLimit

IF NEW.creditLimit > OLD.creditLimit THEN
	SIGNAL SQLSTATE '45001'
	SET MESSAGE_TEXT = 'Incremento non consentito';
END IF;
*/


/* ========================================================= */
/* --- CONFLITTI TRA TRIGGER --- */
/* ========================================================= */

-- Ordine teorico:

# BEFORE statement-level
# BEFORE row-level
# Operazione DB
# AFTER row-level
# AFTER statement-level

-- Se più trigger:
# ordine deciso dal DBMS


/* ========================================================= */
/* --- MODELLO DI ESECUZIONE --- */
/* ========================================================= */

-- I trigger possono attivare altri trigger

# struttura a stack:
# TEC0 -> TEC1 -> … -> TECn

# uno attivo alla volta


/* ========================================================= */
/* --- INTERAZIONE TRA TRIGGER --- */
/* ========================================================= */

-- Trigger BONUS

CREATE TRIGGER Bonus
AFTER UPDATE ON Progetto
FOR EACH ROW
BEGIN
	IF NEW.Obiettivo = 'SI' THEN
		UPDATE Impiegato
		SET Salario = Salario * 1.10
		WHERE NProg = NEW.NroProg;
	END IF;
END;


-- Trigger controllo incremento

CREATE TRIGGER ControllaIncremento
AFTER UPDATE ON Impiegato
FOR EACH ROW
BEGIN
	DECLARE X DECIMAL(10,2);

	SELECT Salario INTO X
	FROM Impiegato
	JOIN Dipartimento
	ON Impiegato.Matricola = Dipartimento.MatricolaMGR
	WHERE Dipartimento.NroDip = NEW.NDip;

	IF NEW.Salario > X THEN
		UPDATE Impiegato
		SET Salario = X
		WHERE Matricola = NEW.Matricola;
	END IF;
END;





