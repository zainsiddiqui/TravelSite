<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search</title>
</head>
<body style = "background-color:azure">
<style>
h1 {
text-align: center;
}
label {
color: black;
font-weight: bold;
display: block;
width: 150px;
float: left;
}
input[type=radio] {
    padding-left:5px;
    padding-right:5px;
    border-radius:15px;
    -webkit-appearance:button;
    border: double 2px #00F;
    background-color:white;
    color:#FFF;
    white-space: nowrap;
    overflow:hidden;
    width:15px;
    height:15px;
}
input[type=radio]:checked {
    background-color:#000;
}
input[type = submit] {
  background-color: #4CAF50; 
  color: white;
  padding: 15px 32px;
  text-align: center;
  display: inline-block;
  font-size: 16px;
}


</style>

<%
String link = "signout.jsp";
out.println("<a href ="+link+">Signout</a>");
String name = (String)session.getAttribute("username");

String link1 = "ticketHistory.jsp";
out.println("<a href ="+link1+">Ticket History</a>");

String link2 = "search.jsp?faults=none";
out.println("<a href ="+link2+">Search Flights</a>");

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
	if (details.equals("tooLong")){
		out.println("<p>You waited too long to buy a ticket. You need to try again.</p>");
	}
}
%>


<form method="post" action="postSearch1.jsp">
		
		<h1> Flight Details: </h1>
		<label> Flight type: </label>
		<br />
		<input type = "radio" name = "tripType"  value = 1 /> One-Way  <br />
		<input type = "radio" name = "tripType" value = 0/> RoundTrip <br />
		
		<label> Class: </label>
		<br />
		<input type = "radio" name = "classE"  value = econ /> Economy 
		<input type = "radio" name = "classE"  value = first /> First
		<input type = "radio" name = "classE"  value = bus /> Business
		<br /> <br />
		<label> Departure From: </label>
		<br />
		<input type = "radio" name = "dAirport" value = AFA size = 1/> Africa Airport <br />
		<input type = "radio" name = "dAirport" value = ASA size = 1/> Asia Airport <br />
		<input type = "radio" name = "dAirport" value = EUA size = 1/> Europe Airport <br />
		<input type = "radio" name = "dAirport" value = NAA size = 1/> North America Airport <br />
		<input type = "radio" name = "dAirport" value = SAA size = 1/> South America Airport <br />
		<br /> <br /> 
		<label> Arrival From: </label>
		<br />
		<input type = "radio" name = "aAirport" value = AFA size = 1/> Africa Airport <br />
		<input type = "radio" name = "aAirport" value = ASA size = 1/> Asia Airport <br />
		<input type = "radio" name = "aAirport" value = EUA size = 1/> Europe Airport <br />
		<input type = "radio" name = "aAirport" value = NAA size = 1/> North America Airport <br />
		<input type = "radio" name = "aAirport" value = SAA size = 1/> South America Airport <br />
		<br />
	
		<div class="form-group ">
		<label> Departure Date: </label> <input class="form-control" id="date" name="dDate" placeholder="MM/DD/YYYY" type="text"/>
		</div>
		<br>
		
		<div class="form-group ">
		<label> Arrival Date: </label> <input class="form-control" id="date" name="aDate" placeholder="MM/DD/YYYY" type="text"/>
		
		</div>
		<br>
		
		<label> Flexibility:  </label>
		<input type="radio" name="flex" value="1"/> Yes
		<input type="radio" name="flex" value="0"/> No
		<br>
		
		<label> Sort By: </label>
		<select name="sort" size=1>
			<option value="Price">Price</option>
			<option value="departureDateTime">Departure Time</option>
			<option value="arrivalDateTime">Arrival Time</option>
		</select>&nbsp;
		<br>
		<br />
		<label> Filter By: </label>
		<br /> <br />
		<label> Budget: </label> <input type="text" name="budget" placeholder="0.00">
		<br>
		<br />
		<label> Airlines: </label>
		<br />
		<input type="checkbox" name="airlines" value="AA" >American Airlines<br>
		<input type="checkbox" name="airlines" value="UA" >United Airlines<br>
		<input type="checkbox" name="airlines" value="BA" >British Airlines<br>
		<input type="checkbox" name="airlines" value="EK" >Emirates<br>
		<input type="checkbox" name="airlines" value="CA" >Air China<br>
		
		<br>
		<label> Stops? </label>
		<input type="radio" name="stops" value="0" /> Non-stop
		<input type="radio" name="stops" value="1"/> With-Stops
		<br>
		<br>
		<br>
		
		<input type="submit" value="Submit">
</form>
</body>
</html>