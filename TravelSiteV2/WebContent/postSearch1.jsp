<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="fp.allQueries, fp.SearchResult, fp.ConnectDB"%>
<%@ page import="java.io.*, java.util.Date,java.util.function.Predicate, java.util.*, java.sql.*, java.text.*, java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Results</title>
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
String link = "signout.jsp";
out.println("<a href ="+link+">Signout</a>");
String name = (String)session.getAttribute("username");

String link1 = "ticketHistory.jsp";
out.println("<a href ="+link1+">Ticket History</a>");

String link2 = "search.jsp?faults=none";
out.println("<a href ="+link2+">Search Flights</a>");


String tripType = request.getParameter("tripType");
String classE = request.getParameter("classE");
String dAirport = request.getParameter("dAirport");
String aAirport = request.getParameter("aAirport");
String flexible = request.getParameter("flex");
String dDates = request.getParameter("dDate");
String aDates = request.getParameter("aDate");


if (tripType==null|| classE==null || dAirport==null || aAirport==null || dDates==null || aDates==null || flexible==null) {
	response.sendRedirect("search.jsp?faults=empty");
	return;
}


String sortType = request.getParameter("sort");
String budget = request.getParameter("budget");
Integer stops = Integer.parseInt(request.getParameter("stops"));
ArrayList<String> airlines = new ArrayList(Arrays.asList(request.getParameterValues("airlines")));  


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
	response.sendRedirect("search.jsp?faults=date");
	return;
} 
java.sql.Date dDate = flexDates.get(0);
java.sql.Date dDate1 = flexDates.get(1);
java.sql.Date aDate = flexDates.get(2);
java.sql.Date aDate1 = flexDates.get(3);

boolean roundTrip = false;
if (tripType.equals("0")){
	roundTrip = true;
}

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
		+"and DATE(Departure) >=? and DATE(Departure) <=? ";
		
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
	q.setString(1, dAirport);
	q.setDate(2, dDate);
	q.setDate(3, dDate1);
	q.setString(4, aAirport);
	ResultSet rs = q.executeQuery();
	while(rs.next()){
		SearchResult c = new SearchResult();
		c.economy = classE;			
		c.airlineID = rs.getString("OperatedByAirlineID");
		if (!airlines.contains(c.airlineID)){
			continue;
		}
		
		c.departureAirport = rs.getString("departureAirport");
		c.departureDate= rs.getDate("departureDateTime");
		c.departureTime = rs.getTime("departureDateTime");
		
		c.hasLayover = false;
		c.flightNumberA = rs.getInt("layoverFlightNumber");
		c.arrivalAirport =  rs.getString("layoverAirport");
		c.arrivalDate = rs.getDate("layoverArrival");
		c.arrivalTime = rs.getTime("layoverArrival");
		int capacity = rs.getInt("layoverCapacity");
		c.full = aq.isFilled(c.flightNumberA, capacity, c.full);
		c.price+= aq.priceClass((float) rs.getInt("layoverPrice") );
		
		if (roundTrip){
			c.round = true;
			c.redirect = false;
			c.dAirport = dAirport;
			c.dDates = dDates;
			c.stops = stops;
			c.sortType = sortType;
			c.budget = budget;
			c.flex = flexible;
			c.aDates = aDates;
			c.aAirport = aAirport;
		}
		allResults.add(c);
	}
	rs.close();
	q.close();
} else{
	String qry = stopsOneWay+order+orderBy;
	PreparedStatement q = conn.prepareStatement(qry);
	q.setString(1, dAirport);
	q.setDate(2, dDate);
	q.setDate(3, dDate1);
	q.setString(4, aAirport);
	q.setString(5, dAirport);
	q.setDate(6, dDate);
	q.setDate(7, dDate1);
	q.setString(8, aAirport);
	q.setString(9, aAirport);
	 	ResultSet rs = q.executeQuery();
	while(rs.next()){
		SearchResult c = new SearchResult();
		c.economy = classE;			
		c.airlineID = rs.getString("OperatedByAirlineID");
		if (!airlines.contains(c.airlineID)){
			continue;
		}
		
		c.departureAirport = rs.getString("departureAirport");
		c.departureDate= rs.getDate("departureDateTime");
		c.departureTime = rs.getTime("departureDateTime");
		if (rs.getString("layoverAirport").equals(aAirport)){
			c.hasLayover = false;
			c.flightNumberA = rs.getInt("layoverFlightNumber");
			c.arrivalAirport =  rs.getString("layoverAirport");
			c.arrivalDate = rs.getDate("layoverArrival");
			c.arrivalTime = rs.getTime("layoverArrival");
			int capacity = rs.getInt("layoverCapacity");
			c.full = aq.isFilled(c.flightNumberA, capacity, c.full);
			c.price+= aq.priceClass((float) rs.getInt("layoverPrice") );
		} else {
			c.hasLayover = true;
			c.flightNumberL = rs.getInt("layoverFlightNumber");
			c.layoverAirport =  rs.getString("layoverAirport");
			c.layoverDate = rs.getDate("layoverArrival");
			c.layoverTime = rs.getTime("layoverArrival");
			int capacity = rs.getInt("layoverCapacity");
			c.full = aq.isFilled(c.flightNumberA, capacity, c.full);
			c.price+= aq.priceClass((float) rs.getInt("layoverPrice") );
			
			c.flightNumberA = rs.getInt("arrivalFlightNumber");
			c.arrivalAirport =  rs.getString("arrivalAirport");
			c.arrivalDate = rs.getDate("arrivalDateTime");
			c.arrivalTime = rs.getTime("arrivalDateTime");
			capacity = rs.getInt("arrivalCapacity");
			c.full = aq.isFilled(c.flightNumberA1, capacity, c.full);
			c.price+= aq.priceClass((float) rs.getInt("arrivalPrice") );		
		}
		
		if (roundTrip){
			c.round = true;
			c.redirect = false;
			c.dAirport = dAirport;
			c.dDates = dDates;
			c.stops = stops;
			c.sortType = sortType;
			c.budget = budget;
			c.flex = flexible;
			c.aDates = aDates;
			c.aAirport = aAirport;
		}
		allResults.add(c);
	} 
		rs.close();
	q.close();
}
db.closeConnection(conn);

