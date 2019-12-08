<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "fp.*" %>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ActiveFlights</title>
<style>

	table, td, th {
		border: 2px solid black;
		padding: 5px;
		align: middle;
	}
	
	table{
		border-collapse: separate;
		text-align: center;
		align: middle;
		margin-left: auto;
		margin-right: auto;
	}
		
	pre{
		text-align: center;
		
	}
</style>


</head>
<body style = "background-color:azure">

<%
		try {

			ConnectDB db = new ConnectDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			String qry;
			qry = "Select FlightSequences.FSFlightNumber, Count(Buys.BuysUsername) AS sold From Buys, FlightSequences WHERE FlightSequences.FSTicketNumber = Buys.BuysTicketNumber group by FSFlightNumber Order By sold DESC limit 3";
			PreparedStatement stmt = con.prepareStatement(qry);
			ResultSet result = stmt.executeQuery();
			
			out.print("<table>");
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td style= 'font-size:large; text-decoration: underline'>");
			//print out column header
			out.print("Flight Number");
			out.print("</td>");
			out.print("<td style= 'font-size:large; text-decoration: underline'>");
			//print out column header
			out.print("Tickets Sold");
			out.print("</td>");
			out.print("</tr>");
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				out.print(result.getString("FSFlightNumber"));
				out.print("</td>");	
				out.print("<td>");
				out.print(result.getString("sold"));
				out.print("</td>");
				out.print("</tr>");

			}

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