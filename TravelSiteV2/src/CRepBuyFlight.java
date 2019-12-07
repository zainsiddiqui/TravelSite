

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fp.ConnectDB;
import fp.SearchResult;

/**
 * Servlet implementation class CRBuyFlight
 */
@WebServlet("/CRBuyFlight")
public class CRepBuyFlight extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CRepBuyFlight() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		ArrayList<SearchResult> results = (ArrayList<SearchResult>) request.getSession().getAttribute("FlightSearchResults");
		int index = Integer.parseInt(request.getParameter("index"));
		SearchResult c = results.get(index);
		if (c.round && !c.redirect) {
			request.getSession().setAttribute("chosen", c);
			response.sendRedirect("CRepPostSearchRT.jsp");
		} else {
			String details = request.getParameter("success");
			try {
				ConnectDB db = new ConnectDB();
				Connection conn = db.getConnection();
				String userName = (String)request.getSession().getAttribute("uname");
				System.out.println(userName);
				String qry = "insert into Tickets (SpecialMeal, Fare, Class) values (?, ?, ?)";
				PreparedStatement stmt = conn.prepareStatement(qry);
				stmt.setString(1, "Normal");
				stmt.setFloat(2, c.price);
				stmt.setString(3, c.economy);
				stmt.executeUpdate();
				stmt.close();
				
				String qry1 = "SELECT max(TicketNumber) FROM Tickets";
				PreparedStatement stmt1 =  conn.prepareStatement(qry1);
				ResultSet rs= stmt1.executeQuery();
				int tN = 0;
				if (rs.next()) {
					tN = rs.getInt("max(TicketNumber)");
				}
				System.out.println(userName);	
				String qry2 = "insert into Buys (BuysUsername, BookingFee, BoughtDate, CancelledDate, BuysTicketNumber, Class) values (?, ?, ?, ?, ?, ?)";
				PreparedStatement stmt2 = conn.prepareStatement(qry2);
				stmt2.setString(1, userName);
				stmt2.setFloat(2, 75);
				java.sql.Date date = new java.sql.Date(Calendar.getInstance().getTime().getTime());
				stmt2.setDate(3, date);
				stmt2.setDate(4, null);
				stmt2.setInt(5, tN);
				stmt2.setString(6, c.economy);
				stmt2.executeUpdate();
				stmt.close();
				
				
				int count = 1; 
				
				
				if (c.hasLayover) {
					String qry3 = "insert into FlightSequences (FSFlightNumber, FSTicketNumber, FSOrder, Seat) values (?,?,?,?)";
					PreparedStatement stmt3 = conn.prepareStatement(qry3);
					stmt3.setInt(1, c.flightNumberL);
					stmt3.setInt(2, tN);
					stmt3.setInt(3, count);
					count++;
					stmt3.setInt(4, (int)(Math.random()*900+100));
					stmt3.executeUpdate();
					stmt3.close();
				}
				String qry4 = "insert into FlightSequences (FSFlightNumber, FSTicketNumber, FSOrder, Seat) values (?,?,?,?)";
				PreparedStatement stmt4 = conn.prepareStatement(qry4);
				stmt4.setInt(1, c.flightNumberA);
				stmt4.setInt(2, tN);
				stmt4.setInt(3, count);
				count++;
				stmt4.setInt(4, (int)(Math.random()*400));
			
				stmt4.executeUpdate();
				stmt4.close();
				
				if (c.round) {
					
					if(c.hasLayover1) {
						String qry5 = "insert into FlightSequences (FSFlightNumber, FSTicketNumber, FSOrder, Seat) values (?,?,?,?)";
						PreparedStatement stmt5 = conn.prepareStatement(qry5);
						stmt5.setInt(1, c.flightNumberL1);
						stmt5.setInt(2, tN);
						//Flight Sequence Order
						stmt5.setInt(3, count);
						count++;
						//Setting Random Seat
						stmt5.setInt(4, (int)(Math.random()*400));
						stmt5.executeUpdate();
						stmt5.close();
					}
					String qry6 = "insert into FlightSequences (FSFlightNumber, FSTicketNumber, FSOrder, Seat) values (?,?,?,?)";
					PreparedStatement stmt6 = conn.prepareStatement(qry6);
					stmt6.setInt(1, c.flightNumberA1);
					stmt6.setInt(2, tN);
					//Flight Sequence Order
					stmt6.setInt(3, count);
					count++;
					//Setting Random Seat
					stmt6.setInt(4, (int)(Math.random()*400+400));
					stmt6.executeUpdate();
					stmt6.close();
				}
				
				
				db.closeConnection(conn);
				response.sendRedirect("home.jsp?account=on");
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		
		}
	
		}
	}


