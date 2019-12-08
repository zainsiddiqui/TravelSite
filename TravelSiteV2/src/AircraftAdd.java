

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import fp.ConnectDB;


/**
 * Servlet implementation class AircraftAdd
 */
@WebServlet("/AircraftAdd")
public class AircraftAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AircraftAdd() {
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
		String Airline = request.getParameter("AirlineOwnerAdd");
		String ID = request.getParameter("AircraftID");
		int Capacity = Integer.parseInt( request.getParameter("CapacityAdd"));
		String Name = request.getParameter("AircraftNameAdd");
		
		
		try {
			ConnectDB db = new ConnectDB();
			java.sql.Connection con = db.getConnection();
			java.sql.Statement INSERT = con.createStatement();
			java.sql.Statement INSERT2 = con.createStatement();
			INSERT.executeUpdate("insert into Aircrafts (AircraftID, Name, Capacity) values ('"+ID+"','"+Name+"','"+Capacity+"' )");
			INSERT2.executeUpdate("insert into Owns (OwnsAirlineID, OwnsAircraftID) values ((SELECT AirlineID FROM Airline WHERE AirlineID='"+Airline+"'),(SELECT AircraftID FROM Aircrafts WHERE AircraftID='"+ID+"'))");
			con.close();	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//response.sendRedirect("login.jsp");
		response.sendRedirect("EmployeeHome.jsp?account=on");
	}

}
