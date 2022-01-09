/*
Sabatier, Juliette Participant 1:	, Activités paricipant1
Batisse, Dylann Participant 2:	    , Activités paricipant2
Brault, Yann Participant 3:			, Activités paricipant3
Cousson, Antoine Participant 4:     , Activités paricipant4
*/

/*

3.	Mapping des objets complexes Oracle avec Java / JDBC
3.1	Actvités à faire

Vous devez ici effectuer le mapping des objets complexes Oracle avec Java/JDBC end développant dans java des classes personalisées. Vous devez aussi écrire les programmes de test correspondants. Le chapitre 14 de mon cours le document Oracle.
Livres Oracle pouvant entre autre aider :
-	Object-Relational Developer's Guide
https://docs.oracle.com/en/database/oracle/oracle-database/21/adobj/object-relational-developers-guide.pdf

-	JDBC Developer's Guide
https://docs.oracle.com/en/database/oracle/oracle-database/21/jjdbc/jdbc-developers-guide.pdf
3.2	Travail à rendre (04/01/2022)
Le travail à rendre doit être dans le fichier :
4Script_Mapping_objet_Relationnel_avec_Jdbc_NomProjet_Nom1_Nom2_Nom3_Nom4.sql


*/



-- Ce fichier regroupe les classes présentes dans le dossier java,
--nous les avons mis dans ce fichier pour être en accord avec les spécification du sujet,
--pour executer le code veuillez trouver le main dans le directory "java" (projet maven).




-- Main

import types.Location;

import java.sql.*;
import java.util.Map;

public class Main {
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        Class.forName("oracle.jdbc.driver.OracleDriver");

        Connection conn = DriverManager.getConnection(
                "jdbc:oracle:thin:@(DESCRIPTION =\r\n"
                        + "    (ADDRESS_LIST =\r\n"
                        + "      (ADDRESS = (PROTOCOL = TCP)(HOST = 144.21.67.201)(PORT = 1521))\r\n"
                        + "    )\r\n"
                        + "    (CONNECT_DATA =\r\n"
                        + "      (SERVER = DEDICATED)\r\n"
                        + "      (SERVICE_NAME = pdbm1inf.631174089.oraclecloud.internal)\r\n"
                        + "    )\r\n"
                        + "  )", "Batisse1I2122", "Batisse1I212201");
        System.out.println(conn);

        Statement stmt = conn.createStatement();

        String queryEmp = "SELECT value(oe) FROM o_employe oe";

        String queryLoc = "SELECT value(ol) FROM o_location ol";

        Map mapOraObjType = conn.getTypeMap();

//        mapOraObjType.put((Object)"BATISSE1I2122.EMPLOYE_T", (Object)Class.forName("types.Employe"));
//        mapOraObjType.put((Object)"BATISSE1I2122.DEPT_T", (Object)Class.forName("test.Dept" ));

        mapOraObjType.put((Object) "BATISSE1I2122.LOCATION_T", (Object) Class.forName("types.Location"));
//        ResultSet resultSet = stmt.executeQuery(queryEmp);
        ResultSet resultSet = stmt.executeQuery(queryLoc);
        while (resultSet.next()) {
//            types.Employe emp = (types.Employe) resultSet.getObject(1);
//            System.out.println(emp);
            Location location = (Location) resultSet.getObject(1);
            System.out.println(location);
        }
    }
}




--- types de la base de données

---Account

package types;

import java.sql.*;

public class Account implements SQLData {
    private String sqlType;
    private int accountNo;
    private String accountType;
    private float balance;
    private float bankceiling;
    private Array statements;
    private Ref refAgency;

    public int getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(int accountNo) {
        this.accountNo = accountNo;
    }

