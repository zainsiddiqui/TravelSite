

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		//response.sendRedirect("login.jsp");
		response.sendRedirect("home.jsp?account=on");
	}

}
