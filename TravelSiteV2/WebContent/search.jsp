<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search</title>
</head>
<body>
<%
String link = "signout.jsp";
out.println("<a href ="+link+">Signout</a>");
String name = (String)session.getAttribute("username");

String link1 = "ticketHistory.jsp";
out.println("<a href ="+link1+">Ticket History</a>");

String link2 = "search.jsp?faults=none";
out.println("<a href ="+link2+">Search Flights</a>");

String details = request.getParameter("faults");
if (details != null){
	if (details.equals("empty")){
		out.println("<p>Please fill out all fields</p>");
	} 
	if (details.equals("date")){
		out.println("<p>Arrival date cannot be before departure date.</p>");
	}
	if (details.equals("nores")){
		out.println("<p>No flights matched your criteria. Choose another combination.</p>");
	}
	if (details.equals("tooLong")){
		out.println("<p>You waited too long to buy a ticket. You need to try again.</p>");
	}
}
%>


<form method="post" action="postSearch1.jsp">
		
		<h1>Flight Details:</h1>
		<!--  drop box for round trip or one way -->
		<select name="tripType" size=1>
			<option value="1">One Way</option>
			<option value="0">Round Trip</option>
		</select>&nbsp;
		<br>
		
		<!--  drop box for economy classes -->
		<select name="classE" size=1>
			<option value="E">Economy</option>
			<option value="B">Business</option>
			<option value="F">First</option>
		</select>&nbsp;
		<br>
		
		<!--  drop box for possible from airports -->
		Departure Airport: 
		<!--  drop box for round trip or one way -->
		<select name="dAirport" size=1>
			<option value="JFK">NY John F. Kennedy Airport</option>
			<option value="LAX">Los Angeles International Airport </option>
			<option value="DFW">Dallas/Fort Worth International Airport</option>
			<option value="LHR">London Heathrow Airport</option>
			<option value="DXB">Dubai International Airport</option>
			<option value="HKG">Hong Kong International Airport</option>
		</select>&nbsp;
		<br>
		
		<!--  drop box for possible to airports -->
		Arrival Airport:
		<select name="aAirport" size=1>
			<option value="JFK">NY John F. Kennedy Airport</option>
			<option value="LAX">Los Angeles International Airport </option>
			<option value="DFW">Dallas/Fort Worth International Airport</option>
			<option value="LHR">London Heathrow Airport</option>
			<option value="DXB">Dubai International Airport</option>
			<option value="HKG">Hong Kong International Airport</option>
		</select>&nbsp;
		<br>
		<br>
		
		<!--  drop box for possible departure date -->
		<div class="form-group ">
		Departure Date: <input class="form-control" id="date" name="dDate" placeholder="MM/DD/YYYY" type="text"/>
		</div>
		<br>
		
		<!--  drop box for possible arrival date -->
		<div class="form-group ">
		Arrival Date: <input class="form-control" id="date" name="aDate" placeholder="MM/DD/YYYY" type="text"/>
		
		</div>
		<br>
		
		Flexibility:  
		<input type="radio" name="flex" value="1"/> Yes!
		<input type="radio" name="flex" value="0"/> No!
		<br>
		
		<h1>Sort By:</h1>
		<select name="sort" size=1>
			<option value="Price">Price</option>
			<option value="departureDateTime">Departure Time</option>
			<option value="arrivalDateTime">Arrival Time</option>
		</select>&nbsp;
		<br>
		
		<h1>Filter By:</h1>
		Budget:  <input type="text" name="budget" placeholder="0.00">
		<br>
		
		Airlines: 
		<input type="checkbox" name="airlines" value="AA" checked>American Airlines<br>
		<input type="checkbox" name="airlines" value="UA" checked>United Airlines<br>
		<input type="checkbox" name="airlines" value="BA" checked>British Airlines<br>
		<input type="checkbox" name="airlines" value="EK" checked>Emirates<br>
		<input type="checkbox" name="airlines" value="CA" checked>Air China<br>
		
		<br>
		
		Number of Stops:
		<input type="radio" name="stops" value="0" checked/> Nonstop
		<input type="radio" name="stops" value="1"/> Stops Okay
		<br>

		<br>
		<br>
		
		<input type="submit" value="Row!">
</form>
















</body>
</html>