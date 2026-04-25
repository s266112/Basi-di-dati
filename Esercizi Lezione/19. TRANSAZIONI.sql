/*		--- TRANSAZIONI ---
Insieme di operazioni da considerare invisibile ("ATOMICO"), corretto anche in presenza di concorrenza e con effetti definitivi

# Proprietà transazioni:
- 1. Atomicità:
La sequenza di operazioni sulla base di dati. Viene eseguita per intero o per niente.

- 2. Consistenza:
Al termine dell'esecuzione di una transazione, i vicoli di integrità debbono essere soddisfatti.
Durante l'esecuzione ci possono essere violazioni, ma se restano alla fine allora la transazione deve essere annullata per intero ("abortita").

- 3. Isolamento:
L'effetto di transizioni concorrenti deve essere coerente (af esempio equivalente all'esecuzione separata)

- 4. Durabilità (persistenza):
La conclusione positiva di una transazione corrisponde ad un impegno ("commit") a mantenere traccia del risultato in modo definitivo, anche in presenza di guasti e di esecuzuone concorrente

# Sintassi
Su MYSQL:
- START TRANSACTION: Specifica l'inizio della transazione (le operazioni non vengono eseguite sulla base di dati)
- COMMIT: Le operazioni specificate a partire dal begin transaction vengono eseguite
- ROLLBACK: Si rinuncia all'esecuzione delle operazioni specificate dopo l'ultimo begin transaction

Esempio - Pag - 551 */

start transaction;
select @orderNumber := max(orderNUmber) from orders;
set @orderNumber = @orderNumber + 1;

insert into orders(orderNumber, orderDate, requiredDate, shipp
values(@orderNumber, now(), date_add(now(), INTERVAL 5 DAY),
date_add(now(), INTERVAL 2 DAY), 'In Process', 145);

insert into orderdetails(orderNumber, productCode, quantityOrd
values(@orderNumber,'S18_1749', 30, '136', 1),
(@orderNumber,'S18_2248', 50, '55.09', 2);

commit;

/* --- TRNSAZIONI IN UN DBMS ---
# Due modelli fondamentali:
1. GESTORE DELLA CONCORRENZA
	- Garantisce isolamento e consistenza
	- Scheduler delle operazioni
2.GESTORE DELL'AFFIDABILITA':
	- Garantisce atomicità e durevolezza
	- Consentire il recupero in caso di guasti
    
# Come salvo le transazioni?
 1. Write Ahead Logging:
	- Il log contiene i blocchi modificati
	- Commit = copiare i dati dal log al file del DB
	- Scelto da quasi tutti i motori
2. Command Logging:
	- Il log contiene lo storico delle istruzioni
	- Commit = eseguire realmente le operazioni
    
# REDO LOGGING: SOLUZIONE DI MYSQL (WRITE AHEAD)
	- Salvo i dati in un log che risiede in memoria
	- Sposto piccole porzioni in un log su disco
	- Ogni tanto unisco il log su disco ai dati reali
*/
