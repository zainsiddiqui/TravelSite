<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Signup</title>
</head>
<body>
<%
String details = request.getParameter("faults");
if (details!= null){
if (details.equals("empty")){
out.println("<p>Please fill out every field.</p>");
} else if (details.equals("email")) {
out.println("<p>Account with this email already exists.</p>");
} else if (details.equals("username")) {
out.println("<p>Username already exists. Please choose another one.</p>");
}
}
%>


<form action="Signup" method="post">
<pre>
First Name: <input type="text" name="firstName">
Last Name: <input type="text" name="lastName">
Email: <input type="text" name="email">
Username: <input type="text" name="username">
Password: <input type="text" name="password">
<input type="submit" value="Submit">
</pre>
</form>


</body>
</html>
