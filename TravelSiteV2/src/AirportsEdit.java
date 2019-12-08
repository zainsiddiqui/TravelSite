

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import fp.ConnectDB;

/**
 * Servlet implementation class AirportsEdit
 */
@WebServlet("/AirportsEdit")
public class AirportsEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AirportsEdit() {
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
		String Original = request.getParameter("OriginalIDEdit");
		String ID = request.getParameter("IDEdit");
		String Name = request.getParameter("AirportNameEdit");
		String City = request.getParameter("AirportCityEdit");
		String Country = request.getParameter("AirportCountryEdit");
		
		try {
			ConnectDB db = new ConnectDB();
			java.sql.Connection con = db.getConnection();
			java.sql.Statement update = con.createStatement();
			update.executeUpdate("UPDATE Airports SET AirportID = '"+ID+"', Name = '"+Name+"', City = '"+City+"', Country = '"+Country+"' WHERE AirportID = '"+Original+"' ");
			con.close();	
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		response.sendRedirect("EmployeeHome.jsp?account=on");
	}

}
