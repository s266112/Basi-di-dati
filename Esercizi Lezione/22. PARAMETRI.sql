/* --- PARAMETRI --- 
Una stored procedure può ricevere dei parametri:
*/

CREATE PROCEDURE nomeSP(
	nomePar1 tipoPar1,
    nomePar2 tipoPar2, ...
)
BEGIN
... codice
END
CALL nomeSP(par1, par2,...)



/*  I PARAMETRI SONO PASSATI: 

# PARAMETRO IN (solo input) -----> Parametro di ingresso
	- E l'opzione di default
    - Il valore viene passato alla procedura
	- E' in sola lettura
	- NON può essere modificato dentro la procedura

# PARAMETRO OUT (solo output) -----> Parametro di uscita
    - Il valore viene assegnato nella procedura
	- Viene restituito al chiamante
	- Durante l'esecuzione serve usare variabili (@var)

 # PARAMETRO INOUT (input + output)----->	Parametro di ingresso e uscita
	- Il valore viene passato alla procedura
	- Può essere modificato
	- Viene restituito modificato
    - Leggibili e scrivibili
*/

CREATE PROCEDURE nomeSP(
	direzione nomePar1 tipoPar1,
    direzione nomePar2 tipoPar2,...
)
BEGIN
... codice
END


/* Es 84 - Pag 567: Creare una SP che mostri i dati di tutti i dipendenti che siano della tipologia passata come parametro */

CREATE PROCEDURE sp_getEmployeeByType(
	tipoImp varchar(50))
BEGIN
SELECT * FROM employees WHERE jobTitle = tipoImp;
END;



/* Es 85 - Pag 570: Creare una SP che funga da contatore */

CREATE PROCEDURE sp_conta(
	INOUT count INT(4),
    IN inc INT(4))
BEGIN
SET count = count + inc;
END;


/* Es 86 - Pag 573: Creare una SP che raddoppi il valore passato */

CREATE PROCEDURE sp_raddoppia(
	INOUT valore int(11))
BEGIN
SET valore = valore * 2;
END;



SET @val = 10;
SELECT @val;
CALL sp_raddoppia(@val);
SELECT @val;



/* Es 87 - Pag 576: Creare una SP che prenda in input il numero d'ordine e ritorni il numero di oggetti comprati */

CREATE PROCEDURE sp_contaOggettiInOrdine(
	IN oNumber INT,
    OUT numberObjects INT)
BEGIN
SET numberObjects = (
SELECT sum(quantityOrdered)
FROM orderdetails
WHERE orderNumber = oNumber
);
END;
