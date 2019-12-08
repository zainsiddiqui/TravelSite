<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="fp.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "style.css">
<style>
body {
	background-color: azure;
}
table {
	border: 1px solid black;
}
td {
	padding: 10px;
}

</style>

<meta charset="UTF-8">
<title>Ticket History</title>
</head>
<body">

<%


String link = "signout.jsp";
out.println("<a href ="+link+">Signout</a>");
String name = (String)session.getAttribute("username");

String link2 = "search.jsp?faults=none";
out.println("<a href ="+link2+">Search Flights</a>");
out.println("<br>");

String details = request.getParameter("success");
if (details != null){
	if (details.equals("true")){
		out.print("<h2>Successfully Cancelled Flight!</h2>");
	}
}
details = request.getParameter("buy");
if (details != null){
	if (details.equals("true")){
		out.print("<h2>Successfully Bought Flight!</h2>");
	}
}

details = request.getParameter("waitlist");
if (details != null){
	if (details.equals("true")){
		out.print("<h2>Successfully Waitlisted Flight!</h2>");
	}
}


ConnectDB db = new ConnectDB();
Connection conn = db.getConnection();

String qry = "select * from Buys where BuysUsername=? order by BoughtDate desc";
String username = (String) session.getAttribute("username");
PreparedStatement stmt = conn.prepareStatement(qry);
stmt.setString(1, username); 
ResultSet rs = stmt.executeQuery();


out.print("<table>");
out.print("<tr>");

out.print("<td>");
out.print("Date Bought");
out.print("</td>");

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
out.print("Price");
out.print("</td>");

out.print("<td>");
out.print("</td>");

out.print("<td>");
out.print("</td>");

out.print("<td>");
out.print("Date Cancelled");
out.print("</td>");

out.print("</tr>");

