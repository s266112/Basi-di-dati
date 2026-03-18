/*	-- MODIFICARE DATI --	
Es ? : Associare ai clienti senza venditore l'agente con matricola più alta (appena arivato) /*

/* 1. Individuare i clienti senza venditore*/
SELECT customerNumber
	FROM customers
    WHERE salesRepEmployeeNumber IS NULL;

/* 2. Trovare l'agente con matricola più alta*/
SELECT max(employeeNumber)
	FROM employees
    WHERE jobTitle = 'Sales Rep';


/* 3. Aggiornare i dati*/
UPDATE customers
	SET salesRepEmployeeNumber = 
    (SELECT max(employeeNumber)
    FROM employees
    WHERE jobTitle = 'Sales Rep')
    WHERE salesRepEmployeeNumber IS NULL