if (allResults.size()==0){
	response.sendRedirect("search.jsp?faults=nores");
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
	response.sendRedirect("search.jsp?faults=nores");
	return;
} 

if (sortType.isEmpty()){
	Collections.sort(allResults, SearchResult.FlightPrice);
} else {
	if (sortType.equals("arrivalDateTime")) {
		Collections.sort(allResults, SearchResult.FlightArrivalTime);
	} else if (sortType.equals("departureDateTime")){
		Collections.sort(allResults, SearchResult.FlightDepartureTime);
	} else{
		Collections.sort(allResults, SearchResult.FlightPrice);
	}
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
	if (!airlines.contains(airline)){
		continue;
	}
	String depAirport = c.departureAirport;
	LocalDate depDate = c.departureDate.toLocalDate();
	LocalTime depTime = c.departureTime.toLocalTime();
	String arrAirport = c.arrivalAirport;
	LocalDate arrDate = c.arrivalDate.toLocalDate();
	LocalTime arrTime = c.arrivalTime.toLocalTime();
	String stops1 = "Nonstop";
	if (c.hasLayover){
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
			out.print(c.layoverAirport);
		}
	out.print("</td>");
	
	out.print("<td>");
		out.print(c.price);
	out.print("</td>");
	
	out.print("<td>");
		String post = "post";
		String editer = "JoinWaitlist";
		String editer1 = "BuyFlight";
		String hidden = "hidden";
		String name1 = "index";
		String index = Integer.toString(i);
		String buttonName = "index";
		String type = "submit";
		
		if(c.full){
			String JoinWaitlist = "JoinWaitlist";
			String waitling = "Waitlist!";
			if (roundTrip){
				waitling = "Waitlist Departing!";
			}
			out.print("<form method="+post+" action="+editer+">");
			out.print("<input type="+hidden+" name="+name1+" value="+index+">");
			out.print("<button name="+buttonName+" type="+type+" value="+index+">"+waitling+"</button> ");
			out.print("</form>");
		} else {
			String BuyFlight = "BuyFlight";
			String buy = "Buy!";
			if (roundTrip){
				buy = "Add to Ticket!";
			}
			out.print("<form method="+post+" action="+editer1+">");
			out.print("<input type="+hidden+" name="+name1+" value="+index+">");
			out.print("<button name="+buttonName+" type="+type+" value="+index+">"+buy+"</button> ");
			out.print("</form>");
		}
	out.print("</td>");
	out.print("</tr>");
	
}

out.print("</table>");

%>

</body>
</html>