/*	--- PROFILING ---
Cosa fa il motore?
- SHOW PROFILES: Storico dei tempi di esecuzione
- SHOW PROFILE: Come ho impiegato il tempo nell'ultima query/query specifica? 

# COSA POSSO VEDERE?:
    - ALL: Tutte le informazioni
    - CPU: Tempo CPU per user/system
    - SWAPS: Utilizzo della memoria su disco
    - SOURCE: Nome della funzione/libreria usati
*/

SET profiling = 1;
esecuzione comandi
SHOW PROFILES;
SHOW PROFILE [FOR QUERY n];
SET profiling = 0;

/* --- PRIVILEGI ---
Mostra tutti i dati dell'ultima query */

SHOW PROFILE ALL FOR QUERY 4;

/* --- PREPARED STATEMENT ---
Posso precompilare le query che uso più spesso
	- PREPARE: Crea una query riutilizzabile, che può ricevere parametri
    - EXECUTE: Esegue il parametro salvato
    - DEALLOCATE PREPARE: Elimina il comando
Queste vivono e muoiono nella sessione
*/

PREPARE nomeStatement FROM 'query';
EXECUTE nomeStatement USING p1, P2, ... ;
DEALLOCATE PREPARE nomeStatement;

/*  # PREPARE:
Creare lo statement
- La query da eseguire è passata come stringa
- ogni "?" corrisponde ad un parametro che verrà comunicato in sede di esecuzione
*/

PREPARE nomeStatement FROM
	'SELECT a1,a2, ...
    FROM tabella
    WHERE a1 = ? AND a2 = ?';
    
/* Es 76 - Pag 508: Creare lo statement "STMT1" il quale seleziona productCode e productName dal listino mostrando solo le ennuple con msrp maggiore del parametro che verrà fornito*/
						DA FARE
/* # EXECUTIVE:
Eseguire lo statement
- I parametri devono essere variabili
- In teoria sono opzionali (possono creare statement sena parametri, ma è meglio evitarlo)
*/

EXECUTE nomeStatement
	[USING @var1, @var2, ...];
    
/* Es 77 - Pag 511: Usando MST1 mostrare i prodotti con prezzo superiore ai 100 $ */
							DA FARE
                            
/* # DEALLOCATE 
Eliminare lo Statement
*/

DEALLOCATE PREPARE nomeStatement;
DROP PREPARE nomeStatement;

/*	--- SCHEMA ESTERNO ---
	# PROBLEMI:
    - Codice inserito nell'applicazione
    - Sparisce quando chiuso la connesione
    - Va creato ad ogbi connessione
    - Accesso diverso da una normale tabella
    
Es 78 - Pag 514: Creare uno schema esterno che mostri il listino ai clienti (codice e nome prodotto, MSRP)
*/
PREPARE stmListinoClienti FROM
	'SELECT productCode, productName, MSRP FROM products';

