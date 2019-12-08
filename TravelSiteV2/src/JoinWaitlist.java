

import java.io.IOException;
import java.util.ArrayList;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fp.ConnectDB;
import fp.SearchResult;

/**
 * Servlet implementation class JoinWaitlist
 */
@WebServlet("/JoinWaitlist")
public class JoinWaitlist extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JoinWaitlist() {
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
		ArrayList<SearchResult> results = (ArrayList<SearchResult>) request.getSession().getAttribute("FlightSearchResults");
		int index = Integer.parseInt(request.getParameter("index"));
		SearchResult c = results.get(index);
		if (c.round && !c.redirect) {
			request.getSession().setAttribute("chosen", c);
			response.sendRedirect("postSearch1Round.jsp");
		} else {
			
			try {
				ConnectDB db = new ConnectDB();
				Connection conn = db.getConnection();
				String uname = (String)request.getSession().getAttribute("username");
				String qry = "insert into Waitlist (WaitlistUsername, WaitlistFlightNumber) values (?, ?)";
				PreparedStatement stmt = conn.prepareStatement(qry);
				stmt.setString(1, uname);
				stmt.setInt(2, c.flightNumberA);
				stmt.executeUpdate();
				stmt.close();
				
				if(c.hasLayover) {
					String qry1 = "insert into Waitlist (WaitlistUsername, WaitlistFlightNumber) values (?, ?)";
					PreparedStatement stmt1 = conn.prepareStatement(qry1);
					stmt1.setString(1, uname);
					stmt1.setInt(2, c.flightNumberL);
					stmt1.executeUpdate();
					stmt1.close();
				}
				if(c.round) {
				
					if(c.hasLayover1) {
						String qry2 = "insert into Waitlist (WaitlistUsername, WaitlistFlightNumber) values (?, ?)";
						PreparedStatement stmt2 = conn.prepareStatement(qry2);
						stmt2.setString(1, uname);
						stmt2.setInt(2, c.flightNumberL1);
						stmt2.executeUpdate();
						stmt2.close();
					}
					
					String qry3 = "insert into Waitlist (WaitlistUsername, WaitlistFlightNumber) values (?, ?)";
					PreparedStatement stmt3 = conn.prepareStatement(qry3);
					stmt3.setString(1, uname);
					stmt3.setInt(2, c.flightNumberA1);
					stmt3.executeUpdate();
					stmt3.close();
				}
				
				
				db.closeConnection(conn);
				response.sendRedirect("ticketHistory.jsp?waitlist=true");
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			
			
			
		}
		
		
	}

}
