/* --- LISTE ---
Controlla se il valore è presente in una lista di valori */

SELECT ...
FROM ...
WHERE colonna IN (val1, val2, ...);

/*Es 15 - Pag 258: Mostra codice ufficio, citta e numero di telefono degli uffici in Francia o America */
SELECT officeCode, city, phone
FROM offices
WHERE country IN ('USA', 'FRANCE');

/*Es 16 - Pag 261: Mostrare i modellini del tipo "PLANES", "SHIP" o "CLASSIC CAR" */
SELECT * 
FROM products
WHERE productLine IN ('Planes', 'Ships', 'Classic Cars');