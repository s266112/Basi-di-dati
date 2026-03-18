/* --- UNION JOIN --- 
Unisce i risultati di più query 

	-> DISTINCT: Default, elimina i duplicati
	-> ALL: Se specificato, NON elimina i duplicati 
*/
    
SELECT... FROM ...
UNION [DISTINCT/ALL]
SELECT ... FROM ...
[UNION[DISTINCT/ALL]
SELECT.... FROM...];


/* Es 37 - Pag 361: Mostra l'identificativo ed il nome di tutti gli impiegati e di tutti i clienti */
SELECT customerNumber AS id, contactLastName AS nome
FROM customers
UNION
SELECT employeeNumber AS id, firstName AS nome
FROM employees;


/* Es 38 - Pag 364: Mostra l'ID ed il nome di tutti gli impiegati e di tutti i clienti, scrivendo per ognuno cosa sia */
SELECT customerNumber AS id, contactLastName AS nome, "Cliente" AS tipo
FROM customers
UNION
SELECT employeeNumber AS id, concat(firstName, " ", lastName) AS nome, "Impiegato" AS tipo
FROM employees;


/* --- UNION E ORDINAMENTO ---
E se volessi ordinare i risultati? 
								!!ATTENZIONE!!:
	-> Posso usare le parentesi per fare ordine
	-> L'ultima riga è riferita al RISULTATO della union, non all'ultima query
    -> Se si inserisce la clausola all'interno della singola query verrà ingnorata*/
    
(SELECT... FROM ...)
UNION [DISTINCT/ALL]
(SELECT ... FROM ...)
ORDER BY criteri;

/* Es 39 - Pag 367: Mostrare ID e NOME di clienti ed impiegati ordinandoli per nome */
(SELECT customerNumber AS id, contactLastName AS nome FROM customers)
UNION
(SELECT employeeNumber AS id, firstName AS nome FROM employees)
ORDER BY nome;

/* Es 40 - Pag 369: Mostrare i paesi in cui c'è un ufficio o un cliente, ordinati per nome */
(SELECT country FROM offices)
UNION
(SELECT country FROM customers)
ORDER BY country;



