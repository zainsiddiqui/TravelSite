<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Aircrafts</title>
</head>
<body style = "background-color:azure">
<pre>
<form action = "AircraftAdd" method = "post">
Add an Aircraft 
	Airline Owner ID<input type = "text" name ="AirlineOwnerAdd" >
	Aircraft ID <input type = "text" name ="AircraftID" >
	Capacity <input type ="text" name = "CapacityAdd">
	Name of Aircraft<input type ="text" name = "AircraftNameAdd">
	<input type="submit" value="Add Aircraft">
</form>

Edit an Aircraft
<form action = "AircraftEdit" method = "post">

	Old Aircraft ID <input type = "text" name ="IDEdit" >

	Airline Owner ID<input type = "text" name ="AirlineOwnerEdit" >
	Aircraft ID <input type = "text" name ="AircraftID" >
	Capacity <input type ="text" name = "CapacityEdit">
	Name of Aircraft <input type ="text" name = "AircraftNameEdit">
	<input type="submit" value="Edit Aircraft">
</form>

Delete an Aircraft
<form action = "AircraftDelete" method = "post">
	Aircraft ID <input type = "text" name ="AircraftID" >
	<input type="submit" value="Delete Aircraft">
</form>
</pre>
</body>
</html>