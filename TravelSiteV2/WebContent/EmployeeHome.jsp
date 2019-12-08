 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<style>
body{
	text-align: center;
	background-color: azure;
	font-size:	20px;
	color: cadetblue;
	font-family: arial;
	
	
}
</style>
<body style = "background-color:azure">
<%
String details = request.getParameter("account");
if (details == null || details.equals("off")){
String link = "login.jsp?login=true";
out.println("<a href ="+link+">Login</a>");

String link1 = "signup.jsp?faults=none";
out.println("<a href ="+link1+">Signup</a>");
} else {
String link = "logout.jsp";
out.println("<a href ="+link+">Logout</a>");

//Getting user data
String name = (String)session.getAttribute("username");
String type = (String)session.getAttribute("type");
//Checks if account type is Employee
if (type.equals("employee")) {
out.println("<h1>Welcome Customer Representative: "+name+"</h1>");

String link5 = "CRepSearchFlights.jsp";
out.println("<a href="+link5+" >Reserve Customer Flights</a>");
out.println("<br>");

String link6 = "CRepEditFlights.jsp";
out.println("<a href="+link6+" >Edit Customer Flights</a>");
out.println("<br>");

String link1 = "Airports.jsp";
out.println("<a href="+link1+" >Add/Edit/Delete Airports</a>");
out.println("<br>");

String link2 = "Aircrafts.jsp";
out.println("<a href="+link2+" >Add/Edit/Delete Aircrafts</a>");
out.println("<br>");

String link3 = "Flights.jsp";
out.println("<a href="+link3+" >Add/Edit/Delete Flights</a>");
out.println("<br>");

String link4 = "retrieveWaitlist.jsp";
out.println("<a href="+link4+" >Preview Waitlist</a>");










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
