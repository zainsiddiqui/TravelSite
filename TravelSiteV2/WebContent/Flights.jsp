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

	Flight Number <input type = "text" name ="FlightNumberInsert" >
	Days of Operation <input type = "text" name = "DaysOfOperationInsert">
	Booking Fee <input type = "text" name = "BookingFeeInsert">
	Direct/Indirect <input type = "text" name = "Direct/IndirectInsert">
	Domestic/International <input type = "text" name = "Domestic/InternationalInsert">
	Airline ID <input type = "text" name = "AirlineIdInsert">
	Aircraft ID <input type = "text" name = "AircraftIdInsert">
	Price Economy <input type ="text" name ="PriceEInsert">
	Price Business <input type ="text" name ="PriceBInsert">
	Price First <input type ="text" name ="PriceFInsert">
	Arrival Time <input type = "text" name = "ArrivalTimeInsert">
	Arrival Date <input type = "text" name = "ArrivalDateInsert">
	Departure Time <input type = "text" name = "DepartureTimeInsert">
	Departure Date <input type = "text" name = "DepartureDateInsert">
	Arrival Airport <input type = "text" name = "ArrivalAirportInsert">
	Departure Airport <input type = "text" name = "DepartureAirportInsert">
	
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
	Arrival Time <input type = "text" name = "ArrivalTimeEdit">
	Arrival Date <input type = "text" name = "ArrivalDateEdit">
	Departure Time <input type = "text" name = "DepartureTimeEdit">
	Departure Date <input type = "text" name = "DepartureDateEdit">
	Arrival Airport <input type = "text" name = "ArrivalAirportEdit">
	Departure Airport <input type = "text" name = "DepartureAirportEdit">
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