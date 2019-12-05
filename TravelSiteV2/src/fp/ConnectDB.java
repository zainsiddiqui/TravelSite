package fp;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectDB {

public ConnectDB(){

}

public Connection getConnection(){
String url = "jdbc:mysql://cs336db.curocjyahh92.us-east-2.rds.amazonaws.com:3306/flightSite";
Connection conn = null;

try {
Class.forName("com.mysql.jdbc.Driver");
} catch (ClassNotFoundException e1) {
e1.printStackTrace();
}


try {
conn = DriverManager.getConnection(url,"Group7Databases","Ourproject1234");
} catch (SQLException e1) {
e1.printStackTrace();
}

return conn;

}

public void closeConnection(Connection connection){
try {
connection.close();
} catch (SQLException e) {
e.printStackTrace();
}
}

}