/* --- LE CHIAVI (Fondamentali per i JOIN) ---
Prima di unire le tabelle devo capire come sono collegate:

  * PRIMARY KEY (PK) --> [Chiave primaria]: 
    - Identifica in modo UNICO ogni riga di una tabella
    - NON può mai essere duplicata e NON può essere NULL
    
  * FOREIGN KEY (FK) --> [Chiave esterna]:
	- E' una colonna che contiene la PK di un'altra tabella
    - PUO' essere duplicata e può essere NULL */

/* --- JOIN ---
Servono per interagire con più tabelle contemporaneamente aggiungendo colonna al risultato

1. INNER JOIN: E' l'intersezione delle due tabelle
	- Restituisce le righe solo quando c'e corrispondenza esatta tra PK e FK
    - Se un dato non ha il compagno nell'altra tabella, viene scartato */
    
SELECT ...
FROM tabella1
INNER JOIN tabella2
ON tabella1.PK = tabella2.FK;

/* Es 27 - Pag 304: Mostra per ogni prodotto la descrizione della linea di prodotti cui appartiene */
SELECT productCode, productName, textDescription
FROM products 
INNER JOIN productlines 
ON products.productline = productlines.productline;

													/* FORMA EQUIVALENTE */
SELECT productCode, productName, textDescription
FROM products p1
INNER JOIN productlines p2
ON p1.productline = p2.productline;

										/* FORMA EQUIVALENTE -> Se gli attributi hanno lo stesso nome tra le variabili, posso usare una forma abbreviata*/
SELECT productCode, productName, textDescription
FROM products 
INNER JOIN productlines 
USING  (productline);

/* Es 28 - Pag 310: Mostra tutti gli impiegati e la città in cui si trova l'ufficio cui afferiscono*/
SELECT firstName, lastname, city
FROM employees
INNER JOIN offices 
USING  (officeCode);


/* 2. LEFT OUTER JOIN
Mostra tutti i dati della prima tabella, e se possibile associa le informazioni della seconda */

SELECT ...
FROM tabella1
LEFT OUTER JOIN tabella2 
ON PK = FK;

/* Es 29 - Pag 316: Mostra tutti i clienti; se il cliente ha un venditore associato, mostrane i dati */
SELECT customerName, concat(firstName, ' ', lastName)
FROM customers
LEFT OUTER JOIN employees 
ON salesRepEmployeeNumber = employeeNumber;

/* Es 30 - Pag 320: Mostra tutti i clienti ed i relativi ordini, inclusi i clienti che non hanno fatto ordini */
SELECT c.customerNumber, c.customerName
FROM customers c
LEFT OUTER JOIN orders o 
ON c.customerNumber = o.customerNumber;


/* Es 31 - Pag 321: Mostra tutti i clienti che non hanno ordini */
SELECT c.customerNumber, c.customerName, orderNumber, o.status
FROM customers c
LEFT OUTER JOIN orders o 
ON c.customerNumber = o.customerNumber
WHERE orderNumber is NULL;



/* 3. RIGHT OUTER JOIN
Mostra tutti i dati della seconda tabella, e se possibile associa le informazioni della prima */

SELECT ...
FROM tabella1
RIGHT OUTER JOIN tabella2 
ON PK = FK;

/* Es 32 - Pag 325: Mostra tutti i clienti; ed i relativi ordini, inclusi i clienti che non hanno fatto ordini */
SELECT  c.customerNumber, c.customerName, orderNumber, o.status
FROM orders o
RIGHT OUTER JOIN customers c 
ON c.customerNumber = o.customerNumber;



/* 4. JOIN MULTIPLE
Decodificare il contenuto di più tabelle in una sola query */

SELECT...
FROM tabella1
[INNER/LEFT/RIGHT] JOIN tabella2
ON PK = FK
[INNER/LEFT/RIGHT] JOIN tabella3
ON PK = FK;

/* Es 33 - Pag 328: Mostra tutti i clienti, il nome dell'impiegato associato ed il numero di telefono dell'ufficio */
SELECT c.customerName, e.firstName, o.phone
FROM customers c
LEFT JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
LEFT JOIN offices o
USING (officeCode);

/* Es 34 - Pag 330: Stampare ogni riga dell'ordine, indicando il nome del cliente, numero d'ordine ed il nome del prodotto ordinato */
SELECT c.customerName, o.orderNumber, p.productName
FROM orderdetails d
INNER JOIN orders o
USING (orderNumber)
INNER JOIN customers c
USING (customerNumber)
INNER JOIN products p
USING (productCode)
ORDER BY o.orderNumber, d.orderLineNumber;


/* 5. SELF JOIN
Join di una tabella con se stessa */

SELECT...
FROM tabella1
[INNER/LEFT/RIGHT] JOIN tabella1
ON PK = FK;

/* Es 35 - Pag 352: Mostra tutti i dipendenti ed il nome del loro capo */
SELECT m.employeeNumber, m.firstName, m.lastName, m.reportsTo, c.firstName, c.lastName
FROM employees m
LEFT JOIN employees c
ON m.reportsTo = c.employeeNumber;

/* Es 36 - Pag 358: Mostra tutte le coppie di clienti che abitano nella stessa città */
SELECT c1.city, c1.customerName, c2.CustomerName
FROM customers c1
INNER JOIN customers c2
ON c1.city = c2.city AND c1.customername <> c2.CustomerName;