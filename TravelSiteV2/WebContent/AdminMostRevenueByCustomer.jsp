<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "fp.*" %>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Most Revenue By Customer</title>

<style>
	body{
		background-color: azure;
		text-align: center;
		font-weight: bold;
	}
	table, td, th{
		border-collapse: separate;
		text-align: center;
		align: middle;
		margin-left: auto;
		margin-right: auto;
	}
</style>
</head>
<body>
<%
			String qry,maxCust="";
			Float maxMun=(float)0;
		
try {

			ConnectDB db = new ConnectDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			qry = "	SELECT Buys.BuysUsername, SUM(If (Buys.CancelledDate IS NULL, Buys.BookingFee + Tickets.Fare , if(Buys.Class Like 'E%',75,0) )) AS mon FROM Buys, Tickets WHERE Tickets.TicketNumber = Buys.BuysTicketNumber GROUP BY BuysUsername ORDER BY mon DESC LIMIT 1 ";
			PreparedStatement stmt = con.prepareStatement(qry);
			ResultSet result = stmt.executeQuery();
			while (result.next())
			{
				if(maxMun < (result.getFloat("mon")))
				{
					maxCust=result.getString("BuysUsername");
					maxMun=result.getFloat("mon");
				}

			}
			
			out.print("<table>");
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print(maxCust+ " has generated the most revenue!");
			out.print("</td>");
			out.print("</tr>");
			
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("$"+maxMun);
			out.print("</td>");
			out.print("</tr>");

			

			out.print("</table>");
	
			//close the connection.
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