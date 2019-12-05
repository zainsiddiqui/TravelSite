import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fp.ConnectDB;

/**
 * Servlet implementation class EditCust
 */
@WebServlet("/AdminEditCustomer")
public class AdminEditCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminEditCustomer() {
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
		// TODO Auto-generated method stub
		doGet(request, response);

		String oldUsername = request.getParameter("oldUsername");
		String newUsername = request.getParameter("newUsername");
		String newPassword = request.getParameter("newPassword");
		String newEmail = request.getParameter("newEmail");
		String newName = request.getParameter("newName");
		//String qryResult="";
		
		int hi=0;
		try {

			ConnectDB db = new ConnectDB();	
			Connection con = db.getConnection();	
			
		
			
			String str = "update Account set Username = ?,Password = ?,Email = ?,Name = ? where Username = ?";
			PreparedStatement stmt = con.prepareStatement(str);
			//stmt.setString(1,newUsername);
			if(newUsername.isEmpty())
				stmt.setNull(1,java.sql.Types.VARCHAR);
			else
				stmt.setString(1,newUsername);
			if(newPassword.isEmpty())
				stmt.setNull(2,java.sql.Types.VARCHAR);
			else
				stmt.setString(2,newPassword);
			if(newEmail.isEmpty())
				stmt.setNull(3,java.sql.Types.VARCHAR);
			else
				stmt.setString(3,newEmail);
			if(newName.isEmpty())
				stmt.setNull(4,java.sql.Types.VARCHAR);
			else
				stmt.setString(4,newName);

			stmt.setString(5,oldUsername);
			//qryResult = stmt.toString();
			hi = stmt.executeUpdate();
			
			stmt.close();
			con.close();
			db.closeConnection(con);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(hi==0)
			response.sendRedirect("AdminHome.jsp?try=fail");
		else
			response.sendRedirect("AdminHome.jsp?try=success");
	}

}
