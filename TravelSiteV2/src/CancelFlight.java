

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import fp.ConnectDB;

/**
 * Servlet implementation class CancelFlight
 */
@WebServlet("/CancelFlight")
public class CancelFlight extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CancelFlight() {
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
		
		int tix = Integer.parseInt(request.getParameter("tix"));

		try {
			ConnectDB db = new ConnectDB();
			Connection conn = db.getConnection();
			
			LocalDate now = LocalDate.now();
			java.sql.Date cD = java.sql.Date.valueOf(now.toString());
			String qry = "update Buys set CancelledDate=? where BuysTicketNumber=?";
			PreparedStatement stmt = conn.prepareStatement(qry);
			stmt.setDate(1, cD); 
			stmt.setInt(2, tix); 
			stmt.executeUpdate();
			stmt.close();
			db.closeConnection(conn);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		response.sendRedirect("ticketHistory.jsp?success=true");
	}

}
