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
