<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin</title>
</head>
<body style = "background-color:azure">
Admin Control Home
<br>
<%
String link1 = "employeeSignup.jsp";
out.println("<a href ="+link1+">Register an Employee</a>");
%>
<br>
<% 
String link = "logout.jsp";
out.println("<a href ="+link+">Logout</a>");
%>
<br>

<%
String details = request.getParameter("try");
if (details!= null){
	
	out.println(details);
	
}

%>
<br>
<h2>SEARCH, EDIT, DELETE USER INFORMATION<h2/>
<form action="AdminSearchCustomer.jsp" method="post">
<pre>
Customer Username: <input type="text" name="searchCustomer">
<input type="submit" value="Submit">
</pre>
</form>
<br>
SEE SALES REPORT
<form action="AdminCheckSales.jsp" method="post">
<pre>
Enter YYYY/MM: <input type="text" name="date">
<input type="submit" value="Submit">
</pre>
</form>
<br>
SEE RESERVATIONS
<form action="AdminReservation.jsp">
Flight or Customer:<select name="AdminReservation">
  <option value="1">Flight</option>
  <option value="2">Customer</option>
  </select>
<pre>
Enter customer username or Flight Number: <input type="text" name="name">
<input type="submit" value="Submit">
</pre>
</form>
<br>
SEE REVENUE
<form action="AdminRevenue.jsp">
Flight, Customer, or Airline?
  <select name="AdminRevenue">
    <option value="Flight">Flight</option>
    <option value="Customer">Customer</option>
    <option value="Airline">Airline</option>
  </select>
<pre>
Enter customer username, flight number, or airline id: <input type="text" name="name">
</pre>
<input type="submit" value="Submit">
</form>

<br>

SEE BEST CUSTOMER (MOST REVENUE):
<form action="AdminMostRevenueByCustomer.jsp">
<pre>
<input type="submit" value="View">
</pre>
</form>

<br>

SEE 3 MOST ACTIVE FLIGHTS
<form action="AdminCheckActiveFlights.jsp" method="post">
<pre>
<input type="submit" value="View">
</pre>
</form>

<br>

SEE ALL FLIGHTS AT AIRPORT
<form action="AdminCheckFlightsAtAirport.jsp" method="post">
<pre>
AIRPORT ID:
<input type="radio" name="airport" value="AFA"/> Africa Airport
<input type="radio" name="airport" value="ASA"/> Asia Airport
<input type="radio" name="airport" value="EUA"/> Europe Airport
<input type="radio" name="airport" value="NAA"/> North America Airport
<input type="radio" name="airport" value="SAA"/> South America Airport

<input type="submit" value="View">
</pre>
</form>
</body>
</html>