    public String getAccountType() {
        return accountType;
    }

    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }

    public float getBalance() {
        return balance;
    }

    public void setBalance(float balance) {
        this.balance = balance;
    }

    public float getBankceiling() {
        return bankceiling;
    }

    public void setBankceiling(float bankceiling) {
        this.bankceiling = bankceiling;
    }

    public Array getStatements() {
        return statements;
    }

    public void setStatements(Array statements) {
        this.statements = statements;
    }

    public Ref getRefAgency() {
        return refAgency;
    }

    public void setRefAgency(Ref refAgency) {
        this.refAgency = refAgency;
    }

    @Override
    public String getSQLTypeName() throws SQLException {
        return sqlType;
    }

    @Override
    public void readSQL(SQLInput stream, String typeName) throws SQLException {
        this.sqlType = typeName;
        this.accountNo = stream.readInt();
        this.accountType = stream.readString();
        this.balance = stream.readFloat();
        this.bankceiling = stream.readFloat();
        this.statements = stream.readArray();
        this.refAgency = stream.readRef();
    }

    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(accountNo);
        stream.writeString(accountType);
        stream.writeFloat(balance);
        stream.writeFloat(bankceiling);
        stream.writeArray(statements);
        stream.writeRef(refAgency);
    }
}

--- Transaction

package types;

import java.sql.*;

public class Transaction implements SQLData {
    private String sqlType;
    private int tNum;
    private Ref issuer;
    private Ref refAccIssuer;
    private Ref payee;
    private Ref refAccPayee;
    private float amount;


    public Transaction() {
    }

    public Transaction(String sqlType, int tNum, Ref issuer, Ref refAccIssuer, Ref payee, Ref refAccPayee, float amount) {
        this.sqlType = sqlType;
        this.tNum = tNum;
        this.issuer = issuer;
        this.refAccIssuer = refAccIssuer;
        this.payee = payee;
        this.refAccPayee = refAccPayee;
        this.amount = amount;
    }

    public int gettNum() {
        return tNum;
    }

    public void settNum(int tNum) {
        this.tNum = tNum;
    }

    public Ref getIssuer() {
        return issuer;
    }

    public void setIssuer(Ref issuer) {
        this.issuer = issuer;
    }

    public Ref getRefAccIssuer() {
        return refAccIssuer;
    }

    public void setRefAccIssuer(Ref refAccIssuer) {
        this.refAccIssuer = refAccIssuer;
    }

    public Ref getPayee() {
        return payee;
    }

    public void setPayee(Ref payee) {
        this.payee = payee;
    }

    public Ref getRefAccPayee() {
        return refAccPayee;
    }

    public void setRefAccPayee(Ref refAccPayee) {
        this.refAccPayee = refAccPayee;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    @Override
    public String getSQLTypeName() throws SQLException {
        return sqlType;
    }

    public void readSQL(SQLInput stream, String typeName) throws SQLException {
        sqlType = typeName;
        tNum = stream.readInt();
        issuer = stream.readRef();
        refAccIssuer = stream.readRef();
        payee = stream.readRef();
        refAccPayee = stream.readRef();
        amount = stream.readFloat();
    }

    /*
        Ecrire dans le flot dans l'ordre.
    */
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(tNum);
        stream.writeRef(issuer);
        stream.writeRef(refAccIssuer);
        stream.writeRef(payee);
        stream.writeRef(refAccPayee);
        stream.writeFloat(amount);
    }
}







--- Agency

package types;

import java.sql.*;

public class Agency implements SQLData {
    private String sqlType;
    private int agencyNo;
    private String aName;
    private Ref loc;
    private Array listRefEmp;
    private Array listRefClient;

    public Agency() {

    }

    public Agency(String sqlType, int agencyNo, String aName, Ref loc, Array listRefEmp, Array listRefClient) {
        this.sqlType = sqlType;
        this.agencyNo = agencyNo;
        this.aName = aName;
        this.loc = loc;
        this.listRefEmp = listRefEmp;
        this.listRefClient = listRefClient;
    }

    public int getAgencyNo() {
        return agencyNo;
    }

    public void setAgencyNo(int agencyNo) {
        this.agencyNo = agencyNo;
    }

