import java.sql.*;

public class Transaction implements SQLData {
    private String sql_type ;
    private int tNum;
    private Client issuer;
    private Client payee ;
    private float amount ;


    public Transaction (){}

    public Transaction(String sql_type, int tNum, Client issuer, Client payee, float amount) {
        this.sql_type = sql_type;
        this.tNum = tNum;
        this.issuer = issuer;
        this.payee = payee;
        this.amount = amount;
    }


    public String getSql_type() {
        return sql_type;
    }

    public void setSql_type(String sql_type) {
        this.sql_type = sql_type;
    }

    public int gettNum() {
        return tNum;
    }

    public void settNum(int tNum) {
        this.tNum = tNum;
    }

    public Client getIssuer() {
        return issuer;
    }

    public void setIssuer(Client issuer) {
        this.issuer = issuer;
    }

    public Client getPayee() {
        return payee;
    }

    public void setPayee(Client payee) {
        this.payee = payee;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    @Override
    public String getSQLTypeName() throws SQLException {
        return null;
    }

    public void readSQL(SQLInput stream, String typeName) throws SQLException{
        sql_type=typeName;
        tNum = stream.readInt();
        issuer = (Client) stream.readObject();
        payee = (Client) stream.readObject();
        amount = stream.readFloat();
    }

    /*
        Ecrire dans le flot dans l'ordre.
    */
    public void writeSQL(SQLOutput stream) throws SQLException{
        stream.writeInt(tNum);
        stream.writeObject((SQLData) issuer);
        stream.writeObject((SQLData) payee);
        stream.writeFloat(amount);

    }


}
