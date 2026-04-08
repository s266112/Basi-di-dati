/* --- STORED PROCEDURE ---
Subroutine che contengono tutto il codice per effettuare una operazione

- Incapsulano task ripetitivi
- Codice ammesso: tutto (DDL, DML, TSQL,…)
- Accettano parametri di input
- Producono zero, uno o più output:
	# Parametri di output
	# Resultset
        
Permettono la creazione di un livello di astrazione del modello fisico del database
*/


/* --- A COSA SERVONO ---
Fondamentali per incapsulare la logica di:

- Accesso alle tabelle
- Manipolazione dei dati
*/


/* --- VANTAGGI ---
- Mascherano lo schema logico del DB
- Riutilizzo del codice
- Permettono meccanismi di sicurezza
- Migliorano le performance
- Riducono il traffico di rete
*/


/* --- SVANTAGGI ---
- Aumentano il carico (CPU, memoria) del DBMS
- Difficile farne il debug
- Sintassi particolare
- Non sono transazionali di per sé
*/


/* --- CREARE STORED PROCEDURE ---
Problema: potrei avere più istruzioni e non voglio che 
il DBMS le interpreti una alla volta (ogni volta che trova un “;”)
*/

CREATE PROCEDURE nome()
BEGIN
... codice
END;


/* --- DELIMITER ---
Serve per cambiare il simbolo di fine comando

Di default:
; = fine query

=> dentro le procedure uso ; più volte

Soluzione: Su MYSQL cambio delimitatore (es: $$)
*/

DELIMITER $$
CREATE PROCEDURE nome()
BEGIN
... codice1;
... codice2;
END $$
DELIMITER ;


/* --- ESEGUIRE STORED PROCEDURE --- */
CALL nomeStoredProcedure();


/* --- VISUALIZZARE STORED PROCEDURE --- 
Si usa per vedere tutte le SP del motore

Condizioni:
	- DB: nome del DB
	- NAME: nome della SP
	- Posso usare uguaglianza, LIKE, OR, AND, …
*/

SHOW PROCEDURE STATUS
[WHERE Condizioni];


/* --- VEDERE IL CODICE --- */
SHOW CREATE PROCEDURE spNome


/* --- ELIMINARE STORED PROCEDURE --- */
DROP PROCEDURE spNome


/* --- MODIFICARE STORED PROCEDURE --- */
DROP + CREATE


/* Es 83 - Pag 561: CREARE UNA SP CHE MOSTRI I DATI DI TUTTI I DIPENDENTI CHE SIANO "SALESREP" */

DELIMITER $$

CREATE PROCEDURE sp_getSalesRep()
BEGIN
SELECT * FROM employees
WHERE jobTitle = 'Sales Rep';
END $$
DELIMITER ;

CALL sp_getSalesRep()














