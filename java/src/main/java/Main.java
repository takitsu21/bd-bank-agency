import java.sql.*;
import java.util.Map;

public class Main {
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        Class.forName("oracle.jdbc.driver.OracleDriver");

        Connection conn = DriverManager.getConnection(
                "jdbc:oracle:thin:@(DESCRIPTION =\r\n"
                        + "    (ADDRESS_LIST =\r\n"
                        + "      (ADDRESS = (PROTOCOL = TCP)(HOST = 144.21.67.201)(PORT = 1521))\r\n"
                        + "    )\r\n"
                        + "    (CONNECT_DATA =\r\n"
                        + "      (SERVER = DEDICATED)\r\n"
                        + "      (SERVICE_NAME = pdbm1inf.631174089.oraclecloud.internal)\r\n"
                        + "    )\r\n"
                        + "  )", "Batisse1I2122", "Batisse1I212201");
        System.out.println(conn);

        Statement stmt = conn.createStatement();

        String queryEmp = "SELECT value(oe) FROM o_employe oe";

        String queryLoc = "SELECT value(ol) FROM o_location ol";

        Map mapOraObjType = conn.getTypeMap();

//        mapOraObjType.put((Object)"BATISSE1I2122.EMPLOYE_T", (Object)Class.forName("Employe"));
//        mapOraObjType.put((Object)"BATISSE1I2122.DEPT_T", (Object)Class.forName("test.Dept" ));

        mapOraObjType.put((Object) "BATISSE1I2122.LOCATION_T", (Object) Class.forName("Location"));
//        ResultSet resultSet = stmt.executeQuery(queryEmp);
        ResultSet resultSet = stmt.executeQuery(queryLoc);
        while (resultSet.next()) {
//            Employe emp = (Employe) resultSet.getObject(1);
//            System.out.println(emp);
            Location location = (Location) resultSet.getObject(1);
            System.out.println(location);
        }
    }
}
