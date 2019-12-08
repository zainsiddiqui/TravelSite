

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fp.ConnectDB;
/**
 * Servlet implementation class AirportsDelete
 */
@WebServlet("/AirportsDelete")
public class AirportsDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AirportsDelete() {
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
		String AircraftID = request.getParameter("IDDelete");
		try {
			ConnectDB db = new ConnectDB();
			java.sql.Connection con = db.getConnection();
			java.sql.Statement delete = con.createStatement();
			delete.executeUpdate("DELETE FROM Airports WHERE AirportID='"+AircraftID+"'");
			con.close();	
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		response.sendRedirect("EmployeeHome.jsp?account=on");
	}

}
