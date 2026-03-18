/* --- ISTRUZIONE SELECT --- 
	- * = Tutti gli attributi
    - FROM = Da dove
    - WHERE = Quali ennuple 
*/

SELECT attributo1 [, attributo2, ....]
FROM tabella1 [, tabella2, ...]
[WHERE condizione];
 
 
 /*Es 1 - Pag 224: Elencare tutti i modellini in vendita */
SELECT *
FROM products;

/* Es 2 - Pag 227: Mostra i modellini che costano meno di 75 $ */
SELECT *
FROM products
WHERE MSRP < 75;

/* Es 3 - Pag 228: Mostra nome, prezzo di acquisto e di vendita dei modellini che costano meno di 75$ */
SELECT productName, buyPrice, MSRP
FROM products
WHERE MSRP < 75;



