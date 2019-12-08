
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
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
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
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		if (username.isEmpty() || password.isEmpty()) {
			response.sendRedirect("login.jsp?login=empty");
		}
		
		try {
		ConnectDB db = new ConnectDB();
		Connection conn = db.getConnection();
		
		String qry = "select Username,Password,AccountType,Name from Account where Username=? and Password=?";
		
		PreparedStatement stmt = conn.prepareStatement(qry);
		stmt.setString(1, username); 
		stmt.setString(2, password); 
		ResultSet rs = stmt.executeQuery();
	
		
		if (rs.next()) {
			String nm = rs.getString("Name");
			HttpSession session = request.getSession();
			if (rs.getString("AccountType").contentEquals("Customer")) {
				session.setAttribute("type", "Customer");
				response.sendRedirect("home.jsp?account=on");
			}
			else if (rs.getString("AccountType").contentEquals("admin")) {
			{
				session.setAttribute("type", "admin");
				response.sendRedirect("AdminHome.jsp");
			}

			} else {
				session.setAttribute("type", "employee");
				response.sendRedirect("EmployeeHome.jsp?account=on");
				
			}

			session.setAttribute("username", username);

		} else {
			response.sendRedirect("login.jsp?login=fail");
		}
		
		rs.close();
		stmt.close();
		db.closeConnection(conn);
		
		}catch (SQLException e) {
		e.printStackTrace();
	}

	}
}