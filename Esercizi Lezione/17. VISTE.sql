/* --- VISTE ---
	# Rappresentazione alternativa dei dati
	- SQL SELECT salvata nel motore
    - Persistente: Non muore alla chiusura della connesione
    - Posso usare query per interrogarla
    - Posso aggiornare i dati (con dei limiti)
    
    # Come funzionano?
    - Nella query inserisco il codice contenuto nella vista
    - Eseguo il codice ottenuto
    */
    
/*
1. DEFINIZIONE DI UNA VISTA
	- La select può essere eseguita da sola
    - Posso usare la subquery nella clausola WHERE
    - Non posso usarle nella clausola FROM
*/

CREATE VIEW nomeVista AS
	SELECT ... ;
    
/*Es 79 - Pag 521: Creare uno schema esterno "ViewListinoClienti" che mostri il listino per clienti (Codice e nome prodotto, MSRP), quindi mostrarne i dati*/
	CREATE VIEW viewListinoClienti AS
		SELECT productCode, productName, MSRP
        FROM products;
        SELECT * FROM viewListinoClienti;
            
/* 2. COSA FA UNA VISTA?*/
SHOW CREATE VIEW nomeVista;

/*3. ELIMINARE UNA VISTA*/
DROP VIEW nomeVista;

/* 4. MODIFICARE UN VISTA */
ALTER VIEW nomeVista AS nuovaSELECT;

/* --- VISTE MODIFICABILI ---
Posso modificare i dati di una vista se la SELECT:
- E' riferita ad una sola tabella
- Non contiene GROUP BY o HAVING
- Non contiene DISTINCT
- Non fa riferimento a viste non modificabili
- La selezione non contiene espressioni
*/

/*Es 80 - Pag 527: Creare la vista "OfficeInfo" mostrando codice ufficio, telefono e città degli uffici.
					Provare a modificare qualche dato (Es: Numero telefono) */
CREATE VIEW officeInfo
	AS SELECT officeCode, phone, city
    FROM offices;
    
UPDATE officeInfo
	SET phone '+39 040 568235'
    WHERE officeCode = 4;