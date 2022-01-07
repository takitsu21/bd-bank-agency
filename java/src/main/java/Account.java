import java.sql.SQLData;
import java.sql.*;
public class Account implements SQLData {
    private String sqlType;
    private int accountNo;
    private String accountType;
    private float balance;
    private float bankceiling;
    private Array statements;
    private Agency refAgency;

    public String getSqlType() {
        return sqlType;
    }

    public void setSqlType(String sqlType) {
        this.sqlType = sqlType;
    }

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

    public Agency getRefAgency() {
        return refAgency;
    }

    public void setRefAgency(Agency refAgency) {
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
        this.accountType  = stream.readString();
        this.balance = stream.readFloat();
        this.bankceiling = stream.readFloat();
        this.statements = stream.readArray();
        this.refAgency = (Agency) stream.readObject();
    }

    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {

    }
}