    public String getaName() {
        return aName;
    }

    public void setaName(String aName) {
        this.aName = aName;
    }

    public Ref getLoc() {
        return loc;
    }

    public void setLoc(Ref loc) {
        this.loc = loc;
    }

    public Array getListRefEmp() {
        return listRefEmp;
    }

    public void setListRefEmp(Array listRefEmp) {
        this.listRefEmp = listRefEmp;
    }

    public Array getListRefClient() {
        return listRefClient;
    }

    public void setListRefClient(Array listRefClient) {
        this.listRefClient = listRefClient;
    }

    @Override
    public String getSQLTypeName() throws SQLException {
        return sqlType;
    }

    @Override
    public void readSQL(SQLInput stream, String typeName) throws SQLException {
        this.sqlType = typeName;
        this.agencyNo = stream.readInt();
        this.aName = stream.readString();
        this.loc =  stream.readRef();
        this.listRefEmp = stream.readArray();
        this.listRefClient = stream.readArray();
    }

    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(agencyNo);
        stream.writeString(aName);
        stream.writeRef(loc);
        stream.writeArray(listRefEmp);
        stream.writeArray(listRefClient);
    }
}


--- client



package types;

import java.io.BufferedReader;
import java.sql.*;

public class Client implements SQLData {
    private String sqlType;
    private int numCli;
    private String cName;
    private Array prenoms;
    private String job;
    private float sal;
    private Array listRefAccount;
    private Clob project;
    private Date birthDate;
    private Ref refAgency;


    public Client() {

    }

    public Client(String sqlType, int numCli, String cName, Array prenoms, String job, float sal, Array listRefAccount, Clob project, Date birthDate, Ref refAgency) {
        this.sqlType = sqlType;
        this.numCli = numCli;
        this.cName = cName;
        this.prenoms = prenoms;
        this.job = job;
        this.sal = sal;
        this.listRefAccount = listRefAccount;
        this.project = project;
        this.birthDate = birthDate;
        this.refAgency = refAgency;
    }

    public String getSqlType() {
        return sqlType;
    }

    public void setSqlType(String sqlType) {
        this.sqlType = sqlType;
    }

    public int getNumCli() {
        return numCli;
    }

    public void setNumCli(int numCli) {
        this.numCli = numCli;
    }

    public String getcName() {
        return cName;
    }

    public void setcName(String cName) {
        this.cName = cName;
    }

    public Array getPrenoms() {
        return prenoms;
    }

