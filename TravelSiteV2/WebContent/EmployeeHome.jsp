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
//Getting user data
String name = (String)session.getAttribute("username");
String type = (String)session.getAttribute("type");
//Checks if account type is Employee
if (type.equals("employee")) {
out.println("<p>Welcome Customer Representative: "+name+"</p>");
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
out.println("<a href="+link4+" >View Waitlist</a>");
out.println("<br>");
String link5 = "CRepSearchFlights.jsp";
out.println("<a href="+link5+" >Reserve Customer Flights</a>");
out.println("<br>");
String link6 = "CRepEditFlights.jsp";
out.println("<a href="+link6+" >Edit Customer Flights</a>");
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