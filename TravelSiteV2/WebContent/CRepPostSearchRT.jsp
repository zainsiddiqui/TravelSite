<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="fp.allQueries, fp.SearchResult, fp.ConnectDB"%>
<%@ page import="java.io.*, java.util.Date,java.util.function.Predicate, java.util.*, java.sql.*, java.text.*, java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Arrival Results</title>
</head>
<body style = "background-color:azure">
<style>
table {
	border: 1px solid black;
}
td {
	padding: 10px;
}
</style>


<%
String link = "logout.jsp";
out.println("<a href ="+link+">Logout</a>");
String name = (String)session.getAttribute("uname");


SearchResult current = (SearchResult) request.getSession().getAttribute("chosen");
if (current == null){
	response.sendRedirect("CRepSearchFlights.jsp?faults=tooLong");
	return;
}

String classE = current.economy;
String dAirport = current.dAirport;
String aAirport = current.aAirport;
String flexible = current.flex;
String dDates = current.dDates;
String aDates = current.aDates;
String sortType = current.sortType;
String budget = current.budget;
int stops = current.stops;

String orderBy = sortType;
if (orderBy.equals("Price")){
	orderBy = "departureDateTime";
} 
if (orderBy == null || orderBy.isEmpty() ){
	orderBy = "departureDateTime";
}


allQueries aq = new allQueries(orderBy, classE);
ArrayList<java.sql.Date> flexDates = aq.makeFlexibleDates(dDates, aDates, flexible);
if (flexDates.size() > 4) {
	response.sendRedirect("CRepPostSearchRT.jsp?faults=date");
	return;
}
java.sql.Date dDate = flexDates.get(0);
java.sql.Date dDate1 = flexDates.get(1);
java.sql.Date aDate = flexDates.get(2);
java.sql.Date aDate1 = flexDates.get(3);

boolean roundTrip = true;

ConnectDB db = new ConnectDB();
Connection conn = db.getConnection();
ArrayList<SearchResult> allResults = new ArrayList<SearchResult>();

String priceType = "Price"+classE;
String directCheck = "and FlyToAirportID =? ";
String nested = "and FlyToAirportID <>? ";
String union = "UNION ALL ";
String crossJoin = "CROSS JOIN ";
String order = "ORDER BY ";

String directOneWay = "select OperatedByAirlineID, FlyFromFlightNumber as layoverFlightNumber, FlyFromAirportID as departureAirport, "
		+"Departure as departureDateTime, FlyToAirportID as layoverAirport, Arrival as layoverArrival, "
		+"PriceE as layoverPrice, Capacity as layoverCapacity, "
		+"NULL as arrivalFlightNumber, NULL as arrivalAirport, null as layoverDeparture, null as arrivalDateTime, null as arrivalPrice, null as arrivalCapacity "
		+"from FlyFrom join FlyTo on FlyFromFlightNumber=FlyToFlightNumber "
		+"join OperatedBy on FlyFromFlightNumber=OperatedByFlightNumber "
		+"join Flights on FlyFromFlightNumber=FlightNumber "
		+"join Have on FlyFromFlightNumber=HaveFlightNumber "
		+"join Aircrafts on HaveAircraftID = AircraftID "
		+"where FlyFromAirportID =? "
		+"and DATE(Departure) >=? and DATE(Departure) <=? "
		+"and OperatedByAirlineID=?";
		
String stopsOneWay = "("+directOneWay+directCheck+")"+union
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

