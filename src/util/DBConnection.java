package util;
import java.sql.*;

public class DBConnection {
    private static Connection connection;

    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/ecommerce_db", "root", "yourpassword"
                );
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return connection;
    }
}
