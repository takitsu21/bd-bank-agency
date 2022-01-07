import oracle.sql.ARRAY;

import java.sql.Array;
import java.sql.SQLData;
import java.sql.SQLException;

public class Transaction implements SQLData {
    private String sql_type ;
    private int deptno;
    private String dname;
    private String loc;
    private Array listRefEmp;

    public Transaction (){}

    public Transaction(String sql_type, int deptno,String dname, String loc, ARRAY listRefEmp ){
        this.sql_type=sql_type;
        this.deptno=deptno ;
        this.dname=dname;
        this.loc=loc;
        this.listRefEmp=listRefEmp;
    }


    /**
     * @return the deptno
     */
    public int getDeptno() {
        return deptno;
    }

    /**
     * @param deptno the deptno to set
     */
    public void setDeptno(int deptno) {
        this.deptno = deptno;
    }

    /**
     * @return the dname
     */
    public String getDname() {
        return dname;
    }

    /**
     * @param dname the dname to set
     */
    public void setDname(String dname) {
        this.dname = dname;
    }

    /**
     * @return the loc
     */
    public String getLoc() {
        return loc;
    }

    /**
     * @param loc the loc to set
     */
    public void setLoc(String loc) {
        this.loc = loc;
    }

    /**
     * @return the ListRefEmp
     */
    public ARRAY getListRefEmp() {
        return listRefEmp;
    }

    /**
     * @param ListRefEmp the loc to set
     */
    public void setListRefEmp(ARRAY listRefEmp) {
        this.listRefEmp = listRefEmp;
    }


    public String getSQLTypeName()throws SQLException {
        return sql_type;
    }

    /**
     Lire dans le flot dans l'ordre.

     */
    public void readSQL(SQLInput stream, String typeName) throws SQLException{
        sql_type=typeName;
        deptno=stream.readInt();
        dname=stream.readString();
        loc=stream.readString();
        listRefEmp=(ARRAY) stream.readArray();
    }

    /*
        Ecrire dans le flot dans l'ordre.
    */
    public void writeSQL(SQLOutput stream) throws SQLException{
        stream.writeInt(deptno);
        stream.writeString(dname);
        stream.writeString(loc);
        stream.writeArray(listRefEmp);

    }

    public void display() throws SQLException{
        System.out.println("");
        System.out.println("{");
        System.out.println("deptno = "+this.getDeptno());
        System.out.println("dname = "+this.getDname());
        System.out.println("loc = "+this.getLoc());
        this.displayInfoEmployesDept();
        System.out.println("}");
        System.out.println("");


    }
    public void displayInfoEmployesDept() throws SQLException{
        // affichage des prénoms
        Ref [] lesRefDesEmployes= (Ref[])this.getListRefEmp().getArray();
        //System.out.println("Prenoms = "+this.getPrenoms().stringValue());
        System.out.println("<Employes:");
        for (Ref lesRefDesEmploye : lesRefDesEmployes) {
            Employe emp1 = (Employe) lesRefDesEmploye.getObject();
            System.out.println("   [empno="+emp1.getEmpno()+" ename="+emp1.getEname()+"]");

        }
        System.out.println(">");
    }
}
