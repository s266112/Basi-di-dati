/* --- TECNICHE DI ACCESSO AI DATI ---

Come le applicazioni accedono ai dati all’interno di un DBMS
*/


/* --- ACCESSO AI DATI ---
Due componenti fondamentali:

- DATA CONSUMER:
	# Tool e linguaggi che lavorano con i dati

- DATA PROVIDER:
	# Sorgente dei dati (DBMS)
*/


/* --- BREVE STORIA DELL’ACCESSO AI DATI ---

Evoluzione nel tempo:

- API proprietarie (es: VB Objects)
- Data Access Objects (DAO / Jet)
- ODBC (Open Database Connectivity)
- OLE DB
- ADO (ActiveX Data Objects)
- ADO.NET
- ORM (Object Relational Mapping)
*/


/* --- SISTEMI PROPRIETARI ---

- Dipendono dal Data Consumer
	# Linguaggio
	# Piattaforma

- Dipendono dal Data Provider
	# Es: accesso a MDB su Linux
*/

/* ========================================================= */
/* --- ODBC (Open Database Connectivity) --- */
/* ========================================================= */

/*
Sviluppato da Microsoft e poi reso standard

Caratteristiche:
- Pensato per database relazionali
- Indipendente da:
	# DBMS
	# sistema operativo
*/


/* --- COMPONENTI PRINCIPALI --- */

-- ODBC Driver
# Layer tra applicazione e DBMS
# Traduce le richieste dell’applicazione in comandi per il DBMS

-- Driver Manager
# Gestisce i driver disponibili
# L’applicazione non parla direttamente con il DBMS

-- Data Source Name (DSN)
# Informazioni per la connessione
# Gestiti dal Driver Manager


/* --- PRO --- */

# Non intrusivo sul server
# I driver fanno da interfaccia verso i Data Provider


/* --- CONTRO --- */

# Non sempre esiste il driver (o non è gratuito)
# API difficili da usare
# Richiede molto codice lato applicazione

/* --- ESEMPIO DI ODBC (CODICE C) --- 

Esempio di connessione ad un database tramite ODBC
*/

/*
int main() 
{
	SQLHENV hEnv = nullptr;
	SQLHDBC hDbc = nullptr;
	SQLHSTMT hStmt = nullptr;

	-- Creazione ambiente ODBC
	SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &hEnv);

	-- Impostazione versione ODBC
	SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION, (void*)SQL_OV_ODBC3, 0);

	-- Creazione connessione
	SQLAllocHandle(SQL_HANDLE_DBC, hEnv, &hDbc);

	-- Stringa di connessione (DSN)
	SQLCHAR connStr[] = "DSN=ClassicModelsDSN;";
	SQLCHAR outConnStr[1024];
	SQLSMALLINT outConnStrLen;

	-- Connessione al DB
	SQLRETURN ret = SQLDriverConnect( hDbc, nullptr, connStr, SQL_NTS, outConnStr, 1024, &outConnStrLen, SQL_DRIVER_COMPLETE);
	if (SQL_SUCCEEDED(ret)) 
    {
		std::cout << "Connessione riuscita!\n";
	}
}

--- OSSERVAZIONI ---
- Serve molto codice per fare operazioni semplici
- Le API sono complesse
- Questo è uno dei motivi per cui sono nate tecnologie più moderne (es: ORM)

*/

/* ========================================================= */
/* --- ADO (ActiveX Data Objects) --- */
/* ========================================================= */

/*
ADO è una tecnologia Microsoft per accedere ai dati

Nasce per:
- semplificare l’uso di ODBC / OLE DB
- ridurre il codice necessario
- rendere più semplice lavorare con i database

Caratteristiche:
- interfaccia più user-friendly
- parte dei Microsoft Data Access Components (MDAC)
- può usare diverse sorgenti dati (ODBC, OLE DB)
- utilizzabile da più linguaggi (C++, Java, .NET)
*/


/* --- CONNECTION STRING ---
Serve per collegarsi al database

Formato:
chiave=valore;

È composta da:
- informazioni sul server
- nome database
- utente
- password
*/