if (stops == 0){
		String qry = directOneWay+directCheck+order+orderBy;
		PreparedStatement q = conn.prepareStatement(qry);
		
		q.setString(1, aAirport);
		q.setDate(2, aDate);
		q.setDate(3, aDate1);
		q.setString(4, current.airlineID);
		q.setString(5, dAirport);

		ResultSet rs = q.executeQuery();
		while(rs.next()){

			SearchResult c = new SearchResult(current);
			if (!c.airlineID.equals(rs.getString("OperatedByAirlineID"))){
				continue;
			}
			
			c.departureAirport1 = rs.getString("departureAirport");
			c.departureDate1= rs.getDate("departureDateTime");
			c.departureTime1 = rs.getTime("departureDateTime");
			
			c.hasLayover1 = false;
			c.flightNumberA1 = rs.getInt("layoverFlightNumber");
			c.arrivalAirport1 =  rs.getString("layoverAirport");
			c.arrivalDate1 = rs.getDate("layoverArrival");
			c.arrivalTime1 = rs.getTime("layoverArrival");
			int capacity = rs.getInt("layoverCapacity");
			c.full = aq.isFilled(c.flightNumberA, capacity, c.full);
			c.price+= aq.priceClass((float) rs.getInt("layoverPrice") );
			c.redirect = true;
			allResults.add(c);
		}
		rs.close();
		q.close();
} else{
		String qry = stopsOneWay+order+orderBy;
		PreparedStatement q = conn.prepareStatement(qry);
		q.setString(1, aAirport);
		q.setDate(2, aDate);
		q.setDate(3, aDate1);
		q.setString(4, current.airlineID);
		q.setString(5, dAirport);
		q.setString(6, aAirport);
		q.setDate(7, aDate);
		q.setDate(8, aDate1);
		q.setString(9, current.airlineID);
		q.setString(10, dAirport);
		q.setString(11, dAirport);
 	 	ResultSet rs = q.executeQuery();
		while(rs.next()){

			SearchResult c = new SearchResult(current);
			c.airlineID = rs.getString("OperatedByAirlineID");
			if (!c.airlineID.equals(rs.getString("OperatedByAirlineID"))){
				continue;
			}
			
			c.departureAirport1 = rs.getString("departureAirport");
			c.departureDate1= rs.getDate("departureDateTime");
			c.departureTime1 = rs.getTime("departureDateTime");
			if (rs.getString("layoverAirport").equals(dAirport)){
				c.hasLayover1 = false;
				c.flightNumberA1 = rs.getInt("layoverFlightNumber");
				c.arrivalAirport1 =  rs.getString("layoverAirport");
				c.arrivalDate1 = rs.getDate("layoverArrival");
				c.arrivalTime1 = rs.getTime("layoverArrival");
				int capacity = rs.getInt("layoverCapacity");
				c.full = aq.isFilled(c.flightNumberA, capacity, c.full);
				c.price+= aq.priceClass((float) rs.getInt("layoverPrice") );
			} else {
				c.hasLayover1 = true;
				c.flightNumberL1 = rs.getInt("layoverFlightNumber");
				c.layoverAirport1 =  rs.getString("layoverAirport");
				c.layoverDate1 = rs.getDate("layoverArrival");
				c.layoverTime1 = rs.getTime("layoverArrival");
				int capacity = rs.getInt("layoverCapacity");
				c.full = aq.isFilled(c.flightNumberA, capacity, c.full);
				c.price+= aq.priceClass((float) rs.getInt("layoverPrice") );
				
				c.flightNumberA1 = rs.getInt("arrivalFlightNumber");
				c.arrivalAirport1 =  rs.getString("arrivalAirport");
				c.arrivalDate1 = rs.getDate("arrivalDateTime");
				c.arrivalTime1 = rs.getTime("arrivalDateTime");
				capacity = rs.getInt("arrivalCapacity");
				c.full = aq.isFilled(c.flightNumberA1, capacity, c.full);
				c.price+= aq.priceClass((float) rs.getInt("arrivalPrice") );		
			}
			
			c.redirect = true;
			allResults.add(c);
		} 
 		rs.close();
		q.close();
}
db.closeConnection(conn);

if (allResults.size()==0){
	response.sendRedirect("CRepPostSearch.jsp?faults=nores");
	return;
} 

