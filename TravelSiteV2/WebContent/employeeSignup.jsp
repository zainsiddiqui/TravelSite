<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Sign Up</title>
</head>
<style>
	body{
		background-color: azure;
		font-family: cambria;
		text-align: center;
	}
	
	pre{
		font-size: large;
		font-family: cambria;
		text-decoration: underline;
	
	}
	
	input[type=text]{
		border: 2px solid lightblue;
		border-radius: 4px;
		background-color: whitesmoke;
	}
	
	input[type=password]{
		border: 2px solid lightblue;
		border-radius: 4px;
		background-color: whitesmoke;
	}
	
	p{
		color: red;
		font-size: large;
		font-weight: bold;
	}
	a:hover{
		color: hotpink;
	}
</style>

<body>

<%
String link1 = "AdminHome.jsp";
out.println("<a href="+link1+">Back to Admin Home</a>");
String details = request.getParameter("faults");
if (details!= null){
	if (details.equals("empty")){
		out.println("<p>Please fill out every field!</p>");
	} else if (details.equals("email")) {
		out.println("<p>Account with this email already exists!</p>");
	} else if (details.equals("username")) {
		out.println("<p>Username already exists. Please choose another one!</p>");
	} else if (details.equals("employee")) {
		out.println("<p>Employee already has an account!</p>");
	} 
}
%> 
<h2> Enter New Employee Information Here</h2>

<form action="EmployeeSignup" method="post">
<pre>
SSN
<input type="text" name="ssn" placeholder= "i.e. 12-345-6789">
First Name
<input type="text" name="fname" placeholder = "i.e. Jane">
Last Name
<input type="text" name="lname" placeholder = "i.e. Smith">
Email
<input type="text" name="email" placeholder = "i.e. janesmith@gmail.com">
Username
<input type="text" name="uname" placeholder = "Enter Here">
Password
<input type="password" name="pass" placeholder = "Enter Here">
<input type="submit" value="Submit" id = "popUpYes">
</pre>
</form>

</body>
</html>