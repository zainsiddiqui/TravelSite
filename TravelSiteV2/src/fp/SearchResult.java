package fp;

import java.sql.*;
import java.util.Comparator;
import java.time.*;

public class SearchResult{
	public String departureAirport;
	public java.sql.Date departureDate;
	public java.sql.Time departureTime;
	
	public int flightNumberL;
	public Boolean hasLayover = false;
	public String layoverAirport; 
	public java.sql.Date layoverDate;
	public java.sql.Time layoverTime;
	
	public int flightNumberA;
	public String arrivalAirport;
	public java.sql.Date arrivalDate;
	public java.sql.Time arrivalTime;
	
	public Boolean round = false;
	public String departureAirport1;
	public java.sql.Date departureDate1;
	public java.sql.Time departureTime1;
	
	public int flightNumberL1;
	public Boolean hasLayover1 = false;
	public String layoverAirport1; 
	public java.sql.Date layoverDate1;
	public java.sql.Time layoverTime1;
	
	public int flightNumberA1;
	public String arrivalAirport1;
	public java.sql.Date arrivalDate1;
	public java.sql.Time arrivalTime1;
	
	public String economy; 
	public String airlineID;
	public Boolean full = false;
	public Float price = (float) 0.00;
	
	public boolean redirect = false; 
	public String dAirport;
	public String dDates;
	public int stops;
	public String sortType;
	public String budget = "";
	public String flex;
	public String aDates;
	public String aAirport;
	
	public SearchResult() {
		
	}
	
	public SearchResult(SearchResult a) {
		this.departureAirport = a.departureAirport;
		this.departureDate = a.departureDate;
		this.departureTime = a.departureTime;
		
		this.flightNumberL = a.flightNumberL;
		this.hasLayover = a.hasLayover;
		this.layoverAirport = a.layoverAirport;
		this.layoverDate = a.layoverDate;
		this.layoverTime = a.layoverTime;
		
		this.flightNumberA = a.flightNumberA;
		this.arrivalAirport = a.arrivalAirport;
		this.arrivalDate = a.arrivalDate;
		this.arrivalTime = a.arrivalTime;
		
		this.round = a.round;
		
		this.economy = a.economy; 
		this.airlineID = a.airlineID;
		this.full = a.full;
		this.price = a.price;
		
		this.redirect =a.redirect ; 
		this.dAirport = a.dAirport;
		this.dDates = a.dDates;
		this.stops = a.stops;
		this.sortType = a.sortType;
		this.budget = a.budget;
		this.flex = a.flex;
		this.aDates = a.aDates;
		this.aAirport = a.aAirport;
	}
	
	public static Comparator<SearchResult> FlightPrice = new Comparator<SearchResult>() {
		public int compare(SearchResult s1, SearchResult s2) {
		   return (int) (s1.price-s2.price); 
	}};
	
	public static Comparator<SearchResult> FlightDepartureTime = new Comparator<SearchResult>() {
		public int compare(SearchResult s1, SearchResult s2) {
			
			LocalDate s1Date = s1.departureDate.toLocalDate();		
	        LocalTime s1Time = s1.departureTime.toLocalTime();
	        LocalDateTime s1DateTime = s1Time.atDate(s1Date); 
			
	        LocalDate s2Date = s2.departureDate.toLocalDate();		
	        LocalTime s2Time = s2.departureTime.toLocalTime();
	        LocalDateTime s2DateTime = s2Time.atDate(s2Date); 
	        
			return (int) (s1DateTime.compareTo(s2DateTime)); 
	}};
	
	public static Comparator<SearchResult> FlightArrivalTime = new Comparator<SearchResult>() {
		public int compare(SearchResult s1, SearchResult s2) {
			
			if (s1.round && s1.redirect) {
				LocalDate s1Date = s1.arrivalDate1.toLocalDate();		
		        LocalTime s1Time = s1.arrivalTime1.toLocalTime();
		        LocalDateTime s1DateTime = s1Time.atDate(s1Date); 
				
		        LocalDate s2Date = s2.arrivalDate1.toLocalDate();		
		        LocalTime s2Time = s2.arrivalTime1.toLocalTime();
		        LocalDateTime s2DateTime = s2Time.atDate(s2Date); 
		        
				return (s1DateTime.compareTo(s2DateTime)); 
			}
			
			LocalDate s1Date = s1.arrivalDate.toLocalDate();		
	        LocalTime s1Time = s1.arrivalTime.toLocalTime();
	        LocalDateTime s1DateTime = s1Time.atDate(s1Date); 
			
	        LocalDate s2Date = s2.arrivalDate.toLocalDate();		
	        LocalTime s2Time = s2.arrivalTime.toLocalTime();
	        LocalDateTime s2DateTime = s2Time.atDate(s2Date); 
	        
			return (s1DateTime.compareTo(s2DateTime)); 
			
	}};
	
	public static Comparator<SearchResult> FlightDepartureTime1 = new Comparator<SearchResult>() {
		public int compare(SearchResult s1, SearchResult s2) {
			
			LocalDate s1Date = s1.departureDate1.toLocalDate();		
	        LocalTime s1Time = s1.departureTime1.toLocalTime();
	        LocalDateTime s1DateTime = s1Time.atDate(s1Date); 
			
	        LocalDate s2Date = s2.departureDate1.toLocalDate();		
	        LocalTime s2Time = s2.departureTime1.toLocalTime();
	        LocalDateTime s2DateTime = s2Time.atDate(s2Date); 
	        
			return (int) (s1DateTime.compareTo(s2DateTime)); 
	}};
	
}
