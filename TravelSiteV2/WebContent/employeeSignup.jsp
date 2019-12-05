<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Sign Up</title>
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
	} else if (details.equals("employee")) {
		out.println("<p>Employee already has an account.</p>");
	} 
}
%> 

<form action="EmployeeSignup" method="post">
<pre>
SSN: <input type="text" name="ssn">
First Name: <input type="text" name="fname">
Last Name: <input type="text" name="lname">
Email: <input type="text" name="email">
Username: <input type="text" name="uname">
Password: <input type="text" name="pass">
		<input type="submit" value="Submit">
</pre>
</form>

</body>
</html>