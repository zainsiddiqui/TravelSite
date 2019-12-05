<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>

<%
String details = request.getParameter("login");
if (details!= null){
	if (details.equals("fail")){
		out.println("<p><b>Error: Wrong username or password. Please try again</b></p>");
	}else if (details.equals("empty")){
		out.println("<p><b>Please complete all fields.</b></p>");
	}
}
%>
<form action="Login" method="post">
<pre>
Username: <input type="text" name="username">
Password: <input type="text" name="password">
		<input type="submit" value="Submit">
</pre>
</form>

</body>
</html>