<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "fp.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customers on Waitlist</title>
</head>
<body style = "background-color:azure">
<%

try {
	ConnectDB db = new ConnectDB();
	Connection conn = db.getConnection();
	int flight = Integer.parseInt(request.getParameter("FlightNumberInsert"));
	String qry = "SELECT WaitlistUsername FROM Waitlist WHERE WaitlistFlightNumber="+flight;
	Statement stmt = conn.createStatement();
	ResultSet result = stmt.executeQuery(qry);
	out.print("<tr>");
	out.print("<td>");
	out.print("Username\n");
	out.print("</td>");
	out.print("</tr>");
	out.print("<br>");
	while(result.next()){
		out.print("<tr>");
		out.print("<td>");
		out.print(result.getString("WaitlistUsername"));
		out.print("</td>");
		out.print("</tr>");
		out.print("<br>");
	}
	out.print("All results displayed");
	stmt.close();
	db.closeConnection(conn);
} catch (SQLException e) {
	e.printStackTrace();
}




%>
</body>
</html>