<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Flights</title>
</head>
<body style = "background-color:azure">
<pre>
<h2>Add a Flight</h2>
<form action = "FlightsAdd" method = "post">
	Flight Number <input type = "text" name ="FlightNumberAdd" >
	Days of Operation <input type = "text" name = "DaysOfOperationAdd">
	Booking Fee <input type = "text" name = "BookingFeeAdd">
	
	Direct or Indirect Flight
	<input type="radio" name="Direct/IndirectAdd" value="Direct"/> Direct
	<input type="radio" name="Direct/IndirectAdd" value="Indirect"/> Indirect
	
	Domestic or International Flight
	<input type="radio" name="Domestic/InternationalAdd" value="Domestic"/> Domestic
	<input type="radio" name="Domestic/InternationalAdd" value="International"/> International
	
	Airline ID
	<input type="radio" name="AirlineIdAdd" value="AA"/> American Airlines
	<input type="radio" name="AirlineIdAdd" value="UA"/> United Airlines
	<input type="radio" name="AirlineIdAdd" value="BA"/> British Airlines
	<input type="radio" name="AirlineIdAdd" value="EK"/> Emirates
	<input type="radio" name="AirlineIdAdd" value="CA"/> Air China
	
	Aircraft ID
	<input type="radio" name="AircraftIdAdd" value="1"/> Emirates Aircraft (Capacity:100)
	<input type="radio" name="AircraftIdAdd" value="100"/> North America Aircraft (Capacity:5)
	<input type="radio" name="AircraftIdAdd" value="101"/> South America Aircraft (Capacity:100)
	<input type="radio" name="AircraftIdAdd" value="102"/> Asia Aircraft (Capacity:100)
	<input type="radio" name="AircraftIdAdd" value="103"/> Europe Aircraft (Capacity:100)
	<input type="radio" name="AircraftIdAdd" value="104"/> Africa Aircraft (Capacity:100)
	<input type="radio" name="AircraftIdAdd" value="2"/> Air China Aircraft (Capacity:200)
	<input type="radio" name="AircraftIdAdd" value="3"/> American Airlines Aircraft (Capacity:100)
	
	Price Economy <input type ="text" name ="PriceEAdd">
	Price Business <input type ="text" name ="PriceBAdd">
	Price First <input type ="text" name ="PriceFAdd">
	
	Departure Airport ID
	<input type="radio" name="DepartureAirportAdd" value="AFA"/> Africa Airport
	<input type="radio" name="DepartureAirportAdd" value="ASA"/> Asia Airport
	<input type="radio" name="DepartureAirportAdd" value="EUA"/> Europe Airport
	<input type="radio" name="DepartureAirportAdd" value="NAA"/> North America Airport
	<input type="radio" name="DepartureAirportAdd" value="SAA"/> South America Airport
	Departure Date and Time ("YYYY-MM-DD hh:mm:ss") <input type = "text" name = "DepartureDateTimeAdd">
	
	Arrival Airport ID
	<input type="radio" name="ArrivalAirportAdd" value="AFA"/> Africa Airport
	<input type="radio" name="ArrivalAirportAdd" value="ASA"/> Asia Airport
	<input type="radio" name="ArrivalAirportAdd" value="EUA"/> Europe Airport
	<input type="radio" name="ArrivalAirportAdd" value="NAA"/> North America Airport
	<input type="radio" name="ArrivalAirportAdd" value="SAA"/> South America Airport
	Arrival Date and Time ("YYYY-MM-DD hh:mm:ss") <input type = "text" name = "ArrivalDateTimeAdd">
	
	
	<input type="submit" value="Add Flight">
	
</form>

<h2>Edit a Flight</h2>
<form action = "FlightsEdit" method = "post">
	Original Flight Number <input type = "text" name ="OriginalFlightNumberEdit" >

	Flight Number <input type = "text" name ="FlightNumberEdit" >
	Days of Operation <input type = "text" name = "DaysOfOperationEdit">
	Booking Fee <input type = "text" name = "BookingFeeEdit">
	
	Direct or Indirect Flight
	<input type="radio" name="Direct/IndirectEdit" value="Direct"/> Direct
	<input type="radio" name="Direct/IndirectEdit" value="Indirect"/> Indirect
	
	Domestic or International Flight
	<input type="radio" name="Domestic/InternationalEdit" value="Domestic"/> Domestic
	<input type="radio" name="Domestic/InternationalEdit" value="International"/> International
	
	Airline ID
	<input type="radio" name="AirlineIdEdit" value="AA"/> American Airlines
	<input type="radio" name="AirlineIdEdit" value="UA"/> United Airlines
	<input type="radio" name="AirlineIdEdit" value="BA"/> British Airlines
	<input type="radio" name="AirlineIdEdit" value="EK"/> Emirates
	<input type="radio" name="AirlineIdEdit" value="CA"/> Air China
	
	Aircraft ID 
	<input type="radio" name="AircraftIdEdit" value="1"/> Emirates Aircraft (Capacity:100)
	<input type="radio" name="AircraftIdEdit" value="100"/> North America Aircraft (Capacity:5)
	<input type="radio" name="AircraftIdEdit" value="101"/> South America Aircraft (Capacity:100)
	<input type="radio" name="AircraftIdEdit" value="102"/> Asia Aircraft (Capacity:100)
	<input type="radio" name="AircraftIdEdit" value="103"/> Europe Aircraft (Capacity:100)
	<input type="radio" name="AircraftIdEdit" value="104"/> Africa Aircraft (Capacity:100)
	<input type="radio" name="AircraftIdEdit" value="2"/> Air China Aircraft (Capacity:200)
	<input type="radio" name="AircraftIdEdit" value="3"/> American Airlines Aircraft (Capacity:100)
	
	Price Economy <input type ="text" name ="PriceEEdit">
	Price Business <input type ="text" name ="PriceBEdit">
	Price First <input type ="text" name ="PriceFEdit">
	
	Departure Airport ID 
	<input type="radio" name="DepartureAirportEdit" value="AFA"/> Africa Airport
	<input type="radio" name="DepartureAirportEdit" value="ASA"/> Asia Airport
	<input type="radio" name="DepartureAirportEdit" value="EUA"/> Europe Airport
	<input type="radio" name="DepartureAirportEdit" value="NAA"/> North America Airport
	<input type="radio" name="DepartureAirportEdit" value="SAA"/> South America Airport
	Departure Date and Time ("YYYY-MM-DD hh:mm:ss") <input type = "text" name = "DepartureDateTimeEdit">
	
	Arrival Airport ID 
	<input type="radio" name="ArrivalAirportEdit" value="AFA"/> Africa Airport
	<input type="radio" name="ArrivalAirportEdit" value="ASA"/> Asia Airport
	<input type="radio" name="ArrivalAirportEdit" value="EUA"/> Europe Airport
	<input type="radio" name="ArrivalAirportEdit" value="NAA"/> North America Airport
	<input type="radio" name="ArrivalAirportEdit" value="SAA"/> South America Airport
	Arrival Date and Time ("YYYY-MM-DD hh:mm:ss") <input type = "text" name = "ArrivalDateTimeEdit">
	
	
	<input type="submit" value="Edit Flight">
	
</form>

<h2>Delete a Flight</h2>
<form action = "FlightsDelete" method = "post">
	Flight Number <input type = "text" name ="FlightNumberDelete" >
	
	
	<input type="submit" value="Delete Flight">
	
</form>
</pre>
</body>
</html>