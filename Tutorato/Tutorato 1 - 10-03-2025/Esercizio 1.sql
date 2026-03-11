/*Esercizio 1: Trovare il numero di studenti iscritti alla triennale di ingegneria informatica
che sono nati a gennaio, febbraio, o marzo. */

SELECT count(*) 
FROM studenti
WHERE Matricola LIKE "IN05%"
				AND (cf LIKE "________A%"
					OR cf LIKE "________B%"
                    OR cf LIKE "________C%");