    public void setPrenoms(Array prenoms) {
        this.prenoms = prenoms;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public float getSal() {
        return sal;
    }

    public void setSal(float sal) {
        this.sal = sal;
    }

    public Array getListRefAccount() {
        return listRefAccount;
    }

    public void setListRefAccount(Array listRefAccount) {
        this.listRefAccount = listRefAccount;
    }

    public Clob getProject() {
        return project;
    }

    public void setProject(Clob project) {
        this.project = project;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public Ref getRefAgency() {
        return refAgency;
    }

    public void setRefAgency(Ref refAgency) {
        this.refAgency = refAgency;
    }

    /**
     * Returns the fully-qualified
     * name of the SQL user-defined type that this object represents.
     * This method is called by the JDBC driver to get the name of the
     * UDT instance that is being mapped to this instance of
     * {@code SQLData}.
     *
     * @return the type name that was passed to the method {@code readSQL}
     * when this object was constructed and populated
     * @throws SQLException                    if there is a database access error
     * @throws SQLFeatureNotSupportedException if the JDBC driver does not support
     *                                         this method
     * @since 1.2
     */
    @Override
    public String getSQLTypeName() throws SQLException {
        return sqlType;
    }

    /**
     * Populates this object with data read from the database.
     * The implementation of the method must follow this protocol:
     * <UL>
     * <LI>It must read each of the attributes or elements of the SQL
     * type  from the given input stream.  This is done
     * by calling a method of the input stream to read each
     * item, in the order that they appear in the SQL definition
     * of the type.
     * <LI>The method {@code readSQL} then
     * assigns the data to appropriate fields or
     * elements (of this or other objects).
     * Specifically, it must call the appropriate <i>reader</i> method
     * ({@code SQLInput.readString}, {@code SQLInput.readBigDecimal},
     * and so on) method(s) to do the following:
     * for a distinct type, read its single data element;
     * for a structured type, read a value for each attribute of the SQL type.
     * </UL>
     * The JDBC driver initializes the input stream with a type map
     * before calling this method, which is used by the appropriate
     * {@code SQLInput} reader method on the stream.
     *
     * @param stream   the {@code SQLInput} object from which to read the data for
     *                 the value that is being custom mapped
     * @param typeName the SQL type name of the value on the data stream
     * @throws SQLException                    if there is a database access error
     * @throws SQLFeatureNotSupportedException if the JDBC driver does not support
     *                                         this method
     * @see SQLInput
     * @since 1.2
     */
    @Override
    public void readSQL(SQLInput stream, String typeName) throws SQLException {
        this.sqlType = typeName;
        this.numCli = stream.readInt();
        this.cName = stream.readString();
        this.prenoms = stream.readArray();
        this.job = stream.readString();
        this.sal = stream.readFloat();
        this.listRefAccount = stream.readArray();
        this.project = stream.readClob();
        this.birthDate = stream.readDate();
        this.refAgency = stream.readRef();
    }

    /**
     * Writes this object to the given SQL data stream, converting it back to
     * its SQL value in the data source.
     * The implementation of the method must follow this protocol:<BR>
     * It must write each of the attributes of the SQL type
     * to the given output stream.  This is done by calling a
     * method of the output stream to write each item, in the order that
     * they appear in the SQL definition of the type.
     * Specifically, it must call the appropriate {@code SQLOutput} writer
     * method(s) ({@code writeInt}, {@code writeString}, and so on)
     * to do the following: for a Distinct Type, write its single data element;
     * for a Structured Type, write a value for each attribute of the SQL type.
     *
     * @param stream the {@code SQLOutput} object to which to write the data for
     *               the value that was custom mapped
     * @throws SQLException                    if there is a database access error
     * @throws SQLFeatureNotSupportedException if the JDBC driver does not support
     *                                         this method
     * @see SQLOutput
     * @since 1.2
     */
    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(numCli);
        stream.writeString(cName);
        stream.writeArray(prenoms);
        stream.writeString(job);
        stream.writeFloat(sal);
        stream.writeArray(listRefAccount);
        stream.writeClob(project);
        stream.writeDate(birthDate);
        stream.writeRef(refAgency);
    }

    public void displayClientProject() throws java.sql.SQLException, java.io.IOException {
        BufferedReader clobReader;
        clobReader = new BufferedReader(this.getProject().getCharacterStream());
        String ligne;
        System.out.println("");
        System.out.println("[ <PROJECT/ ");
        while ((ligne = clobReader.readLine()) != null) {
            System.out.println("   " + ligne);
        }
        System.out.println(" /CV>] ");
        System.out.println("");
    }
}



-- LOCATION

package types;

import java.sql.*;

public class Location implements SQLData {
    private String sqlType;
    private String country;
    private String city;
    private String streetName;
    private int streetNo;

    public Location() {
    }

