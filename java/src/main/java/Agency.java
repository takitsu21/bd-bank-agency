import java.sql.*;

public class Agency implements SQLData {
    private String sqlType;
    private int agencyNo;
    private String aName;
    private Location loc;
    private Array listRefEmp;


    public Agency(String sqlType, int agencyNo, String aName, Location loc, Array listRefEmploye_t) {
        this.sqlType = sqlType;
        this.agencyNo = agencyNo;
        this.aName = aName;
        this.loc = loc;
        this.listRefEmp = listRefEmploye_t;
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

    public Location getLoc() {
        return loc;
    }

    public void setLoc(Location loc) {
        this.loc = loc;
    }

    public Array getListRefEmp() {
        return listRefEmp;
    }

    public void setListRefEmp(Array listRefEmp) {
        this.listRefEmp = listRefEmp;
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
        this.loc = (Location) stream.readObject();
        this.listRefEmp = stream.readArray();

    }

    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
    stream.writeInt(agencyNo);
    stream.writeString(aName);
    stream.writeObject(loc);
    stream.writeArray(listRefEmp);

    }

    @Override
    public String toString() {
        return "Agency{" +
                "sqlType='" + sqlType + '\'' +
                ", agencyNo=" + agencyNo +
                ", aName='" + aName + '\'' +
                ", loc=" + loc +
                ", listRefEmp=" + listRefEmp +
                '}';
    }
}
