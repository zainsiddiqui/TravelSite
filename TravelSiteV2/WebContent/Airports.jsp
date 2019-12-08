<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Airports</title>
</head>
<body style = "background-color:azure">
<pre>
<form action = "AirportsAdd" method = "post">
Add an Airport 
	Airport ID <input type = "text" name ="IDAdd" >
	Name <input type ="text" name = "AirportNameAdd">
	City <input type ="text" name = "AirportCityAdd">
	Country <input type ="text" name = "AirportCountryAdd">
	<input type="submit" value="Add Airport">
</form>

<form action = "AirportsEdit" method = "post">
Edit an Airport
	Airport Original ID <input type = "text" name ="OriginalIDEdit" >
	
	Airport ID <input type = "text" name ="IDEdit" >
	Name <input type ="text" name = "AirportNameEdit">
	City <input type ="text" name = "AirportCityEdit">
	Country <input type ="text" name = "AirportCountryEdit">
	<input type="submit" value="Edit Airport">
</form>

<form action = "AirportsDelete" method = "post">
Delete an Airport
	Airport ID <input type = "text" name ="IDDelete" >
	<input type="submit" value="Delete Airport">
</form>

</pre>
</body>
</html>