if (!budget.isEmpty()){
	float max = Float.parseFloat(budget);
	for (Iterator<SearchResult> iterator = allResults.iterator(); iterator.hasNext();) {
	    SearchResult r = iterator.next();
	    if (r.price > max) {
	        iterator.remove();
	    }
	}
}

if (allResults.size()==0){
 	response.sendRedirect("CRepPostSearch.jsp?faults=nores");
	return;
} 

if (sortType == null || sortType.isEmpty() || sortType.equals("Price")){
	Collections.sort(allResults, SearchResult.FlightPrice);
} 


session.setAttribute("FlightSearchResults", allResults);
out.print("<table border=1 frame=void rules=rows>");
out.print("<tr>");

out.print("<td>");
out.print("Airline");
out.print("</td>");

out.print("<td>");
out.print("Departure Airport");
out.print("</td>");

out.print("<td>");
out.print("Departure Date");
out.print("</td>");

out.print("<td>");
out.print("Departure Time");
out.print("</td>");

out.print("<td>");
out.print("Arrival Airport");
out.print("</td>");

out.print("<td>");
out.print("Arrival Date");
out.print("</td>");

out.print("<td>");
out.print("Arrival Time");
out.print("</td>");

out.print("<td>");
out.print("Stops");
out.print("</td>");

out.print("<td>");
out.print("Layover");
out.print("</td>");

out.print("<td>");
out.print("Price");
out.print("</td>");

out.print("<td>");
out.print("</td>");

out.print("</tr>");

for(int i =0; i <allResults.size(); i++){
	SearchResult c = allResults.get(i);
	String airline = c.airlineID;
	String depAirport = c.departureAirport1;
	LocalDate depDate = c.departureDate1.toLocalDate();
	LocalTime depTime = c.departureTime1.toLocalTime();
	String arrAirport = c.arrivalAirport1;
	LocalDate arrDate = c.arrivalDate1.toLocalDate();
	LocalTime arrTime = c.arrivalTime1.toLocalTime();
	String stops1 = "Nonstop";
	if (c.hasLayover1){
		stops1 = "1 stop";
	}
	out.print("<tr>");
	
	out.print("<td>");
		out.print(airline);
	out.print("</td>");
	
	out.print("<td>");
		out.print(depAirport);
	out.print("</td>");
	
	out.print("<td>");
		out.print(depDate);
	out.print("</td>");
	
	out.print("<td>");
		out.print(depTime);
	out.print("</td>");
	
	out.print("<td>");
		out.print(arrAirport);
	out.print("</td>");
	
	out.print("<td>");
		out.print(arrDate);
	out.print("</td>");
	
	out.print("<td>");
		out.print(arrTime);
	out.print("</td>");
	
	out.print("<td>");
		out.print(stops1);
	out.print("</td>");
	
	out.print("<td>");
		if (c.hasLayover){
			out.print(c.layoverAirport1);
		}
	out.print("</td>");
	
	out.print("<td>");
		out.print(c.price);
	out.print("</td>");
	
	out.print("<td>");
		String post = "post";
		String editer = "CRJoinWaitlist";
		String editer1 = "CRBuyFlight";
		String hidden = "hidden";
		String name1 = "index";
		String index = Integer.toString(i);
		String buttonName = "index";
		String type = "submit";
		if(c.full){
			out.print("<form method="+post+" action="+editer+">");
			out.print("<input type="+hidden+" name="+name1+" value="+index+">");
			out.print("<button name="+buttonName+" type="+type+" value="+index+">Waitlist Flight!</button> ");
			out.print("</form>");
		} else {
			String BuyFlight = "Buy Arrival";
			out.print("<form method="+post+" action="+editer1+">");
			out.print("<input type="+hidden+" name="+name1+" value="+index+">");
			out.print("<button name="+buttonName+" type="+type+" value="+index+">Buy!</button> ");
			out.print("</form>");
		}
	out.print("</td>");
	out.print("</tr>");
}

out.print("</table>");

%>

</body>
</html>




</body>
</html>







</body>
</html>