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
