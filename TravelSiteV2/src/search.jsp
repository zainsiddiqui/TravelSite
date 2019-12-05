<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search</title>
</head>
<body>
<%
String signout = "signout.jsp";
out.println("<a href ="+signout+">Signout</a>");

String ticketHistory ="ticketHistory.jsp";
out.println("<a href =" + ticketHistory+">Ticket History</a");

%>

<form method = "post" action = "postSearch.jsp">
	<h1> Flight Details: </h1>
	Flight type: 
	<br />
	<input type = "radio" name = "fType"  value = 1 /> One-Way 
	<!-- String ftype = request.getParameter(fType) -->
	<br />
	<input type = "radio" name = "fType" value = 0/> RoundTrip
	<br /> 
	<br />
	Class Type:
	<input type = "radio" name = "classType"  value = econ /> Economy 
	<input type = "radio" name = "classType"  value = first /> First
	<input type = "radio" name = "classType"  value = bus /> Business
		<br> <br /> <br />
	Departure From: 
	<br />
	<input type = "radio" name = "dPort" value = EWR /> Newark Liberty International Airport <br />
	<input type = "radio" name = "dPort" value = LGA/> LaGuardia Airport <br />
	<input type = "radio" name = "dPort" value = JFK/> John F. Kennedy International Airport <br />
	<input type = "radio" name = "dPort" value = HKG /> Hong Kong International Airport <br />
	<input type = "radio" name = "dPort" value = LAX /> Los Angeles Internaional Airport <br />
	<br /> <br /> 
	Arrival From: 
	<br />
	<input type = "radio" name = "aPort" value = EWR /> Newark Liberty International Airport <br />
	<input type = "radio" name = "aPort" value = LGA/> LaGuardia Airport <br />
	<input type = "radio" name = "aPort" value = JFK/> John F. Kennedy International Airport <br />
	<input type = "radio" name = "aPort" value = HKG /> Hong Kong International Airport <br />
	<input type = "radio" name = "aPort" value = LAX /> Los Angeles Internaional Airport <br />
	<br />
	<label> Departure Date: </label>
	<select name = "dMonth">
		<option> Month </option>
		<option value = "01"> January </option>
		<option value = "02"> February </option>
		<option value = "03"> March </option>
		<option value = "04"> April </option>
		<option value = "05"> May </option>
		<option value = "06"> June </option>
		<option value = "07"> July </option>
		<option value = "08"> August </option>
		<option value = "09"> September </option>
		<option value = "10"> October </option>
		<option value = "11"> November </option>
		<option value = "12"> December </option>
	</select>
	<select name = "dDay">
		<option> Day </option>
		<option value = "01"> 1 </option> 
		<option value = "02"> 2 </option>
		<option value = "03"> 3 </option>
		<option value = "04"> 4 </option>
		<option value = "05"> 5 </option>
		<option value = "06"> 6 </option>
		<option value = "07"> 7 </option>
		<option value = "08"> 8 </option>
		<option value = "09"> 9 </option>
		<option value = "10"> 10 </option>
		<option value = "11"> 11 </option>
		<option value = "12"> 12 </option> <option value = "13"> 13 </option> <option value = "14"> 14 </option> <option value = "15"> 15 </option> <option value = "16"> 16 </option> <option value = "17"> 17 </option> <option value = "18"> 18 </option> <option value = "19"> 19 </option> <option value = "20"> 20 </option>
		<option value = "21"> 21 </option> <option value = "22"> 22 </option> <option value = "23"> 23 </option> <option value = "24"> 24 </option> <option value = "25"> 25 </option> <option value = "26"> 26 </option> <option value = "27"> 27 </option> <option value = "28"> 28 </option> <option value = "29"> 29 </option> <option value = "30"> 30 </option> <option value = "31"> 31 </option>
	</select>
	<select name = "dYear">
		<option> Year </option>
		<option value = "2019"> 2019 </option> 
		<option value = "2020"> 2020 </option>
	</select>	
	<br />
	<label> Arrival Date: </label>
	<select name = "aMonth">
		<option> Month </option>
		<option value = "01"> January </option>
		<option value = "02"> February </option>
		<option value = "03"> March </option>
		<option value = "04"> April </option>
		<option value = "05"> May </option>
		<option value = "06"> June </option>
		<option value = "07"> July </option>
		<option value = "08"> August </option>
		<option value = "09"> September </option>
		<option value = "10"> October </option>
		<option value = "11"> November </option>
		<option value = "12"> December </option>
	</select>
	<select name = "aDay">
		<option> Day </option>
		<option value = "01"> 1 </option> 
		<option value = "02"> 2 </option>
		<option value = "03"> 3 </option>
		<option value = "04"> 4 </option>
		<option value = "05"> 5 </option>
		<option value = "06"> 6 </option>
		<option value = "07"> 7 </option>
		<option value = "08"> 8 </option>
		<option value = "09"> 9 </option>
		<option value = "10"> 10 </option>
		<option value = "11"> 11 </option>
		<option value = "12"> 12 </option> <option value = "13"> 13 </option> <option value = "14"> 14 </option> <option value = "15"> 15 </option> <option value = "16"> 16 </option> <option value = "17"> 17 </option> <option value = "18"> 18 </option> <option value = "19"> 19 </option> <option value = "20"> 20 </option>
		<option value = "21"> 21 </option> <option value = "22"> 22 </option> <option value = "23"> 23 </option> <option value = "24"> 24 </option> <option value = "25"> 25 </option> <option value = "26"> 26 </option> <option value = "27"> 27 </option> <option value = "28"> 28 </option> <option value = "29"> 29 </option> <option value = "30"> 30 </option> <option value = "31"> 31 </option>
	</select>
	<select name = "aYear">
		<option> Year </option>
		<option value = "2019"> 2019 </option> 
		<option value = "2020"> 2020 </option>
	</select>	
	<br />
	Flexibility:  
		<input type="checkbox" name="flex" value="1"/> Yes
		<input type="checkbox" name="flex" value="0"/> No
		<br>
	Sort By:
		<select name="sort" size=1>
			<option value="Price">Price</option>
			<option value="departureDateTime">Departure Time</option>
			<option value="arrivalDateTime">Arrival Time</option>
		</select>&nbsp;
		<br>
	Filter By:
		<select name ="filter" size = 1>
			<option value = "Price"> Price </option>
			<option value = "NumStops"> Number of Stops </option>
			<option value =  "Airline"> Airline </option>
		</select> <br />
		Airlines: 
		<br />
		<input type="checkbox" name="airline" value="AA" >American Airlines<br>
		<input type="checkbox" name="airline" value="UA" >United Airlines<br>
		<input type="checkbox" name="airline" value="BA" >British Airlines<br>
		<input type="checkbox" name="airline" value="EK" >Emirates<br>
		<input type="checkbox" name="airline" value="CA" >Air China<br>
		
		<br>
		Number of Stops:
		<br />
		<input type="radio" name="stops" value="0" /> Non-stop
		<input type="radio" name="stops" value="1"/> Stops
		<br>
		<input type="submit" value="Submit">
</form>
</body>
</html>