/* --- ESEMPI DI CONNECTION STRING --- */

-- ODBC
DSN=PropDB;Uid=admin;Pwd=;

-- ACCESS
Provider='Microsoft.JET.OLEDB.4.0';Data Source='C:\test.mdb';

-- SQL SERVER
Server=myServerAddress;Database=myDB;UserId=myUsername;Password=myPassword;

-- MYSQL
Server=myServerAddress;Database=myDB;Uid=myUsername;Pwd=myPassword;


/* --- ESEMPIO ADO --- 


int main() 
{
	CoInitialize(nullptr);
	try 
    {
		ADODB::_ConnectionPtr pConn("ADODB.Connection");
		ADODB::_RecordsetPtr pRs("ADODB.Recordset");

		_bstr_t connStr = "Provider=MSDASQL;DSN=ClassicModelsDSN;";
		pConn->Open(connStr, "", "", ADODB::adConnectUnspecified);

		pRs = pConn->Execute("SELECT employeeNumber, firstName, lastName FROM employees", nullptr, ADODB::adCmdText);

		while (!pRs->ADOEOF) 
        {

			long empNum = pRs->Fields->Item["employeeNumber"]->Value;
			_bstr_t firstName = pRs->Fields->Item["firstName"]->Value;
			_bstr_t lastName = pRs->Fields->Item["lastName"]->Value;

			std::wcout << empNum << L": " << (wchar_t*)firstName << L" " << (wchar_t*)lastName << std::endl;
            pRs->MoveNext();
		}

		pRs->Close();
		pConn->Close();
	}
	catch (_com_error& e) 
		{
		std::cerr << "Errore ADO: " << e.ErrorMessage() << std::endl;
        }

	CoUninitialize();
	return 0;
}

*/


/* ========================================================= */
/* --- ADO.NET --- */
/* ========================================================= */

/*
ADO.NET è l’evoluzione di ADO per il framework .NET

Non è una singola libreria ma un insieme di:
- classi
- interfacce
- strumenti

per gestire l’accesso ai dati
*/


/* --- DIFFERENZE ADO vs ADO.NET --- */

-- ADO:
# accesso connesso (connessione sempre aperta)
# usa RecordSet (una tabella)
# dati “piatti” (flattened)
# navigazione sequenziale

-- ADO.NET:
# accesso anche disconnesso
# usa DataSet (più tabelle)
# mantiene relazioni tra dati
# navigazione relazionale


/* --- COMPONENTI PRINCIPALI DI ADO.NET --- */

-- Connection
# gestisce connessione al DB
# contiene:
	# server
	# username
	# password

-- Command
# contiene query SQL o stored procedure

-- DataReader
# lettura veloce
# solo avanti (forward-only)
# richiede connessione attiva

-- DataAdapter
# collega DB e DataSet
# lavora anche senza connessione


/* --- ESEMPIO ADO.NET ---


int main() 
{

	String^ connStr = "server=localhost;user id=root;password=la_tua_password;database=classicmodels";
	MySqlConnection^ conn = gcnew MySqlConnection(connStr);

	try 
    {
		conn->Open();

		String^ query = "SELECT employeeNumber, firstName, lastName FROM employees";
		MySqlCommand^ cmd = gcnew MySqlCommand(query, conn);
		MySqlDataReader^ reader = cmd->ExecuteReader();

		while (reader->Read()) 
        {

			int empNum = reader->GetInt32(0);
			String^ firstName = reader->GetString(1);
			String^ lastName = reader->GetString(2);

			Console::WriteLine("{0}: {1} {2}", empNum, firstName, lastName);
		}

		reader->Close();
		conn->Close();
	}
	catch (Exception^ ex) 
		{
		Console::WriteLine("Errore: {0}", ex->Message);
		}

	return 0;
}

*/

/* ========================================================= */
/* --- JDBC (Java Database Connectivity) --- */
/* ========================================================= */

/*
JDBC è la tecnologia Java per accedere ai database

È equivalente ad ADO.NET ma nel mondo Java
Permette alle applicazioni Java di comunicare con un DBMS
*/

/* --- TIPI DI DRIVER JDBC --- */

