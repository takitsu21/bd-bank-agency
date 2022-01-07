import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Main {
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        Class.forName("oracle.jdbc.driver.OracleDriver" );

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
    }
}
