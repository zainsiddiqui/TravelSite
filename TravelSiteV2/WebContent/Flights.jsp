<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Flights</title>
</head>
<body>
<pre>
Add a Flight
<form action = "FlightsAdd" method = "post">

	Flight Number <input type = "text" name ="FlightNumberAdd" >
	Days of Operation <input type = "text" name = "DaysOfOperationAdd">
	Booking Fee <input type = "text" name = "BookingFeeAdd">
	Direct/Indirect <input type = "text" name = "Direct/IndirectAdd">
	Domestic/International <input type = "text" name = "Domestic/InternationalAdd">
	Airline ID <input type = "text" name = "AirlineIdAdd">
	Aircraft ID <input type = "text" name = "AircraftIdAdd">
	Price Economy <input type ="text" name ="PriceEAdd">
	Price Business <input type ="text" name ="PriceBAdd">
	Price First <input type ="text" name ="PriceFAdd">
	Arrival Date and Time ("YYYY-MM-DD hh:mm:ss") <input type = "text" name = "ArrivalDateTimeAdd">
	Departure Date and Time ("YYYY-MM-DD hh:mm:ss") <input type = "text" name = "DepartureDateTimeAdd">
	Arrival Airport ID <input type = "text" name = "ArrivalAirportAdd">
	Departure Airport ID <input type = "text" name = "DepartureAirportAdd">
	
	<input type="submit" value="Add Flight">
	
</form>

Edit a Flight
<form action = "FlightsEdit" method = "post">
	Original Flight Number <input type = "text" name ="OriginalFlightNumberEdit" >

	Flight Number <input type = "text" name ="FlightNumberEdit" >
	Days of Operation <input type = "text" name = "DaysOfOperationEdit">
	Booking Fee <input type = "text" name = "BookingFeeEdit">
	Direct/Indirect <input type = "text" name = "Direct/IndirectEdit">
	Domestic/International <input type = "text" name = "Domestic/InternationalEdit">
	Arrival Date and Time ("YYYY-MM-DD hh:mm:ss") <input type = "text" name = "ArrivalDateTimeEdit">
	Departure Date and Time ("YYYY-MM-DD hh:mm:ss") <input type = "text" name = "DepartureDateTimeEdit">
	Arrival Airport ID <input type = "text" name = "ArrivalAirportEdit">
	Departure Airport ID <input type = "text" name = "DepartureAirportEdit">
	Airline ID <input type = "text" name = "AirlineIdEdit">
	Aircraft ID <input type = "text" name = "AircraftIdEdit">
	Price Economy <input type ="text" name ="PriceEEdit">
	Price Business <input type ="text" name ="PriceBEdit">
	Price First <input type ="text" name ="PriceFEdit">
	<input type="submit" value="Edit Flight">
	
</form>

Delete a Flight
<form action = "FlightsDelete" method = "post">
	Flight Number <input type = "text" name ="FlightNumberDelete" >
	<input type="submit" value="Delete Flight">
	
</form>
</pre>
</body>
</html>