/*
Esistono 4 tipi di driver JDBC
Differiscono per:
- come comunicano con il DB
- dipendenze dal sistema
- performance
*/

/* --- TIPO 1: JDBC-ODBC BRIDGE --- 

Usa ODBC per comunicare con il DB

PRO:
# posso usare driver ODBC esistenti

CONTRO:
# dipende dal sistema operativo
# più lento (overhead)
# serve driver ODBC installato

*/


/* --- TIPO 2: DRIVER PARZIALMENTE JAVA --- 

Parte Java + parte codice nativo

PRO:
# più veloce del tipo 1

CONTRO:
# dipende dalla piattaforma
# serve codice nativo

*/
 
 
/* --- TIPO 3: DRIVER CON MIDDLEWARE --- 

Usa un server intermedio
 
 PRO:
# indipendente dal DB

CONTRO:
# più complesso
# serve middleware
 
*/


/* --- TIPO 4: DRIVER PURO JAVA 

- Comunicazione diretta con il DB
- NON usa ODBC
- NON usa middleware

PRO:
# più veloce
# più usato

CONTRO:
# serve driver specifico per DB

*/

/* ========================================================= */
/* --- JDBC: USO PRATICO --- */
/* ========================================================= */

/* --- ADO .NET -> JDBC ---
Corrispondenza tra gli oggetti principali

-- SqlConnection -> Connection
-- SqlCommand -> Statement
-- SqlDataReader -> ResultSet

*/


/* --- CARICARE IL DRIVER ---
Prima devo caricare il driver JDBC
*/

Class.forName("com.mysql.cj.jdbc.Driver").newInstance();


/* --- CONNETTERSI AL DB ---
Uso DriverManager per aprire la connessione
*/

con = DriverManager.getConnection(	"jdbc:mysql://localhost/" +
									"DBNAME?" +
									"user=XXX&" +
									"password=YYY"
);


/* --- ESEGUIRE UNA QUERY ---
Creo uno Statement ed eseguo la SELECT
*/

Statement stmt = null;
ResultSet rs = null;

try
{
	stmt = con.createStatement();
	rs = stmt.executeQuery("SELECT foo FROM bar");
}
catch (SQLException ex) 
{
	// handle any errors
}
finally 
{
	// some controls...
	rs.close();
	stmt.close();
}


/* --- LEGGERE I RISULTATI ---
ResultSet contiene le righe restituite dalla query
*/

ResultSet rs = stm.executeQuery("select * from persone");
while (rs.next()) 
{
	String col1 = rs.getString("colonna1");
}


/* --- MODIFICARE I DATI ---
Per INSERT / UPDATE / DELETE uso executeUpdate()
*/

stm.executeUpdate("UPDATE tabella SET colonna = val ...");
stm.executeUpdate("INSERT ...");
stm.executeUpdate("DELETE ...");


/* --- PREPARED STATEMENT ---
Serve per preparare query con parametri
*/

String sql = "SELECT nome FROM persone WHERE cognome = ?";
PreparedStatement prepared = connection.prepareStatement(sql);
prepared.setString(1, "Rossi");
ResultSet rs = stm.executeQuery();


/* --- PREPARED STATEMENT: INSERT ---
Altro esempio con parametri
*/

String sql = "insert into persone (cognome, nome, eta) values (?, ?, ?)";
PreparedStatement prepared = connection.prepareStatement(sql);
prepared.setString(1, "Marroni");
prepared.setString(2, "Enrico");
prepared.setInt(3, 55);
prepared.executeUpdate();


/* --- CHIAMARE UNA STORED PROCEDURE ---
Uso CallableStatement
*/

CallableStatement cStm = con.prepareCall("{call sp_name(?, ?)}");
cStm.setString(1, "abcdefg");
boolean hadResults = cStm.execute();


/* --- PARAMETRI DI UNA SP ---
Posso registrare parametri di output
*/

CallableStatement cStm = con.prepareCall("{call sp_name(?, ?)}");
cStm.registerOutParameter(2, Types.INTEGER);

/* oppure: cStmt.registerOutParameter("inOutParam", Types.INTEGER); */

