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
<body>
<%  

 		List<String> list = new ArrayList<String>();
		String details = request.getParameter("searchCustomer");
		if (details.isEmpty()) {
			response.sendRedirect("AdminHome.jsp?try=Please enter a Username!!!");
			}
		try {
			
			//Get the database connection
			ConnectDB db = new ConnectDB();	
			Connection con = db.getConnection();	
			
	
			String str = "select * from Account where Username =?";
			PreparedStatement stmt = con.prepareStatement(str);
			stmt.setString(1,details);
			ResultSet rs = stmt.executeQuery();
			
			if (rs.next()) {
			//out.print(result.getString("Username"));
				if(rs.getString("AccountType") == "admin")
					response.sendRedirect("AdminHome.jsp?try=Error! This is the admin account");
			//Make an HTML table to show the results in:
			out.print("<table>");
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Username");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Password");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Email");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Name");
			out.print("</td>");
			out.print("</tr>");
			
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print(rs.getString("Username"));
			out.print("</td>");
			out.print("<td>");
			out.print(rs.getString("Password"));
			out.print("</td>");
			out.print("<td>");
			out.print(rs.getString("Email"));
			out.print("</td>");
			out.print("<td>");
			out.print(rs.getString("Name"));
			out.print("</td>");
			out.print("</tr>");
			out.print("</table>");
			}
			else 
				response.sendRedirect("AdminHome.jsp?try=User does not exist!");
			
			con.close();
			rs.close();
			stmt.close();
			db.closeConnection(con);
		
		} catch (Exception e) {
		}
%>
<form action="AdminEditCustomer" method="post">
<pre>
*New Username field must be filled out when Editing or Deleting*
Search: The entered users information is listed above, hit Submit without entering any info to return 
        to home screen
Edit: Enter the username you want to edit in New Username field and change any values you wish to edit. 
      Keep in mind if you leave any boxes empty it will set that boxes information to NULL
Delete: Enter the username you want to delete the information for in New Username and leave blank 
        the information you wish to delete
<%---/*Username: ---%><input type="hidden" name="oldUsername" value =<%=request.getParameter("searchCustomer")%>>
Enter New Username: <input type="text" name="newUsername">
Enter New Password: <input type="text" name="newPassword">
Enter New Email: <input type="text" name="newEmail">
Enter New Name: <input type="text" name="newName">
	<input type="submit" value="Submit">
</pre>
</form>
</body>
</html>