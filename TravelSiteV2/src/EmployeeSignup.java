

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import fp.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class EmployeeSignup
 */
@WebServlet("/EmployeeSignup")
public class EmployeeSignup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EmployeeSignup() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		doGet(request, response);

		String firstname = request.getParameter("fname");
		String lastname = request.getParameter("lname");
		String ssn = request.getParameter("ssn");
		String email = request.getParameter("email");
		String username = request.getParameter("uname");
		String password = request.getParameter("pass");
		
		
		if (firstname.isEmpty() || lastname.isEmpty() || email.isEmpty() || username.isEmpty() || ssn.isEmpty() || password.isEmpty()) {
			response.sendRedirect("employeeSignup.jsp?faults=empty");
			return;
		}

		try {
			ConnectDB db = new ConnectDB();
			Connection conn = db.getConnection();
			
			String qry = "select email from Account where Email=?";
			PreparedStatement stmt = conn.prepareStatement(qry);
			stmt.setString(1, email); 
			ResultSet rs = stmt.executeQuery();
			
			String qry1 = "select * from Account where Username=?";
			PreparedStatement stmt1 = conn.prepareStatement(qry1);
			stmt1.setString(1, username); 
			ResultSet rs1 = stmt1.executeQuery();
			
			String qry2= "select * from Employee where SSN=?";
			PreparedStatement stmt2 = conn.prepareStatement(qry2);
			stmt2.setString(1, ssn); 
			ResultSet rs2 = stmt2.executeQuery();
			
			if (rs.next()) {
				//check if email exists
				
				response.sendRedirect("employeeSignup.jsp?faults=email");
				
			} else if (rs1.next()) {
				//checking if the username is present
				response.sendRedirect("employeeSignup.jsp?faults=username");
			} else  if (rs2.next()) {
				response.sendRedirect("employeeSignup.jsp?faults=employee");
			} else {
				qry = "insert into Account values (?,?,?,?,?)";
				stmt = conn.prepareStatement(qry);
				stmt.setString(1, username);
				stmt.setString(2, password); 
				stmt.setString(3, email); 
				String name = firstname+" "+lastname;
				stmt.setString(4, name); 
				stmt.setString(5, "Employee"); 
				stmt.executeUpdate();
				
				qry = "insert into Employee values (?,?,?)";
				stmt = conn.prepareStatement(qry);
				stmt.setString(1, username);
				stmt.setString(2, ssn);
				stmt.setString(3, "CustomerRep");
				stmt.executeUpdate();
			//	HttpSession session = request.getSession();
				response.sendRedirect("AdminHome.jsp");
			}
			rs.close();
			rs1.close();
			rs2.close();
			stmt2.close();
			stmt1.close();
			stmt.close();
			db.closeConnection(conn);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
