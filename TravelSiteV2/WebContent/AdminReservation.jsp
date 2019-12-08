<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "fp.*" %>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reservation</title>
</head>
<body style = "background-color:azure">
<%
String Res = request.getParameter("AdminReservation");
String cust="";
int flight=-1;
if(Res.equals("1"))
{
	if (request.getParameter("name").matches("[0-9]+"))
		flight =Integer.parseInt(request.getParameter("name"));
	else 
		response.sendRedirect("AdminHome.jsp?try=flight number incorrect try again");

}
else
	cust = request.getParameter("name");
if (cust.isEmpty() && flight==-1) {
	response.sendRedirect("AdminHome.jsp?try=flight or customer not entered");
	}
//out.println(Res + "   " + cust + "    "+ flight);
try {

	ConnectDB db = new ConnectDB();	
	Connection con = db.getConnection();	

	String qry,qry2;
	PreparedStatement stmt,stmt2;
	if(Res.equals("1"))//PROBLEM COULD BE THIS OUTPUTS RES FROM FAR PAST
	{
		qry="SELECT DISTINCT Buys.BuysUsername FROM FlightSequences, Tickets, Buys Where FlightSequences.FSFlightNumber = ? and Tickets.TicketNumber = FlightSequences.FSTicketNumber and Buys.BuysTicketNumber = Tickets.TicketNumber";
		qry2="SELECT DISTINCT Waitlist.WaitlistUsername FROM Waitlist Where Waitlist.WaitlistFlightNumber = ?";

		stmt = con.prepareStatement(qry);
		stmt2 = con.prepareStatement(qry2);
		stmt.setInt(1,flight);
		stmt2.setInt(1,flight);
	}
	else 
	{
		qry="SELECT DISTINCT FlightSequences.FSFlightNUmber FROM Buys, FlightSequences Where Buys.BuysUsername = ? and Buys.BuysTicketNumber = FlightSequences.FSTicketNumber";
		qry2 ="SELECT DISTINCT  Waitlist.WaitlistFlightNumber FROM  Waitlist Where Waitlist.WaitlistUsername = ?";
 
		stmt = con.prepareStatement(qry);
		stmt2 = con.prepareStatement(qry2);
		stmt.setString(1,cust);
		stmt2.setString(1,cust);
	}
 //	out.println(stmt.toString());
	ResultSet result = stmt.executeQuery();
	ResultSet result2 = stmt2.executeQuery();
	
	out.print("<table>");
	//make a row
	out.print("<tr>");
	//print out column header
	out.print("<td>");
	if(Res.equals("1"))
	{
		out.print("User that reserved Flight");
	}
	else
	{	
		out.print("Flights user reserved");
	}
	out.print("</td>");
	out.print("</tr>");
	while(result.next())
	{ 
		out.print("<tr>");
		out.print("<td>");
		if(Res.equals("1"))
		{
			out.print(result.getString("BuysUsername"));
		}
		else
		{	
			out.print(result.getInt("FSFlightNumber"));
		}
		out.print("</td>");
		out.print("</tr>");
	}
	out.print("</table>");
	//------------------------------------------
	out.print("<table>");
	//make a row
	out.print("<tr>");
	//print out column header
	out.print("<td>");
	if(Res.equals("1"))
	{
		out.print("Users on waitlist for flight");
	}
	else
	{	
		out.print("Flights user on waitlist for");
	}
	out.print("</td>");
	out.print("</tr>");
	while(result2.next())
	{
		out.print("<tr>");
		out.print("<td>");
		if(Res.equals("1"))
		{
			out.print(result2.getString("WaitlistUsername"));
		}
		else
		{	
			out.print(result2.getInt("WaitlistFlightNumber"));
		}
		out.print("</td>");
		out.print("</tr>");
	}
	out.print("</table>");
	
	//close the connection.
	con.close();
	result.close();
	result2.close();
	stmt.close();
	stmt2.close();
	db.closeConnection(con);
} catch (Exception e) {
}
%>
<form action="AdminHome.jsp" method="post">
<pre>
	<input type="submit" value="Admin Home">
</pre>
</form>
</body>
</html>

