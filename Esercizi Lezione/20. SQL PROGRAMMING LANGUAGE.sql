/* --- SQL PROGRAMMING LANGUAGE (PL) ---

SQL non è solo un linguaggio di interrogazione (query),
ma può essere usato anche come linguaggio di programmazione.

Permette di:
- Scrivere logica
- Riutilizzare codice
- Automatizzare operazioni
*/


/* --- OGGETTI PROGRAMMABILI ---

È possibile racchiudere comandi SQL in oggetti programmabili
la cui definizione viene salvata nel database.
*/


/* TIPI PRINCIPALI */

-- VISTE --> già viste
-- STORED PROCEDURE --> insieme di comandi SQL riutilizzabili
-- TRIGGER --> eseguiti automaticamente su eventi
-- FUNCTION --> funzioni definite dall’utente


/* --- STORED PROCEDURE ---
Insieme di comandi SQL con:
- parametri di input
- parametri di output
- possibilità di restituire recordset
*/


/* --- TRIGGER ---
Particolari stored procedure che:
- sono associate ad una operazione (INSERT, UPDATE, DELETE)
- vengono eseguite automaticamente
*/


/* --- FUNCTION ---
Permettono di:
- riutilizzare codice SQL
- semplificare operazioni ripetute
*/