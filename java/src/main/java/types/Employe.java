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
