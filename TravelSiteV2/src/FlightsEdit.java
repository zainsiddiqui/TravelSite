

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Time;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import fp.ConnectDB;


/**
 * Servlet implementation class FlightsEdit
 */
@WebServlet("/FlightsEdit")
public class FlightsEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FlightsEdit() {
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
		int OGFlightNum = Integer.parseInt(request.getParameter("OriginalFlightNumberEdit"));
		
		int FlightNum = Integer.parseInt(request.getParameter("FlightNumberEdit"));
		String Days = request.getParameter("DaysOfOperationEdit");
		String BookingFee= request.getParameter("BookingFeeEdit");
		String DirectIndirect = request.getParameter("Direct/IndirectEdit");
		String DomesticInternational = request.getParameter("Domestic/InternationalEdit");
		
		String arrivalAirport = request.getParameter("ArrivalAirportEdit");
		String departureAirport = request.getParameter("DepartureAirportEdit");
		String AirlineID = request.getParameter("AirlineIdEdit");
		String AircraftID = request.getParameter("AircraftIdEdit");
		float PriceE = Float.parseFloat(request.getParameter("PriceEEdit"));
		float PriceB = Float.parseFloat(request.getParameter("PriceBEdit"));
		float PriceF = Float.parseFloat(request.getParameter("PriceFEdit"));
		
		String ArrivalDateTime = request.getParameter("ArrivalDateTimeEdit");
		String DepartureDateTime = request.getParameter("DepartureDateTimeEdit");
		
		int DI;
		if (DomesticInternational.equals("International")) {
			DI = 1;
		}else {
			DI = 0;
		}
		try {
			ConnectDB db = new ConnectDB();
			java.sql.Connection con = db.getConnection();
			java.sql.Statement stmt1 = con.createStatement();
			java.sql.Statement stmt2 = con.createStatement();
			java.sql.Statement stmt3 = con.createStatement();
			java.sql.Statement stmt4 = con.createStatement();
			java.sql.Statement stmt5 = con.createStatement();
			
			stmt1.executeUpdate("Update Flights SET FlightNumber="+FlightNum+", isInternational="+DI+", DaysOfOperation='"+Days+"', PriceE="+PriceE+", PriceB="+PriceB+", PriceF="+PriceF +" WHERE FlightNumber="+OGFlightNum);
			stmt2.executeUpdate("Update FlyTo SET FlyToFlightNumber="+FlightNum+", FlyToAirportID='"+arrivalAirport+"' , Arrival='" +ArrivalDateTime+"' WHERE FlyToFlightNumber="+FlightNum);
			stmt3.executeUpdate("Update FlyFrom SET FlyFromFlightNumber="+FlightNum+", FlyFromAirportID='"+departureAirport+"' , Departure='" +DepartureDateTime+"' WHERE FlyFromFlightNumber="+FlightNum);
			stmt4.executeUpdate("Update OperatedBy SET OperatedByFlightNumber="+FlightNum+", OperatedByAirlineID='"+AirlineID+"' WHERE OperatedByFlightNumber="+FlightNum);
			stmt5.executeUpdate("Update Have SET HaveFlightNumber="+FlightNum+", HaveAircraftID='"+AircraftID+"' WHERE HaveFlightNumber="+FlightNum);
			con.close();	
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		response.sendRedirect("EmployeeHome.jsp?account=on");
	}

}
