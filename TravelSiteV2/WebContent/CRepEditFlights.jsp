<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta>
<title>Edit Flight</title>
</head>
<body style = "background-color:azure">

<pre>
<form action="ChangeFlight" method="post">
<h1> Edit Customer Flights </h1>
Username <input type="text" name="Username">
TicketNumber <input type="text" name="TicketNumber">

Class
<input type="radio" name="Class" value="econ"/> Economy
<input type="radio" name="Class" value="bus"/> Business
<input type="radio" name="Class" value="first"/> First

Meal
<input type="radio" name="meal" value="Vegetarian"/> Vegetarian
<input type="radio" name="meal" value="Normal"/> Normal
<input type="radio" name="meal" value="Non-Vegetarian"/> Non-Vegetarian

<input type="submit" value="Submit">
</form>
</pre>


</body>
</html>