    public Location(String sqlType, String country, String city, String streetName, int streetNo) {
        this.sqlType = sqlType;
        this.country = country;
        this.city = city;
        this.streetName = streetName;
        this.streetNo = streetNo;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getStreetName() {
        return streetName;
    }

    public void setStreetName(String streetName) {
        this.streetName = streetName;
    }

    public int getStreetNo() {
        return streetNo;
    }

    public void setStreetNo(int streetNo) {
        this.streetNo = streetNo;
    }

    /**
     * Returns the fully-qualified
     * name of the SQL user-defined type that this object represents.
     * This method is called by the JDBC driver to get the name of the
     * UDT instance that is being mapped to this instance of
     * {@code SQLData}.
     *
     * @return the type name that was passed to the method {@code readSQL}
     * when this object was constructed and populated
     * @throws SQLException                    if there is a database access error
     * @throws SQLFeatureNotSupportedException if the JDBC driver does not support
     *                                         this method
     * @since 1.2
     */
    @Override
    public String getSQLTypeName() throws SQLException {
        return sqlType;
    }

    /**
     * Populates this object with data read from the database.
     * The implementation of the method must follow this protocol:
     * <UL>
     * <LI>It must read each of the attributes or elements of the SQL
     * type  from the given input stream.  This is done
     * by calling a method of the input stream to read each
     * item, in the order that they appear in the SQL definition
     * of the type.
     * <LI>The method {@code readSQL} then
     * assigns the data to appropriate fields or
     * elements (of this or other objects).
     * Specifically, it must call the appropriate <i>reader</i> method
     * ({@code SQLInput.readString}, {@code SQLInput.readBigDecimal},
     * and so on) method(s) to do the following:
     * for a distinct type, read its single data element;
     * for a structured type, read a value for each attribute of the SQL type.
     * </UL>
     * The JDBC driver initializes the input stream with a type map
     * before calling this method, which is used by the appropriate
     * {@code SQLInput} reader method on the stream.
     *
     * @param stream   the {@code SQLInput} object from which to read the data for
     *                 the value that is being custom mapped
     * @param typeName the SQL type name of the value on the data stream
     * @throws SQLException                    if there is a database access error
     * @throws SQLFeatureNotSupportedException if the JDBC driver does not support
     *                                         this method
     * @see SQLInput
     * @since 1.2
     */
    @Override
    public void readSQL(SQLInput stream, String typeName) throws SQLException {
        this.sqlType = typeName;
        this.country = stream.readString();
        this.city = stream.readString();
        this.streetName = stream.readString();
        this.streetNo = stream.readInt();
    }


    /*
        Ecrire dans le flot dans l'ordre.
    */
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeString(country);
        stream.writeString(city);
        stream.writeString(streetName);
        stream.writeInt(streetNo);

    }


    @Override
    public String toString() {
        return "types.Location{" +
                "country='" + country + '\'' +
                ", city='" + city + '\'' +
                ", streetName='" + streetName + '\'' +
                ", streetNo=" + streetNo +
                '}';
    }
}


--- employe

package types;

import java.io.BufferedReader;
import java.sql.*;

public class Employe implements SQLData {
    private String sqlType;
    private int empNo;
    private String eName;
    private Array prenoms;
    private String job;
    private float sal;
    private Clob cv;
    private Date birthDate;
    private Date employementDate;
    private Ref refAgency;

    public Employe() {
    }

    public Employe(String sqlType, int empNo, String eName, Array prenoms, String job, float sal, Clob cv, Date birthDate, Date employementDate, Ref refAgency) {
        this.sqlType = sqlType;
        this.empNo = empNo;
        this.eName = eName;
        this.prenoms = prenoms;
        this.job = job;
        this.sal = sal;
        this.cv = cv;
        this.birthDate = birthDate;
        this.employementDate = employementDate;
        this.refAgency = refAgency;
    }

    public String getSqlType() {
        return sqlType;
    }

    public void setSqlType(String sqlType) {
        this.sqlType = sqlType;
    }

    public int getEmpNo() {
        return empNo;
    }

    public void setEmpNo(int empNo) {
        this.empNo = empNo;
    }

    public String geteName() {
        return eName;
    }

    public void seteName(String eName) {
        this.eName = eName;
    }

    public Array getPrenoms() {
        return prenoms;
    }

