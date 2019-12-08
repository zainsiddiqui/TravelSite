package fp;


import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;
import java.time.*;
import java.sql.*;

public class allQueries{
	/*
	private String priceType = "Price";
	private String directCheck= "and FlyToAirportID =? ";
	private String nested = "and FlyToAirportID <>? ";
	private String union = "UNION ALL ";
	private String crossJoin = "CROSS JOIN ";
	private String orderBy;
	private String order = "ORDER BY ";
	private String directOneWay = "select OperatedByAirlineID, FlyFromFlightNumber as layoverFlightNumber, FlyFromAirportID as departureAirport, "
			+"Departure as departureDateTime, FlyToAirportID as layoverAirport, Arrival as layoverArrival, "
			+"PriceE as layoverPrice, Capacity as layoverCapacity, "
			+"NULL as arrivalFlightNumber, NULL as arrivalAirport, null as layoverDeparture, null as arrivalDateTime, null as arrivalPrice, null as arrivalCapacity "
			+"from FlyFrom join FlyTo on FlyFromFlightNumber=FlyToFlightNumber "
			+"join OperatedBy on FlyFromFlightNumber=OperatedByFlightNumber "
			+"join Flights on FlyFromFlightNumber=FlightNumber "
			+"join Have on FlyFromFlightNumber=HaveFlightNumber "
			+"join Aircrafts on HaveAircraftID = AircraftID "
			+"where FlyFromAirportID =? "
			+"and DATE(Departure) >=? and DATE(Departure) <=? ";	
	private String stopsOneWay = "("+directOneWay+directCheck+")"+union
				+"(select b.OperatedByAirlineID, t.layoverFlightNumber, t.departureAirport, t.departureDateTime, t.layoverAirport, t.layoverArrival, t.layoverPrice, t.layoverCapacity, "
				+"o.FlyToFlightNumber, o.FlyToAirportID, m.Departure, o.Arrival, f.PriceE, a.Capacity "
				+"from FlyFrom m "
				+"join OperatedBy b on m.FlyFromFlightNumber = b.OperatedByFlightNumber "
				+"join FlyTo o on o.FlyToFlightNumber = m.FlyFromFlightNumber "
				+"join Flights f on FlyFromFlightNumber=FlightNumber "
				+"join Have on FlyFromFlightNumber=HaveFlightNumber "
				+"join Aircrafts a on HaveAircraftID = AircraftID "
				+"join ("
						+directOneWay+nested
						+") t on t.layoverAirport=m.FlyFromAirportID and b.OperatedByAirlineID = t.OperatedByAirlineID "
				+"where m.Departure >= t.layoverArrival "
				+"and m.Departure <= date_add(t.layoverArrival, INTERVAL 1 day) "
				+"and o.FlyToAirportID = ?) ";
	private String directRound = "select OperatedByAirlineID as oAID1, FlyFromFlightNumber as layoverFlightNumber1, FlyFromAirportID as departureAirport1, Departure as departureDateTime1, FlyToAirportID as layoverAirport1, Arrival as layoverArrival1, PriceE as layoverPrice1, Capacity as layoverCapacity1, "				+"NULL as arrivalFlightNumber1, NULL as arrivalAirport1, null as layoverDeparture1, null as arrivalDateTime1, null as arrivalPrice1, null as arrivalCapacity1 "
				+"from FlyFrom join FlyTo on FlyFromFlightNumber=FlyToFlightNumber "
				+"join OperatedBy on FlyFromFlightNumber=OperatedByFlightNumber "
				+"join Flights on FlyFromFlightNumber=FlightNumber "
				+"join Have on FlyFromFlightNumber=HaveFlightNumber "
				+"join Aircrafts on HaveAircraftID = AircraftID "
				+"where FlyFromAirportID =? "
				+"and DATE(Departure) >=? and DATE(Departure) <=? ";
	private String stopsRound = "("+directRound+directCheck+")"+union
				+"(select b.OperatedByAirlineID, t.layoverFlightNumber1, t.departureAirport1, t.departureDateTime1, t.layoverAirport1, t.layoverArrival1, t.layoverPrice1, t.layoverCapacity1, "
				+"o.FlyToFlightNumber, o.FlyToAirportID, m.Departure, o.Arrival, f.PriceE, a.Capacity "
				+"from FlyFrom m "
				+"join OperatedBy b on m.FlyFromFlightNumber = b.OperatedByFlightNumber "
				+"join FlyTo o on o.FlyToFlightNumber = m.FlyFromFlightNumber "
				+"join Flights f on FlyFromFlightNumber=FlightNumber "
				+"join Have on FlyFromFlightNumber=HaveFlightNumber "
				+"join Aircrafts a on HaveAircraftID = AircraftID "
				+"join ("
						+directRound+nested
						+") t on t.layoverAirport1=m.FlyFromAirportID and b.OperatedByAirlineID = t.oAID1 "
				+"where m.Departure >= t.layoverArrival1 "
				+"and m.Departure <= date_add(t.layoverArrival1, INTERVAL 1 day) "
				+"and o.FlyToAirportID = ?) ";	
	*/
	private String checkCapacity =  "select count(FSFlightNumber) "
			+"from FlightSequences "
			+"where FSFlightNumber=?";
	private String classE;

	
	public allQueries(String oB, String classE) {	
		this.classE = classE;
		this.priceType+=classE;
		this.orderBy = oB;		
	}
	
