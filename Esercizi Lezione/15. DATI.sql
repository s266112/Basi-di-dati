/*	--- AGGIUNGERE DATI	---
Come posso aggiungere una nuova n-upla?

- Se imposto TUTTI gli attributi della tabella, posso omettere i nomi delle colonne (col1, col2,...)
- Attributi AUTO_INCREMENT: NULL 
*/

INSERT INTO tabella(col1, col2, ...)
	VALUES (valore1, valore2, ....)
    [, (valore1, valore2, ...), ...];
    
/* Es 67 - Pag 448 : Inserire un nuovo ufficio a Trieste */
INSERT INTO offices
	VALUES (8, 'Trieste', '+89 040123789', 
    'Via Valerio 10', null, null, 
    'Italy', '34100', 'ETNA');
    
/*  --- AGGIUNGERE DATI E SUBQUERY ---
Vorrei usare una subquery per alimentare l'inserimento dei dati 

Il risultato della SELECT deve fornire:
	- Lo stesso numero di attributi della tabella di destinazione
    - Attributi dello stesso dominio di destinazione 
*/

INSERT INTO tabella(col1, col2, ...)
	SELECT ...;



/* Es 68 - Pagg 451 - 457 : Duplicare l'ordine 10425 (Lo faccio un pezzo alla volta)/*

/* Passo 1: Creare l'ordine 10426 (a mano, tabella orders)*/
INSERT INTO orders
	VALUE (10426, '2014-11-11', 
    '2014-11-30', null, 'In process', 
    'Duplica 10425', 119);

/* Passo 2: Prendere tutte le righe di 10425 (orderdetails) */
SELECT 
	10426 AS nuovo_numero_ordine, 
    productCode AS Codice_prodotto,
	quantityOrdered AS Quantità_ordinata,
    priceEach AS prezzo_Unitario,
    orderLineNumber AS Numero_riga
FROM orderdetails
WHERE orderNumber = 10425;

/* Passo 3: Inserire tutte ueste n-uple nella tabella (orderdetails)*/
INSERT INTO orderdetails
SELECT 10426 AS nuovo_numero_ordine, 
    productCode AS Codice_prodotto,
	quantityOrdered AS Quantità_ordinata,
    priceEach AS prezzo_Unitario,
    orderLineNumber AS Numero_riga
FROM orderdetails
WHERE orderNumber = 10425;

/*	--- MODIFICARE DATI ---
Come posso modificare n-uple esistenti? 

- Ogni campo puo assumere un valore espicito, o il risultato di una funzione, sottoquery, ecc...
- Se non uso la clausola WHERE, aggiorno tutte le n-uple della tabella*
*/

UPDATE tabella
SET col1 = valore1
[, col2 = val2...]
[WHERE condizione];


/* Es 69 - Pag 459: Cambiare indirizzo email a Mary Patterson (Impiegato 1056) */
UPDATE employees
	SET email = 'mary.pattarson@email.com'
    WHERE employeeNumber = 1056;
    
/* Es 70 - Pag 461: Cambiare prezzo di acquisto e vendita della '2001 Ferrari Enzo' */
UPDATE products
	SET msrp = 700, buyprice = 900
    WHERE productCode = '2001 Ferrari Enzo';
    
/* Es 71 - Pag 464: Aumentare del 5% tutti i prezzi di vendita */
UPDATE products
	SET msrp = msrp * 1.05;
    
/* Es 72 - Pagg 465 - 472 : Associare ai clienti senza venditore l'agente con matricola più alta (appena arivato). (Lo faccio un pezzo alla volta) /*

/* Passo 1: Individuare i clienti senza venditore */
SELECT 
	customerNumber AS ID_Cliente,
    customerName AS Nome_cliente
FROM customers
WHERE salesRepEmployeeNumber IS NULL;
    
/* Passo 2: Trovare l'agente con matricola più alta*/
SELECT 
	max(employeeNumber) AS Matricola_massima,
    jobTitle AS Ruolo_azienale
FROM employees
WHERE jobTitle = 'Sales Rep';
    
/* Passo 3: Aggiornare i dati*/
UPDATE customers
SET salesRepEmployeeNumber = 
	(SELECT max(employeeNumber) 
	FROM employees
	WHERE jobTitle = 'Sales Rep')
WHERE salesRepEmployeeNumber IS NULL;

/*	--- ELIMINARE DATI ---
Come posso eliminare dati dalla tabella? 

							!!ATTENZIONE:
- Non si torna indietro
- Prima di eseguire la query, provare a metterci una SELECT * per vedere che succede
*/

DELETE FROM tabella
[WHERE condizioni];

/* Es 73 - Pag 474 : Eliminare tutti i clienti italiani*/
DELETE FROM customers
WHERE country = "Italy";
/*PERCHE NON FUNZIONA?: Vincoli interrazionali --> Devo prima modificare le altre tabelle!*/

/*	--- CHECK ---
Permette di introdurre vincoli di integrità generici 

- Le condizioni sono espressioni booleane
- Possono essere complesse (subquery)
- Non funzionano in MySql
*/

CREATE TABLE nomeTab (
	attr1 tipo 1 
		CHECK (condizione), 
    attr2 tipo, ... , 
		CHECK (condizione))
    
/* Es 74 - Pag 479 : - Il genere può essere solo M o F
					 - Stipendio inferiore a quello del capo*/
                     
CREATE TABLE Impiegato (
	matricola integer,
    cognome character (20),
    sesso character NOT NULL
		CHECK (sesso in ('M', 'F')),
	stipendio integer, superiore integer,
		CHECK (stipendio <=
			(SELECT stipendio
            FROM Impiegato J
            WHERE superiore = J.matricola));
            
/*	--- ASSERTION ---
Permette di introdurre vincoli di integrità a livello di schema 

- Le condizioni sono espressioni booleane
- Possono essere complesse (subquery)
- Non funzionano in MySql
*/

CREATE ASSERTION nome 
	CHECK (condizione)

/* Es 75 - Pag 481 : La tabella impiegato deve avere almeno un nominativo*/
CREATE ASSERTION AlmenoUnImpiegato
	CHECK ((SELECT count(*) FROM Impiegato) >= 1);





    
    


    
