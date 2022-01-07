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

    @Override
    public String toString() {
        return "Agency{" +
                "sqlType='" + sqlType + '\'' +
                ", agencyNo=" + agencyNo +
                ", aName='" + aName + '\'' +
                ", loc=" + loc +
                ", listRefEmp=" + listRefEmp +
                ", listRefClient=" + listRefClient +
                '}';
    }
}