    public void setPrenoms(Array prenoms) {
        this.prenoms = prenoms;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public float getSal() {
        return sal;
    }

    public void setSal(float sal) {
        this.sal = sal;
    }

    public Clob getCv() {
        return cv;
    }

    public void setCv(Clob cv) {
        this.cv = cv;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public Date getEmployementDate() {
        return employementDate;
    }

    public void setEmployementDate(Date employementDate) {
        this.employementDate = employementDate;
    }

    public Ref getRefAgency() {
        return refAgency;
    }

    public void setRefAgency(Ref refAgency) {
        this.refAgency = refAgency;
    }

    /**
     * Returns the fully-qualified
     * name of the SQL user-defined type that this object represents.
     * This method is called by the JDBC driver to get the name of the
     * UDT instance that is being mapped to this instance of
     * {@code SQLData}.
     *
     * @return the type name that was passed to the method {@code readSQL}
     * when this object was constructed and populated
     * @throws SQLException                    if there is a database access error
     * @throws SQLFeatureNotSupportedException if the JDBC driver does not support
     *                                         this method
     * @since 1.2
     */
    @Override
    public String getSQLTypeName() throws SQLException {
        return sqlType;
    }

    /**
     * Populates this object with data read from the database.
     * The implementation of the method must follow this protocol:
     * <UL>
     * <LI>It must read each of the attributes or elements of the SQL
     * type  from the given input stream.  This is done
     * by calling a method of the input stream to read each
     * item, in the order that they appear in the SQL definition
     * of the type.
     * <LI>The method {@code readSQL} then
     * assigns the data to appropriate fields or
     * elements (of this or other objects).
     * Specifically, it must call the appropriate <i>reader</i> method
     * ({@code SQLInput.readString}, {@code SQLInput.readBigDecimal},
     * and so on) method(s) to do the following:
     * for a distinct type, read its single data element;
     * for a structured type, read a value for each attribute of the SQL type.
     * </UL>
     * The JDBC driver initializes the input stream with a type map
     * before calling this method, which is used by the appropriate
     * {@code SQLInput} reader method on the stream.
     *
     * @param stream   the {@code SQLInput} object from which to read the data for
     *                 the value that is being custom mapped
     * @param typeName the SQL type name of the value on the data stream
     * @throws SQLException                    if there is a database access error
     * @throws SQLFeatureNotSupportedException if the JDBC driver does not support
     *                                         this method
     * @see SQLInput
     * @since 1.2
     */
    @Override
    public void readSQL(SQLInput stream, String typeName) throws SQLException {
        this.sqlType = typeName;
        this.empNo = stream.readInt();
        this.eName = stream.readString();
        this.prenoms = stream.readArray();
        this.job = stream.readString();
        this.sal = stream.readFloat();
        this.cv = stream.readClob();
        this.birthDate = stream.readDate();
        this.employementDate = stream.readDate();
        this.refAgency = stream.readRef();
    }


    /*
        Ecrire dans le flot dans l'ordre.
    */
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(empNo);
        stream.writeString(eName);
        stream.writeArray(prenoms);
        stream.writeString(job);
        stream.writeFloat(sal);
        stream.writeClob(cv);
        stream.writeDate(birthDate);
        stream.writeDate(employementDate);
        stream.writeRef(refAgency);

    }

    public void displayCV() throws java.sql.SQLException, java.io.IOException {
        BufferedReader clobReader;
        clobReader = new BufferedReader(this.getCv().getCharacterStream());
        String ligne;
        System.out.println("");
        System.out.println("[ <CV/ ");
        while ((ligne = clobReader.readLine()) != null) {
            System.out.println("   " + ligne);
        }
        System.out.println(" /CV>] ");
        System.out.println("");
    }

    @Override
    public String toString() {
        return "types.Employe{" +
                "sqlType='" + sqlType + '\'' +
                ", empNo=" + empNo +
                ", eName='" + eName + '\'' +
                ", prenoms=" + prenoms +
                ", job='" + job + '\'' +
                ", sal=" + sal +
                ", cv=" + cv +
                ", birthDate=" + birthDate +
                ", employementDate=" + employementDate +
                ", refAgency=" + refAgency +
                '}';
    }
}
