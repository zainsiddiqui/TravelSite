

import java.io.IOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import fp.ConnectDB;
/**
 * Servlet implementation class ChangeFlight
 */
@WebServlet("/ChangeFlight")
public class ChangeFlight extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeFlight() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
		int tN = Integer.parseInt( request.getParameter("TicketNumber"));
		String Class = request.getParameter("Class");
		float Fare = 0;
		String meal = request.getParameter("meal");
		String Username = request.getParameter("Username");
		
		try {
			ConnectDB db = new ConnectDB();
			Connection conn = db.getConnection();
			
			String ClasstoSearch = Class.substring(0, 1).toUpperCase();
			
			String qr = "Select Class from Tickets where TicketNumber="+tN;
			Statement stm = conn.prepareStatement(qr);
			ResultSet result = stm.executeQuery(qr);
			result.next();
			String temp = result.getString("Class");
			temp = temp.toLowerCase();
			
			String qr1 = "Select sum(Price"+ClasstoSearch+") from Flights, FlightSequences where FSFlightNumber=FlightNumber and FSTicketNumber="+tN;
			Statement stm1 = conn.prepareStatement(qr1);
			ResultSet result1 = stm1.executeQuery(qr1);
			result1.next();
			float fare = result1.getFloat("sum(Price"+ClasstoSearch+")");
			
			String qr2 = "Select Fare from Tickets where TicketNumber="+tN;
			Statement stm2 = conn.prepareStatement(qr2);
			ResultSet result2 = stm2.executeQuery(qr2);
			result2.next();
			Fare = result2.getFloat("Fare");
			
			if(ClasstoSearch.equals(temp.toUpperCase())) {
				Fare = Fare;
			}
			else {
				Fare = fare;
			}
			
			if(temp.substring(0, 1).equals("e")){
				Fare = Fare + 75;
			}
			
			
			String qry = "update Tickets set SpecialMeal=?, Fare=?, Class=?  where TicketNumber=?";
			PreparedStatement stmt = conn.prepareStatement(qry);
			stmt.setString(1, meal); 
			stmt.setFloat(2,Fare);
			stmt.setString(3, Class);
			stmt.setInt(4, tN); 
			stmt.executeUpdate();
			stmt.close();
			
			
			String qry2 = "update Buys set Class=? where BuysTicketNumber=? and BuysUsername=?";
			PreparedStatement stmt2 = conn.prepareStatement(qry2);
			stmt2.setString(1,Class);
			stmt2.setInt(2,tN);
			stmt2.setString(3,Username);
			stmt2.executeUpdate();
			stmt2.close();
			
			
			db.closeConnection(conn);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		response.sendRedirect("home.jsp?account=on");

	}
}


