/* SUBQUERY CORRELATE*
- Non eseguibile "da sola"
- Eseguita per ogni riga della query principale
- Visibilità variabili: solo da query a subquery*/

SELECT a1, a2, ..., an
	FROM tab1 WHERE
    a1 > (SELECT c1
    FROM tab2
    WHERE tab2.c2 > tab1.a1)