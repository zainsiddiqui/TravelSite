

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class FlightsDelete
 */
@WebServlet("/FlightsDelete")
public class FlightsDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FlightsDelete() {
        super();
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
		int FlightNum = Integer.parseInt(request.getParameter("FlightNumberDelete"));
		try {
			ConnectDB db = new ConnectDB();
			java.sql.Connection con = db.getConnection();
			java.sql.Statement s1 = con.createStatement();
			s1.executeUpdate("DELETE FROM Flights WHERE FlightNumber="+FlightNum+"");
			con.close();	
		} 
		catch (SQLException e) {
			
			e.printStackTrace();
		}
		
		
		response.sendRedirect("EmployeeHome.jsp?account=on");
	
	}

}
