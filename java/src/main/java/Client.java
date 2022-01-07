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
}
