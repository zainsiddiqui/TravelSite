<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search</title>
</head>
<body style = "background-color:azure">


<br>
<%
String link = "logout.jsp";
out.println("<a href ="+link+">Logout</a>");
//String name = (String)session.getAttribute("username");

String details = request.getParameter("faults");
if (details != null){
	if (details.equals("empty")){
		out.println("<p>Please fill out all fields</p>");
	} 
	if (details.equals("date")){
		out.println("<p>Arrival date cannot be before departure date.</p>");
	}
	if (details.equals("nores")){
		out.println("<p>No flights matched your criteria. Choose another combination.</p>");
	}
}
%>
<br>

<form method="post" action="CRepPostSearch.jsp">
		Customer User <input type="text" name = "Username">
		<h1> Flight Details: </h1>
		Flight type: 
		<br />
		<input type = "radio" name = "tripType"  value = 1 /> One-Way  <br />
		<input type = "radio" name = "tripType" value = 0/> RoundTrip <br />
		
		Class:
		<input type = "radio" name = "classE"  value = econ /> Economy 
		<input type = "radio" name = "classE"  value = first /> First
		<input type = "radio" name = "classE"  value = bus /> Business
		<br /> <br />
		Departure From: 
		<br />
		<input type = "radio" name = "dAirport" value = AFA size = 1/> Africa Airport <br />
		<input type = "radio" name = "dAirport" value = ASA size = 1/> Asia Airport <br />
		<input type = "radio" name = "dAirport" value = EUA size = 1/> Europe Airport <br />
		<input type = "radio" name = "dAirport" value = NAA size = 1/> North America Airport <br />
		<input type = "radio" name = "dAirport" value = SAA size = 1/> South America Airport <br />
		<br /> <br /> 
		Arrival From: 
		<br />
		<input type = "radio" name = "aAirport" value = AFA size = 1/> Africa Airport <br />
		<input type = "radio" name = "aAirport" value = ASA size = 1/> Asia Airport <br />
		<input type = "radio" name = "aAirport" value = EUA size = 1/> Europe Airport <br />
		<input type = "radio" name = "aAirport" value = NAA size = 1/> North America Airport <br />
		<input type = "radio" name = "aAirport" value = SAA size = 1/> South America Airport <br />
		<br />
	
		<!--  drop box for possible departure date -->
		<div class="form-group ">
		Departure Date: <input class="form-control" id="date" name="dDate" placeholder="MM/DD/YYYY" type="text"/>
		</div>
		<br>
		
		<!--  drop box for possible arrival date -->
		<div class="form-group ">
		Arrival Date: <input class="form-control" id="date" name="aDate" placeholder="MM/DD/YYYY" type="text"/>
		
		</div>
		<br>
		
		Flexibility:  
		<input type="radio" name="flex" value="1"/> Yes
		<input type="radio" name="flex" value="0"/> No
		<br>
		
		Sort By:
		<select name="sort" size=1>
			<option value="Price">Price</option>
			<option value="departureDateTime">Departure Time</option>
			<option value="arrivalDateTime">Arrival Time</option>
		</select>&nbsp;
		<br>
		
		Filter By:
		Budget:  <input type="text" name="budget" placeholder="0.00">
		<br>
		
		Airlines: 
		<br />
		<input type="checkbox" name="airlines" value="AA" >American Airlines<br>
		<input type="checkbox" name="airlines" value="UA" >United Airlines<br>
		<input type="checkbox" name="airlines" value="BA" >British Airlines<br>
		<input type="checkbox" name="airlines" value="EK" >Emirates<br>
		<input type="checkbox" name="airlines" value="CA" >Air China<br>
		
		<br>
		Stops?
		<input type="radio" name="stops" value="0" /> Non-stop
		<input type="radio" name="stops" value="1"/> With-Stops
		<br>
		<br>
		<br>
		
		<input type="submit" value="Submit">
</form>



</body>
</html>