/* 1. --- ELENCARE I DATABASE ---
 -  Ritorna l'elenco dei Database presenti nel DBMS.
 -  I comandi possono occupare anche più righe e terminano con ; */
 SHOW DATABASES;
 
 
 /* 2. --- CREARE UN DATABASE --- 
 - Crea un nuovo database con il nome specificato e lo rende accessibile all'utente ROOT */
 CREATE DATABASE nomeDatabase;
 
 /* - Crea il Database se non esiste già*/
 CREATE DATABASE IF NOT EXISTS nomeDatabase
 
 
 /* 3. --- ELIMINARE UN DATABASE ---
 - Usiamo [...] per indicare le parti opzionali dei comandi*/
 DROP DATABASE [IF EXISTS] nomeDatabase;
 
 
 /* 4. --- SELEZIONARE UN DATABASE ---
 - Tutti i comandi ora faranno riferimento a questo database*/
 USE nomedatabase;
 
 
 
 
 
 