cStm.setString(1, "abcdefg");
cStm.setString(2, 1);
/* oppure: cStmt.setString("inputParam", 1); */

boolean hadResults = cStm.execute();


/* --- RISULTATO DELLA SP ---
Posso leggere eventuali ResultSet e poi il valore di output
*/

boolean hadResults = cStm.execute();
while (hadResults) 
{
	ResultSet rs = cStm.getResultSet();
	hadResults = cStm.getMoreResults();
}

int outputValue = cStm.getInt(2);


/* ========================================================= */
/* --- PYTHON --- */
/* ========================================================= */

/*
Esempio di accesso a MySQL da Python
*/

import mysql.connector
mydb = mysql.connector.connect(
	host="localhost", user="userdb",
	password="***", database="classicmodels"
)

mycursor = mydb.cursor()
sql = "SELECT * FROM employees WHERE lastName = %s"
adr = ("Smith", )
mycursor.execute(sql, adr)
myresult = mycursor.fetchall()
for x in myresult:
	print(x)

/* ========================================================= */
/* --- COSE DA NON FARE --- */
/* ========================================================= */

/* ERRORE: Costruire query concatenando input utente */

/* --- ESEMPIO 1: QUERY SEMPLICE --- */

Scanner in = new Scanner(System.in);
String categoria = in.nextLine();
String sql = "SELECT * FROM Users WHERE UserId = " + s + ";";

/* --- ATTACCO --- */

-- Input utente: 100 OR 1=1

-- Query risultante:
SELECT * FROM Users WHERE UserId = 100 OR 1=1;

-- Effetto: Restituisce TUTTI gli utenti


/* ========================================================= */
/* --- ESEMPIO 2: LOGIN --- */
/* ========================================================= */

String user = in.nextLine();
String password = in.nextLine();
String sql = "SELECT * FROM Users WHERE " +
	"Name ='" + user + "' AND Pass ='" + password + "';";

/* --- ATTACCO --- */

-- Input:	
# user: ' or ''='
# password: ' or ''='

-- Query risultante:
SELECT * FROM Users WHERE
Name ='' or ''='' AND Pass ='' or ''='';

-- Effetto: Login bypass (entra senza password)


/* ========================================================= */
/* --- ESEMPIO 3: QUERY CON STRINGHE --- */
/* ========================================================= */

String categoria = in.nextLine();
String sql = "SELECT name, description, price " +
"FROM products WHERE category = '" + categoria + "'";


/* --- ATTACCO --- */

-- Input: ' OR '1'='1

-- Query risultante:
SELECT name, description, price
FROM products
WHERE category = '' OR '1'='1';

-- Effetto: Restituisce TUTTI i prodotti


/* ========================================================= */
/* --- ESEMPIO 4: ATTACCO DISTRUTTIVO --- */
/* ========================================================= */

String sql = "SELECT * FROM Users WHERE UserId = " + s + ";";


/* --- ATTACCO --- */

-- Input: 100; DROP TABLE customers

-- Query risultante:
SELECT * FROM Users WHERE UserId = 100; DROP TABLE customers;

-- Effetto: Esegue una query + cancella una tabella


/* --- COME EVITARE --- */

# NON concatenare input utente
# usare PreparedStatement
# usare query parametrizzate

/* ========================================================= */
/* --- OBJECT RELATIONAL MAPPING (ORM) --- */
/* ========================================================= */

/*
Serve per collegare:
- oggetti (classi)
- database relazionali (tabelle)

Idea:
lavoro con oggetti invece di scrivere SQL
*/


/* --- CONFRONTO --- */

-- Senza ORM:
String sql = "SELECT ... FROM persons WHERE id = 10";
Statement stmt = con.createStatement();
ResultSet res = stmt.executeQuery(sql);
String name = res.getString("FIRST_NAME");


-- Con ORM:
Person p = repository.GetPerson(10);
String name = p.FirstName;


/* --- ORM: LIMITI --- 
# NON sostituisce SQL
# serve conoscere il database

Problemi:
- meno efficiente in alcuni casi
- difficile per query complesse

*/


