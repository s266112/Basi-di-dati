/* --- CONDIZIONI --- 

1. TESTO ESATTO: Uso le virgolette singole o doppie?

--> Per inserire ' in una stringa? ES: Ci'ao
	* Se è delimitata da " ": Scrivo "Ci'ao"
    * Se è delimitata da ' ': Allora raddoppio, quindi 'Ci''ao'
    
--> Per inserire " in una stringa? ES: Ci"ao
	* Se è delimitata da " ": Allora raddoppio, quindi "Ci""ao"
    * Se è delimitata da ' ': Scrivo 'Ci"ao' 
*/

/* Es 4 - Pag 233: Mostra tutti di dipendenti di nome Leslie */
SELECT * 
 FROM employees
 WHERE firstName = 'Leslie';
 
 /* 2. TESTO INCOMPLETO -> Condizioni:
	-> % = Zero o più caratteri
    -> _ = Esattamente un carattere
    -> Per cercare il carattere % uso \%
    -> Per cercare il carattere _ uso \_
*/
 
 /*Es 5 - Pag 236: Mostra tutti i dipendenti il cui cognome finisce per "SON" */
 SELECT *
 FROM employees
 WHERE lastName
 LIKE '%son';
 
 /*Es 6 - Pag 237: Mostra tutti i dipendenti il cui cognome NON finisce per "SON" */
 SELECT *
 FROM employees
 WHERE lastName
 NOT LIKE '%son';
 
 /*Es 7 - Pag 240: Mostra tutti i dipendenti il cui nome finisce per "ARRY" e davanti ha una sola lettera */
 SELECT *
 FROM employees
 WHERE firstName
 LIKE '_arry';
 
  /*Es 8 - Pag 242: Mostra tutti i prodotti che hanno una scala divisibile per 10 e minore di 100 (ES: 1:10, 1:20, 1:30 ...) */
 SELECT *
 FROM products
 WHERE productScale
 LIKE '1:_0';
 
  /*Es 9 - Pag 244: Mostra tutti i dipendenti il cui nome inizia con M e la cui terza lettera è una R */
 SELECT *
 FROM employees
 WHERE firstName
 LIKE 'M_R%';
 
 /*3. PIU' CONDIZIONI: Unisco più condizioni assieme */
 
/*Es 10 - Pag 246: Mostra i modellini che costano meno di 75 $ e che abbiamo comprato a più di 30 $ */
 SELECT productName, MSRP, buyPrice
 FROM products
 WHERE MSRP < 75 AND buyPrice > 30;
 
 /*Es 11 - Pag 247: Mostra i modellini che costano meno di 75 $ o più di 150 $ */
 SELECT productName, MSRP
 FROM products
 WHERE MSRP < 75 OR MSRP > 150;
 
  /*Es 12 - Pag 249: Mostra i modellini che costano meno di 75 $ o più di 150 $ e che comunque abbiamo comprato a più di 30 $ */
 SELECT productName, MSRP, buyPrice
 FROM products
 WHERE (MSRP < 75 OR MSRP > 150) AND buyPrice > 30;
 
 