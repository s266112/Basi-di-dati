/* --- CONTROLLO ACCESSI ---

	# Connessione
	- Utente e password valide?
    - [connessione da client autorizzato]?
    
    # Richiesta
    - L'utente connesso può fare questa operazione?
    - Può accedere a questo DB?
    - Può accedere a questa tabella? 
    - Ecc..
*/

/* 1. AGGIUNGERE UTENTI: 
Su MYSQL devo fare attenzione a queste regole:
	- Posso usare wildards nell'host se le racchiudo tra apici -'%' per ogni host
    - 'nome@host' crea un utente con username nome@host legato all'host %
    - FLUSH PRIVILEGES forza il reload dei dati 
*/

CREATE USER nome@host
IDENTIFIED BY 'password';

/*Es 81 - Pag 532: Creare l'utente "pippo" con password "pluto" che possa connetersi solo dal vostro computer */
CREATE USER pippo@localhost
IDENTIFIED BY 'pluto';

/* 2. MODIICARE GLI UTENTI
Cambiare la password
*/
SET PASSWORD FOR user@host = 
PASSWORD ('Secret1970');

/*3. ELIMINARE UN UTENTE */
DROP USER user@host;

/* --- ASSEGNARE I PERMESSI ---
Un utente appena creato non può fare nulla
*/

GRANT privilegio (colonne)
ON risorsa
TO account
[WITH GRANT OPTION];

/* Cosa sono?: 
- PRIVILEGIO: Tipo di operazione permessa
	# ALL: tutti
	# ALTER: modificare tabella
	# CREATE: creare oggetti
	# DELETE: eliminare ennuple
	# SELECT: leggere i dati
	# UPDATE: modificare i dati
	# ecc..
- COLONNE: se si applica solo ad alcune colonne
- RISORSA: database.tabella - wildcard:*
- ACCOUNT: utente@host
- WHITH GRANT OPTION: L'utente può propagare i permessi ad altri
*/

/*	--- VISUALIZZARE I PERMESSI ---
Posso vedere i privilegi di ogni utente */

SHOW GRANTS FOR utente;


/*	--- REVOCARE I PERMESSI ---
Sintassi molto simile a GRANT */

REVOKE privilege_type [(column_list)]
[, priv_type [(column_list)]] ...
ON [object_type] privilege_level
FROM user [, user] ...;

/*Esempio - Pag 542 */
REVOKE UPDATE, DELETE ON
classicmodels.*
FROM 'rfc'@'localhost';










