

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import fp.ConnectDB;

/**
 * Servlet implementation class FlightsAdd
 */
@WebServlet("/FlightsAdd")
public class FlightsAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FlightsAdd() {
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
		int FlightNum = Integer.parseInt(request.getParameter("FlightNumberAdd"));
		String Days = request.getParameter("DaysOfOperationAdd");
		float PriceE = Float.parseFloat(request.getParameter("PriceEAdd"));
		float PriceB = Float.parseFloat(request.getParameter("PriceBAdd"));
		float PriceF = Float.parseFloat(request.getParameter("PriceFAdd"));
		String DomesticInternational = request.getParameter("Domestic/InternationalAdd");
		String ArrivalAirport = request.getParameter("ArrivalAirportAdd");
		String ArrivalDateTime = request.getParameter("ArrivalDateTimeAdd");
		String DepartureDateTime = request.getParameter("DepartureDateTimeAdd");
		String DepartureAirport = request.getParameter("DepartureAirportAdd");
		String AirlineID = request.getParameter("AirlineIdAdd");
		String AircraftID = request.getParameter("AircraftIdAdd");
		
		try {
			ConnectDB db = new ConnectDB();
			java.sql.Connection con = db.getConnection();
			java.sql.Statement s1 = con.createStatement();
			java.sql.Statement s2 = con.createStatement();
			java.sql.Statement s3 = con.createStatement();
			java.sql.Statement s4 = con.createStatement();
			java.sql.Statement s5 = con.createStatement();
			int DI;
			if (DomesticInternational.equals("International")) {
				DI = 1;
			}else {
				DI = 0;
			}
			s1.executeUpdate("insert into Flights (FlightNumber, isInternational, DaysOfOperation, PriceE, PriceB, PriceF) values ("+FlightNum+",'"+DI+"','"+Days+"',"+PriceE+","+PriceB+","+PriceF+")");
			s2.executeUpdate("insert into FlyTo (FlyToFlightNumber, FlyToAirportID, Arrival) values ((SELECT FlightNumber FROM Flights WHERE FlightNumber="+FlightNum+"), (SELECT AirportID FROM Airports WHERE AirportID='"+ArrivalAirport+"'), '"+ArrivalDateTime+"')");
			s3.executeUpdate("insert into FlyFrom (FlyFromFlightNumber, FlyFromAirportID, Departure) values ((SELECT FlightNumber FROM Flights WHERE FlightNumber="+FlightNum+"), (SELECT AirportID FROM Airports WHERE AirportID='"+DepartureAirport+"'), '"+DepartureDateTime+"')");
			s4.executeUpdate("insert into Have (HaveFlightNumber, HaveAircraftID) values ((SELECT FlightNumber FROM Flights WHERE FlightNumber="+FlightNum+") ,(SELECT AircraftID FROM Aircrafts WHERE AircraftID='"+AircraftID+"'))");
			s5.executeUpdate("insert into OperatedBy (OperatedByFlightNumber, OperatedByAirlineID) values ((SELECT FlightNumber FROM Flights WHERE FlightNumber="+FlightNum+" ),(SELECT AirlineID FROM Airline WHERE AirlineID='"+AirlineID+"'))");
			con.close();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
		
		
		response.sendRedirect("EmployeeHome.jsp?account=on");
	}

}
