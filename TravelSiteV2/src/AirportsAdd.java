

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import fp.ConnectDB;

/**
 * Servlet implementation class AirportsAdd
 */
@WebServlet("/AirportsAdd")
public class AirportsAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AirportsAdd() {
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
		String ID = request.getParameter("IDAdd");
		String Name = request.getParameter("AirportNameAdd");
		String City = request.getParameter("AirportCityAdd");
		String Country = request.getParameter("AirportCountryAdd");

		try {
			ConnectDB db = new ConnectDB();
			java.sql.Connection con = db.getConnection();
			java.sql.Statement insert = con.createStatement();
			insert.executeUpdate("insert into Airports (AirportID, Name, City, Country) values ('"+ID+"','"+Name+"','"+City+"', '"+Country+"' )");
			
			
			
			con.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		response.sendRedirect("EmployeeHome.jsp?account=on");
	}

}
