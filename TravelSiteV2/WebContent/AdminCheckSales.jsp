<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "fp.*" %>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.text.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales</title>
</head>
<body style = "background-color:azure">
<%
List<String> list = new ArrayList<String>();
String date = request.getParameter("date");

if (date==null || date.isEmpty() || date.equals("")) {
	response.sendRedirect("AdminHome.jsp?try=No date entered");
	}
date= date+"/01";

SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
java.sql.Date sqlDate;

java.util.Date utilDate = format.parse(date);
sqlDate = new java.sql.Date(utilDate.getTime());


try {
	//Get the database connection
	ConnectDB db = new ConnectDB();	
	Connection con = db.getConnection();	
	String str = "SELECT SUM(Tickets.fare) AS fare, SUM(Buys.BookingFee) AS fee FROM Customer, Buys, Tickets WHERE Buys.CancelledDate IS NULL and Buys.BuysUsername = Customer.CustomerUsername AND Tickets.TicketNumber = Buys.BuysTicketNumber AND YEAR(Buys.BoughtDate) = YEAR(?) AND MONTH(Buys.BoughtDate) = MONTH(?)";
	String str2 = "	SELECT COUNT(Buys.CancelledDate) AS cancelled FROM Buys WHERE Buys.Class Like 'E%' AND Buys.CancelledDate IS NOT NULL AND  YEAR(Buys.CancelledDate) = YEAR(?) AND MONTH(Buys.CancelledDate) = MONTH(?)";
	
	PreparedStatement stmt = con.prepareStatement(str);
	PreparedStatement stmt2 = con.prepareStatement(str2);

	
	stmt.setDate(1,sqlDate);
	stmt.setDate(2,sqlDate);
	
	stmt2.setDate(1,sqlDate);
	stmt2.setDate(2,sqlDate);

	
	
	ResultSet result = stmt.executeQuery();
	ResultSet result2 = stmt2.executeQuery();

	
	if(result.next() && result2.next())
	{	
		out.print("<table>");
		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print("Money from ticket fares");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Money from booking fees");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Money from cancelled fees");
		out.print("</td>");
		out.print("</tr>");
		
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print(result.getFloat("fare"));
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print(result.getFloat("fee"));
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print(75*result2.getInt("cancelled"));
		out.print("</td>");
		out.print("</tr>");
		out.print("</table>");
	}
	else
		response.sendRedirect("AdminHome.jsp?try= Invalid Date. Try again");
	con.close();
	result.close();
	stmt.close();
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