 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome to EZFlights!</title>
<style>
body{
	background-image: url("planegif.gif");
	background-repeat: no-repeat;
  	background-size: cover;
	text-align: center;
	background-color: azure;
	font-size:	24px;
	color: black;
	font-family: arial;
	
	
}
	
</style>
</head>
<body>
<h1> Welcome to EZFlights!</h1>
<%

String details = request.getParameter("account");
if (details == null || details.equals("off")){
String link = "login.jsp?login=true";
out.println("<br><br><b><a href ="+link+">Login</a></b>");

String link1 = "signup.jsp?faults=none";
out.println("<br><br><br><b><a href ="+link1+">Signup</a></b>");
} else {
String link = "signout.jsp";
out.println("<a href ="+link+">Signout</a>");
String name = (String)session.getAttribute("username");

String type = (String)session.getAttribute("type");
if (type.equals("Customer")) {
out.println("<h1><p>Welcome Customer: "+name+"</p></h1>");

String link1 = "ticketHistory.jsp";
out.println("<a href ="+link1+">Ticket History</a>");
out.println("<br>");
String link2 = "search.jsp?faults=none";
out.println("<a href ="+link2+">Search Flights</a>");
} else if (type.equals("admin")) {
out.println("<p>Registered New Customer Rep</p>");

String link1 = "AdminHome.jsp";
out.println("<a href ="+link1+">AdminHome</a>");
} else {
out.println("<h1><p>Welcome Customer Rep: "+name+"</p></h1>");
String link1 = "Airports.jsp";
out.println("<a href="+link1+" >Airports</a>");
out.println("<br>");
String link2 = "Aircrafts.jsp";
out.println("<a href="+link2+" >Aircrafts</a>");
out.println("<br>");
String link3 = "Flights.jsp";
out.println("<a href="+link3+" >Flights</a>");
out.println("<br>");

String link4 = "retrieveWaitlist.jsp";
out.println("<a href="+link4+" >Check Waitlist</a>");
out.println("<br>");

String link5 = "CRepSearchFlights.jsp";
out.println("<a href="+link5+" >Reserve Flights for Customer</a>");
out.println("<br>");

String link6 = "CRepEditFlights.jsp";
out.println("<a href="+link6+" >Edit Flights for Customer</a>");
}
}
details = request.getParameter("waitlist");
if (details != null){
if (details.equals("true")){
out.println("Sucessfully joined Waitlist.");
}
}
%>

</body>
</html>
