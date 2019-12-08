<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<style>
	body{
		background-color: azure;
		font-family: arial;
		text-align: center;
	}
	
	pre{
		text-align: center;
		font-family: cambria;
		font-size: large;
		
	}
	
	input[type=text]{
		border: 2px solid lightblue;
		border-radius: 4px;
		background-color: whitesmoke;
		text-align: center;
		
	}
	input[type=password]{
		border: 2px solid lightblue;
		border-radius: 4px;
		background-color: whitesmoke;
		text-align: center;
		
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
String link1 = "home.jsp";
out.println("<a href ="+link1+">Back to Home</a>");

String details = request.getParameter("login");
if (details!= null){
	if (details.equals("fail")){
		out.println("<p><b>Error: Wrong username or password! Please try again!</b></p>");
	}else if (details.equals("empty")){
		out.println("<p><b>Please complete all fields!</b></p>");
	}
}
%>
<h2>Please Sign In Below</h2>
<form action="Login" method="post">
<pre>
Username 
<input type="text" name="username" placeholder= "Enter Here">

Password
<input type="password" name="password" placeholder= "Enter Here">

<input type="submit" value="Submit">
</pre>
</form>
<%
String link2 = "signup.jsp";
out.println("<a href= "+link2+">Don't Have An Account? Sign Up Here!</a>");
%>
</body>
</html>