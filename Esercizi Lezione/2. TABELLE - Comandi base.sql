/* 1. --- CREARE UNA TABELLA ---
 - Definisce uno schema di relazione e ne crea un'istanza vuota
 - Specifica attributi domini e vincoli */

 CREATE TABLE [IF NOT EXISTS] nomeTabella
	(nomeAttributo1 tipo,
    attributo2 tipo,
    ...
    attributoN tipo)
    
    
/*2.  --- CANCELLARE UNA TABELLA --- */
DROP TABLE [IF EXISTS] nomeTabella;

/* 3. --- VINCOLI ---
Posso definire dei vincoli sui database:
- PRIMARY KEY: Chiave primaria (Una sola, inmplica NOT NULL)

- NOT NULL

- CHECK: Serve per specificare Vincoli complessi
 
- UNIQUE: Definisce le chiavi
	* UNIQUE SU PIU COLONNE */
CREATE TABLE nomeTabella
	(id int(11) PRIMARY KEY,
	campo1 int(19),
    campo2 int(12),
    CONSTRAINT [nome] UNIQUE(campo1, campo2)
    );
    
    
/* 4. --- VALORI PREDEFINITI ---*/
CREATE TABLE nome (nomeAttributo tipo DEFAULT valore);


/* 5. --- COMMENTI --- */
CREATE TABLE nome (nomeAttributo tipo COMMENT "commento");

/* 6. --- MODIFICARE TABELLE ---*

/* -> Aggiungere Colonne */
ALTER TABLE nomeTabella
	ADD COLUMN definizioneColonna
    [ FIRST / AFTER nomeColonna]
    
/* -> Rimuovere Colonne */
ALTER TABLE nomeTabella
	DROP COLUMN nomeColonna
    
/* -> Modificare Colonne */
ALTER TABLE nomeTabella
	CHANGE COLUMN nomeOriginale
    nomeNuovo tipo
    
/* -> Rinominare Tabelle */
ALTER TABLE nomeTabella
	RENAME TO nuovoNome
    
/* -> Aggiungere Foreign Key */
ALTER TABLE nomeTabella
	ADD CONSTRAINT nome
    FOREIGN KEY (...)
    REFERENCES tabella (...)
    
/* -> Rimuovere Foreign key */
ALTER TABLE nomeTabella
	DROP FOREIGN KEY nome
	