while (rs.next()){
	String airlineName = "";
	String DepartureAirportID = "";
	LocalDate DepartureDate = LocalDate.now();
	LocalTime DepartureTime= LocalTime.now();
	String ArrivalAirportID = "";
	LocalDate ArrivalDate = LocalDate.now();
	LocalTime ArrivalTime = LocalTime.now();
	float price = (float) rs.getFloat("BookingFee");
	String stops = "Nonstop";
	int count = 0;
	boolean edit = false;
	boolean cancel = false; 
	String econ = "";

	
 	LocalDate boughtDate = rs.getDate("BoughtDate").toLocalDate();
 	int ticketNumber = rs.getInt("BuysTicketNumber");
 	LocalDate cancelDate = null;
 	if(rs.getDate("CancelledDate") != null){
 	 	cancelDate = rs.getDate("CancelledDate").toLocalDate();
 	}
 	
 	
	float BookingFee = rs.getFloat("BookingFee");
 	
	
	String qry1 = "select count(FSFlightNumber) from FlightSequences where FSTicketNumber =?";
	PreparedStatement stmt1 = conn.prepareStatement(qry1);
	stmt1.setInt(1, ticketNumber); 
	ResultSet rs1 = stmt1.executeQuery();
	if(rs1.next()){
		count = rs1.getInt("count(FSFlightNumber)");
	}
	rs1.close();
	stmt1.close();
	
	qry1 = "select Fare "
			+"from Tickets "
			+"where TicketNumber =?"; 
	stmt1 = conn.prepareStatement(qry1);
	stmt1.setInt(1, ticketNumber); 
	rs1 = stmt1.executeQuery();
	if (rs1.next()){
		price+= rs1.getFloat("Fare");
	} 
	rs1.close();
	stmt1.close();
	
	qry1 = "select OperatedByAirlineID, FlyFromAirportID, Departure, FlyToAirportID, Arrival "
			+"from FlightSequences "
			+"join FlyTo on FlyToFlightNumber = FSFlightNumber "
			+"join FlyFrom on FlyFromFlightNumber= FSFlightNumber "
			+"join OperatedBy on OperatedByFlightNumber=FSFlightNumber "
			+"where FSTicketNumber =? having min(FSOrder)"; 
	stmt1 = conn.prepareStatement(qry1);
	stmt1.setInt(1, ticketNumber);
	rs1 = stmt1.executeQuery();
	
	if (rs1.next()){
		airlineName = rs1.getString("OperatedByAirlineID");
 		DepartureAirportID = rs1.getString("FlyFromAirportID");
		DepartureDate = rs1.getDate("Departure").toLocalDate();	
		DepartureTime = rs1.getTime("Departure").toLocalTime();
		ArrivalAirportID = rs1.getString("FlyToAirportID");
		ArrivalDate = rs1.getDate("Arrival").toLocalDate();	
		ArrivalTime = rs1.getTime("Arrival").toLocalTime();
	}
	rs1.close();
	stmt1.close();
	
	
	
	if (count==2 || count==4){
		qry1 = "select OperatedByAirlineID, FlyFromAirportID, Departure, FlyToAirportID, Arrival "
				+"from FlightSequences "
				+"join Flights on FlightNumber = FSFlightNumber "
				+"join FlyTo on FlyToFlightNumber = FlightNumber "
				+"join FlyFrom on FlyFromFlightNumber= FlightNumber "
				+"join OperatedBy on OperatedByFlightNumber=FlightNumber "
				+"where FSTicketNumber =? and FSOrder=2"; 
		stmt1 = conn.prepareStatement(qry1);
		stmt1.setInt(1, ticketNumber); 
		rs1 = stmt1.executeQuery();
		String aa = "";
		if (rs1.next()){
			aa = rs1.getString("FlyToAirportID");
		}
		if (!aa.equals(DepartureAirportID)){
			stops = "1 stop";
			ArrivalAirportID = aa;
			ArrivalDate = rs1.getDate("Arrival").toLocalDate();	
			ArrivalTime = rs1.getTime("Arrival").toLocalTime();
		}
		rs1.close();
		stmt1.close();
	} 

    LocalDateTime flightTime = DepartureTime.atDate(DepartureDate);
    LocalDateTime rightNow = LocalDateTime.now();
    		
	if (rightNow.plusHours(24).isBefore(flightTime) || cancelDate == null ){
		edit = true;
		cancel = true;
	}
	if (cancel){
		qry1 = "select * from Tickets where TicketNumber=?"; 
		stmt1 = conn.prepareStatement(qry1);
		stmt1.setInt(1, ticketNumber); 
		rs1 = stmt1.executeQuery();
		if (rs1.next()){
			econ = rs1.getString("Class");
		}
		rs1.close();
		stmt1.close();
	}

	out.print("<tr>");
	
	out.print("<td>");
	out.print(boughtDate);
	out.print("</td>");
	
	out.print("<td>");
	out.print(airlineName);
	out.print("</td>");
	
	out.print("<td>");
	out.print(DepartureAirportID);
	out.print("</td>");
	
	out.print("<td>");
	out.print(DepartureDate);
	out.print("</td>");
	
	out.print("<td>");
	out.print(DepartureTime);
	out.print("</td>");
	
	out.print("<td>");
	out.print(ArrivalAirportID);
	out.print("</td>");
	
	out.print("<td>");
	out.print(ArrivalDate);
	out.print("</td>");
	
	out.print("<td>");
	out.print(ArrivalTime);
	out.print("</td>");
	
	out.print("<td>");
	out.print(stops);
	out.print("</td>");
	
	out.print("<td>");
	out.print(price);
	out.print("</td>");

	out.print("<td>");
	if (edit && cancelDate == null) {
		String post = "post";
		String editer = "editTicket.jsp";
		String hidden = "hidden";
		String name1 = "tix";
		String tN = Integer.toString(ticketNumber);
		String editButton = "ticketNumber";
		String type = "submit";
		out.print("<form method="+post+" action="+editer+">");
		out.print("<input type="+hidden+" name="+name1+" value="+tN+">");
		out.print("</form>");
	}
	out.print("</td>");
	
	out.print("<td>");
	if (cancel && cancelDate == null){
	  	String post = "post";
		String editer = "CancelFlight";
		String hidden = "hidden";
		String type = "submit";
		String name1 = "tix";
		String tN = Integer.toString(ticketNumber);
		String editButton = "ticketNumber";
		String cancelFlight = "Cancel $75";
		if(econ.equals("Business") || econ.equals("B") || econ.equals("First") || econ.equals("F")){
			cancelFlight = "Cancel Flight!";	
		}
		out.print("<form method="+post+" action="+editer+">");
		out.print("<input type="+hidden+" name="+name1+" value="+tN+">");
		out.print("<button name="+editButton+" type="+type+" value="+tN+">"+cancelFlight+"</button> ");
		out.print("</form>");
	}
	out.print("</td>");
	
	out.print("<td>");
	if (cancelDate != null){
		out.print(cancelDate);
	}
	out.print("</td>");
	
	out.print("</tr>"); 
}

out.print("</table>"); 


rs.close();
stmt.close();
db.closeConnection(conn); 
%>

</body>
</html>