<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "fp.*" %>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body style = "background-color:azure">
<%
	String airport = request.getParameter("airport");
if (airport.isEmpty()) {
	response.sendRedirect("AdminHome.jsp?try=No airport entered please enter one");
	}
	try {
		ConnectDB db = new ConnectDB();	
		Connection con = db.getConnection();	
	
		//Create a SQL statement
		String qry,qry2;
		qry = "Select * From FlyFrom Where FlyFromAirportID =?" ;
		qry2= "Select * From FlyTo Where FlyToAirportID = ?" ;
		PreparedStatement stmt = con.prepareStatement(qry);
		PreparedStatement stmt2 = con.prepareStatement(qry2);
		stmt.setString(1,airport);
		stmt2.setString(1,airport);
		ResultSet result = stmt.executeQuery();
		ResultSet result2 = stmt2.executeQuery();

			out.print("<table>");
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Flights leaving from " + airport );
			out.print("</td>");
			out.print("</tr>");

			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				out.print(result.getString("FlyFromFlightNumber"));
				out.print("</td>");	
				out.print("</tr>");

			}
			out.print("</table>");
			
			
			out.print("<table>");
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Flights going to " + airport );
			out.print("</td>");
			out.print("</tr>");

			while (result2.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				out.print(result2.getString("FlyToFlightNumber"));
				out.print("</td>");	
				out.print("</tr>");

			}
			out.print("</table>");
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