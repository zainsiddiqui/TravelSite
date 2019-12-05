 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String details = request.getParameter("account");
if (details == null || details.equals("off")){
String link = "login.jsp?login=true";
out.println("<a href ="+link+">Login</a>");

String link1 = "signup.jsp?faults=none";
out.println("<a href ="+link1+">Signup</a>");
} else {
String link = "signout.jsp";
out.println("<a href ="+link+">Signout</a>");
String name = (String)session.getAttribute("username");

String type = (String)session.getAttribute("type");
if (type.equals("Customer")) {
out.println("<p>Welcome Customer: "+name+"</p>");

String link1 = "ticketHistory.jsp";
out.println("<a href ="+link1+">Ticket History</a>");

String link2 = "search.jsp?faults=none";
out.println("<a href ="+link2+">Search Flights</a>");
} else if (type.equals("admin")) {
out.println("<p>Registered Employee!</p>");

String link1 = "AdminHome.jsp";
out.println("<a href ="+link1+">Admin Home</a>");
} else {
out.println("<p>Welcome Customer Rep: "+name+"</p>");
String link1 = "Airports.jsp";
out.println("<a href="+link1+" >Airports</a>");
String link2 = "Aircrafts.jsp";
out.println("<a href="+link2+" >Aircrafts</a>");
String link3 = "Flights.jsp";
out.println("<a href="+link3+" >Flights</a>");
String link4 = "retrieveWaitlist.jsp";
out.println("<a href="+link4+" >Check Waitlist</a>");
String link5 = "CustomerRepSearch.jsp";
out.println("<a href="+link5+" >Reserve Flights for Customer</a>");
String link6 = "CREditFlight.jsp";
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
