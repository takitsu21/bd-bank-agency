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

    @Override
    public String toString() {
        return "Transaction{" +
                "sqlType='" + sqlType + '\'' +
                ", tNum=" + tNum +
                ", issuer=" + issuer +
                ", refAccIssuer=" + refAccIssuer +
                ", payee=" + payee +
                ", refAccPayee=" + refAccPayee +
                ", amount=" + amount +
                '}';
    }
}
