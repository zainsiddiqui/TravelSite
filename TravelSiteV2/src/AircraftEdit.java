

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import fp.ConnectDB;


/**
 * Servlet implementation class AircraftEdit
 */
@WebServlet("/AircraftEdit")
public class AircraftEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AircraftEdit() {
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
		String PREV_ID = request.getParameter("AircraftID");
		String AirlineEdit = request.getParameter("AirlinesOwnerEdit");
		String ID = request.getParameter("IDEdit");
		int Capacity = Integer.parseInt( request.getParameter("CapacityEdit"));
		String Name = request.getParameter("AircraftNameEdit");
		
		try {
			ConnectDB db = new ConnectDB();
			java.sql.Connection con = db.getConnection();
			java.sql.Statement UPDATE1 = con.createStatement();
			java.sql.Statement UPDATE2 = con.createStatement();
			UPDATE1.executeUpdate("UPDATE Aircrafts SET AircraftID='"+ID+"', Name='"+Name+"', Capacity="+Capacity+" WHERE AircraftID='"+PREV_ID+"'");
			UPDATE2.executeUpdate("UPDATE Owns SET OwnsAirlineID = (SELECT AirlineID FROM Airline WHERE AirlineID='"+AirlineEdit+"'), OwnsAircraftId = (SELECT AircraftID FROM Aircrafts WHERE AircraftID='"+ID+"') WHERE OwnsAircraftID='"+ID+"'");
			con.close();	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		
		
		
		response.sendRedirect("EmployeeHome.jsp?account=on");
	}

}
