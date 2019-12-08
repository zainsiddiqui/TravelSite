<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Signup</title>
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
	
	a:hover{
		color: hotpink;
	}
	
	p{
		color: red;
		font-size: large;
		font-weight: bold;
	}
</style>
</head>
<body>
<%

String link2 = "home.jsp";
out.println("<a href ="+link2+">Back to Home</a>");
String details = request.getParameter("faults");
if (details!= null){
if (details.equals("empty")){
out.println("<p>Please fill out every field!</p>");
} else if (details.equals("email")) {
out.println("<p>Account with this email already exists!</p>");
} else if (details.equals("username")) {
out.println("<p>Username already exists. Please choose another one!</p>");
}
}
%>
<h2> Enter User Information Below</h2>
<form action="Signup" method="post">
<pre>
First Name
<input type="text" name="firstName" placeholder= "i.e. John">

Last Name
<input type="text" name="lastName" placeholder = "i.e. Doe">

Email
<input type="text" name="email" placeholder = "i.e. johndoe@gmail.com">

Username
<input type="text" name="username" placeholder ="Enter Here">

Password
<input type="password" name="password" placeholder = "Enter Here">

<input type="submit" value="Submit">
</pre>
</form>
<%
String link1 = "login.jsp";
out.println("<a href= "+link1+">Already Have An Account? Login Here</a>");
%>

</body>
</html>