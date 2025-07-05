package controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.ReportedProducts;
import models.User;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.List;

import db_config.DbConnection;

/**
 * Servlet implementation class ReportedProductsController
 */
@WebServlet("/ReportedProductsController")
public class ReportedProductsController extends HttpServlet {
	
	@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ReportedProducts products = new ReportedProducts();
		try {
			HttpSession httpSession = req.getSession(false);
        	User user = (User) httpSession.getAttribute("user");
			List<ReportedProducts> list = products.showReport(user.getPortId());
			req.setAttribute("reportedList", list);
			RequestDispatcher rd = req.getRequestDispatcher("test_report.jsp");
			rd.forward(req, resp);
		} catch (Exception	 e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
        String action = req.getParameter("action");
		try {
			if ("addReport".equals(action)) {
	            try {
	                // Get parameters from request safely
	                String consumerId = req.getParameter("consumer_port_id");
	                String issueType = req.getParameter("issue_type");
	                String productIdStr = req.getParameter("product_id");
	                System.out.println(consumerId + issueType + productIdStr);

	                if (productIdStr == null || productIdStr.isEmpty() || consumerId == null || issueType == null) {
	                	req.setAttribute("error", "Missing required fields.");
	                    req.getRequestDispatcher("track_orders.jsp").forward(req, resp);
	                    return;
	                }

	                int productId = Integer.parseInt(productIdStr);

	                // Fetch seller_port_id from the product
	                Connection conn = DbConnection.getConnection();

	                String sellerQuery = "SELECT seller_port_id FROM products WHERE product_id = ?";
	                PreparedStatement ps = conn.prepareStatement(sellerQuery);
	                ps.setInt(1, productId);
	                ResultSet rs = ps.executeQuery();

	                String sellerId = null;
	                if (rs.next()) {
	                    sellerId = rs.getString("seller_port_id");
	                }
	                rs.close();
	                ps.close();

	                if (sellerId == null) {
	                	req.setAttribute("error", "Unable to find seller for the selected product.");
	                	req.getRequestDispatcher("track_orders.jsp").forward(req, resp);
	                    return;
	                }

	                // Call stored procedure to insert report
	                CallableStatement stmt = conn.prepareCall("{CALL add_report(?, ?, ?, ?, ?)}");
	                stmt.setString(1, consumerId);
	                stmt.setString(2, sellerId);
	                stmt.setInt(3, productId);
	                stmt.setString(4, issueType);
	                stmt.setDate(5, Date.valueOf(LocalDate.now()));
	                stmt.execute();

	                stmt.close();
	                conn.close();

	                req.setAttribute("success", "Product issue reported successfully.");
	            } catch (NumberFormatException e) {
	            	req.setAttribute("error", "Invalid product ID format.");
	            } catch (Exception e) {
	            	req.setAttribute("error", "Error: " + e.getMessage());
	                e.printStackTrace();
	            }

	            req.getRequestDispatcher("track_orders.jsp").forward(req, resp);
	        }
			else if("updateStatus".equals(action)) {
				int id = Integer.parseInt(req.getParameter("report_id"));
				ReportedProducts products = new ReportedProducts();
				products.updateStatus(id);
				resp.sendRedirect("ReportedProductsController");
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