	public ArrayList<java.sql.Date> makeFlexibleDates(String dDate, String aDate, String flexible) throws ParseException{
		ArrayList<java.sql.Date> flexDates = new ArrayList<java.sql.Date>();
		
		DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
		Date dDater = formatter.parse(dDate);
		Date aDater = formatter.parse(aDate);
		Date dDater1 = dDater;
		Date aDater1 = aDater;

		if (flexible.equals("1")){
			Calendar cal = Calendar.getInstance();
			cal.setTime( dDater );	
			cal.add(Calendar.DATE, -3);
			dDater = formatter.parse(formatter.format( cal.getTime() ) );
			cal.setTime( dDater1 );
			cal.add( Calendar.DATE, 3 );
			dDater1 = formatter.parse(formatter.format(cal.getTime()));
			cal.setTime( aDater );
			cal.add(Calendar.DATE, -3);
			aDater = formatter.parse(formatter.format(cal.getTime()));
			cal.setTime( aDater1 );
			cal.add( Calendar.DATE, 3 );
			aDater1 = formatter.parse(formatter.format(cal.getTime()));
		}

		java.sql.Date dDate1 = new java.sql.Date(dDater.getTime());
		java.sql.Date dDate2 = new java.sql.Date(dDater1.getTime());
		java.sql.Date aDate1 = new java.sql.Date(aDater.getTime());
		java.sql.Date aDate2 = new java.sql.Date(aDater1.getTime());
		
		
		flexDates.add(dDate1);
		flexDates.add(dDate2);
		flexDates.add(aDate1);
		flexDates.add(aDate2);
		
		if (aDater.before(dDater)) {
			flexDates.add(aDate2);
		}
		return flexDates;
	}
	
	public boolean isFilled(int FlightNumber, int capacity, boolean isFull) throws SQLException {
		ConnectDB db = new ConnectDB();
		Connection conn = db.getConnection();
		String qry3 = this.checkCapacity;
		PreparedStatement q3 = conn.prepareStatement(qry3);
		q3.setInt(1, FlightNumber);
		ResultSet rs3 = q3.executeQuery();
		if(rs3.next()){
			if (rs3.getInt("count(FSFlightNumber)") >= capacity){
				rs3.close();
				q3.close();
				db.closeConnection(conn);
				return true;
			}
		}
		rs3.close();
		q3.close();
		db.closeConnection(conn);
		return isFull; 
	}	

	public float priceClass(float price) {
		if (classE.equals("B")){
			return price+100;
		} else if (classE.equals("F")){
			return price+200;
		}
		return price; 
	}
}

