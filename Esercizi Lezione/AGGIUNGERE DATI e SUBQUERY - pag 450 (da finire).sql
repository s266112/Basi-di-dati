/*  --- AGGIUNGERE DATI E SUBQUERY ---
Vorrei usare una subquery per alimentare l'inserimento dei dati */

INSERT INTO tabella(col1, col2, ...)
	SELECT ...
    
/*	Il risultato della SELECT deve fornire:
	- Lo stesso numero di attributi della tabella di destinazione
    - Attributi dello stesso dominio di destinazione */