/* --- COSA FA ORM ---

# converte oggetti in valori scalari
# gestisce relazioni tra oggetti

*/

/* ========================================================= */
/* --- FRAMEWORK --- */
/* ========================================================= */

-- Java:
# JPA
# Hibernate
# EclipseLink
# TopLink

-- .NET:
# LINQ to SQL
# Entity Framework
# NHibernate


/* --- HIBERNATE / NHIBERNATE --- 

- implementazione ORM
- Java (Hibernate)
- C# (NHibernate)
- supporta molti DBMS

 --> CONFIGURAZIONE:

# Serve specificare:
- tipo di implementazione JPA
- provider di connessione
- dati di connessione
- strategia creazione tabelle
- entità da gestire

# Possibili modi:
- runtime
- file di configurazione

*/


/* ========================================================= */
/* --- MAPPING --- */
/* ========================================================= */

/* Problema: collegare classe ↔ tabella
*/

public class Studente 
{
	private long idStud;
}


/* --- CHIAVE PRIMARIA --- */

@Id
@GeneratedValue(strategy = GenerationType.AUTO)
private long idStud;


/* --- MAPPING COMPLETO --- */

@Entity
@Table(name = "Studente")
public class Studente {

	@Id
	@Column(name = "idStud")
	private long idStud;

	@Column(name = "nome")
	String nome;
}

/* ========================================================= */
/* --- COMPONENTI PRINCIPALI --- */
/* ========================================================= */

-- EntityManagerFactory
# inizializza il sistema
# operazione pesante
# una sola per applicazione

-- EntityManager
# connessione al DB
# operazioni sui dati

-- EntityTransaction
# gestisce transazioni

-- Query
# usa linguaggio JPQL


/* ========================================================= */
/* --- PERSIST vs MERGE --- */
/* ========================================================= */

-- persist()
# nuova entità
# INSERT

-- merge()
# entità nuova o esistente
# INSERT o UPDATE

# sempre dentro una transazione


/* ========================================================= */
/* --- OTTENERE DATI --- */
/* ========================================================= */

-- per chiave primaria
Employee employee = em.find(Employee.class, 1);

-- query
Query q1 = em.createQuery(...);

-- criteria query
CriteriaBuilder cb = em.getCriteriaBuilder();
CriteriaQuery<Country> q = cb.createQuery(Country.class);


/* ========================================================= */
/* --- ACCESSO LAZY --- */
/* ========================================================= */

# dati caricati solo quando servono

@OneToMany(fetch = FetchType.LAZY)


/* ========================================================= */
/* --- TRIGGER / STORED PROCEDURE --- */
/* ========================================================= */

# Trigger (eventi)
@PreUpdate
@PrePersist

# Stored procedure
# non si creano con JPA
# si possono chiamare


/* ========================================================= */
/* --- VERSIONI --- */
/* ========================================================= */

# traccia modifiche oggetti

@Audited


/* ========================================================= */
/* --- ORM: LIMITI PRATICI --- */
/* ========================================================= */

# difficile da usare
# curva di apprendimento alta
# a volte inutile per cose semplici


/* ========================================================= */
/* --- MICRO-ORM --- */
/* ========================================================= */

# alternativa più semplice
# usa JDBC
# permette anche SQL diretto


/* ========================================================= */
/* --- ESEMPIO MICRO-ORM --- */
/* ========================================================= */

Database db = new Database();
db.setJdbcUrl(STRINGA_JDBC);
db.setUser("root");
db.setPassword("password");


/* --- INSERIMENTO --- */

Employee joe = new Employee();
joe.firstName = "Joe";
joe.lastName = "Doe";
db.insert(joe);


/* --- QUERY --- */

List<Employee> employees =
	db.where("lastname=?", "Doe")
	  .results(Employee.class);


/* --- DELETE --- */

db.delete(joe);


/* --- SQL DIRETTO --- */

db.sql("SELECT ...").results();


/* --- TRANSAZIONI --- */

Transaction trans = db.startTransaction();

try {
	db.transaction(trans).insert(row1);
	trans.commit();
}
catch (Throwable t) {
	trans.rollback();
}

