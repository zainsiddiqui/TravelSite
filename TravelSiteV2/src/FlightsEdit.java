

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
int OGFlightNum = Integer.parseInt(request.getParameter("OriginalFlightNumberEdit"));
		
		int FlightNum = Integer.parseInt(request.getParameter("FlightNumberEdit"));
		String Days = request.getParameter("DaysOfOperationEdit");
		String BookingFee= request.getParameter("BookingFeeEdit");
		String DirectIndirect = request.getParameter("Direct/IndirectEdit");
		int DomesticInternational = Integer.parseInt(request.getParameter("Domestic/InternationalEdit"));
		
		String arrivaltime = request.getParameter("ArrivalTimeEdit");
		String arrivaldate = request.getParameter("ArrivalDateEdit");
		String departuretime = request.getParameter("DepartureTimeEdit");
		String departuredate = request.getParameter("DepartureDateEdit");
		String arrivalAirport = request.getParameter("ArrivalAirportEdit");
		String departureAirport = request.getParameter("DepartureAirportEdit");
		String AirlineID = request.getParameter("AirlineIdEdit");
		String AircraftID = request.getParameter("AircraftIdEdit");
		float PriceE = Float.parseFloat(request.getParameter("PriceEEdit"));
		float PriceB = Float.parseFloat(request.getParameter("PriceBEdit"));
		float PriceF = Float.parseFloat(request.getParameter("PriceFEdit"));
		
		DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
		
		Time arrivalTime = null;
		arrivalTime = Time.valueOf(arrivaltime);
		Date arrivalDatejava = null;
		try {
			 arrivalDatejava = formatter.parse(arrivaldate);
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		java.sql.Date arrivalDate = new java.sql.Date(arrivalDatejava.getTime());
		
		Time arrivalTimeDep = null;
		arrivalTimeDep = Time.valueOf(departuretime);
		Date DepartureDatejava = null;
		
		try {
			 DepartureDatejava = formatter.parse(departuredate);
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		java.sql.Date departureDate = new java.sql.Date(DepartureDatejava.getTime());
		
		try {
			ConnectDB db = new ConnectDB();
			java.sql.Connection con = db.getConnection();
			java.sql.Statement stmt1 = con.createStatement();
			java.sql.Statement stmt2 = con.createStatement();
			java.sql.Statement stmt3 = con.createStatement();
			java.sql.Statement stmt4 = con.createStatement();
			java.sql.Statement stmt5 = con.createStatement();
			
			stmt1.executeUpdate("Update Flights SET FlightNumber="+FlightNum+", isInternational="+DomesticInternational+", DaysOfOperation='"+Days+"', PriceE="+PriceE+", PriceB="+PriceB+", PriceF="+PriceF +" WHERE FlightNumber="+OGFlightNum);
			stmt2.executeUpdate("Update FlyTo SET FlyToFlightNumber="+FlightNum+", FlyToAirportID='"+arrivalAirport+"' , ArrivalTime='" +arrivalTime+"', ArrivalDate='"+arrivalDate+"' WHERE FlyToFlightNumber="+FlightNum);
			stmt3.executeUpdate("Update FlyFrom SET FlyFromFlightNumber="+FlightNum+", FlyFromAirportID='"+departureAirport+"' , DepartureTime='" +arrivalTimeDep+"', DepartureDate='"+departureDate+"' WHERE FlyFromFlightNumber="+FlightNum);
			stmt4.executeUpdate("Update OperatedBy SET OperatedByFlightNumber="+FlightNum+", OperatedByAirlineID='"+AirlineID+"' WHERE OperatedByFlightNumber="+FlightNum);
			stmt5.executeUpdate("Update Have SET HaveFlightNumber="+FlightNum+", HaveAircraftID='"+AircraftID+"' WHERE HaveFlightNumber="+FlightNum);
			con.close();	
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//response.sendRedirect("login.jsp");
		response.sendRedirect("EmployeeHome.jsp?account=on");
	}

}
