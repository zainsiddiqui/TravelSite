import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fp.ConnectDB;

/**
 * Servlet implementation class Signup
 */
@WebServlet("/Signup")
public class Signup extends HttpServlet {
private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Signup() {
        super();
    }

/**
* @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
*/
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
response.getWriter().append("Served at: ").append(request.getContextPath());
}

/**
* @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
*/
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
doGet(request, response);
String firstName = request.getParameter("firstName");
String lastName = request.getParameter("lastName");
String email = request.getParameter("email");
String username = request.getParameter("username");
String password = request.getParameter("password");


if ( firstName.isEmpty()|| lastName.isEmpty() || email.isEmpty() || username.isEmpty() || password.isEmpty()) {
response.sendRedirect("signup.jsp?faults=empty");
return;
}

try {
ConnectDB db = new ConnectDB();
Connection conn = db.getConnection();

String qry = "select email from Account where Email=? ";
PreparedStatement stmt = conn.prepareStatement(qry);
stmt.setString(1, email);
ResultSet rs = stmt.executeQuery();

String qry1 = "select * from Account where Username=?";
PreparedStatement stmt1 = conn.prepareStatement(qry1);
stmt1.setString(1, username);
ResultSet rs1 = stmt1.executeQuery();


if (rs.next()) {
//checking if email is valid
response.sendRedirect("signup.jsp?faults=email");
} else if (rs1.next()) {
//checking if username is valid
response.sendRedirect("signup.jsp?faults=username");
} else {
qry = "insert into Account values (?,?,?,?,?)";
stmt = conn.prepareStatement(qry);
stmt.setString(1, username);
stmt.setString(2, password);
stmt.setString(3, email);
stmt.setString(4, firstName+" "+lastName);
stmt.setString(5, "Customer");
stmt.executeUpdate();

qry = "insert into Customer values (?)";
stmt = conn.prepareStatement(qry);
stmt.setString(1, username);
stmt.executeUpdate();
HttpSession session = request.getSession();
session.setAttribute("type", "Customer");
session.setAttribute("username", username);
response.sendRedirect("home.jsp?account=on");
}
rs.close();
rs1.close();
stmt1.close();
stmt.close();
db.closeConnection(conn);
} catch (SQLException e) {
e.printStackTrace();
}
}

}

