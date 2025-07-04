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
import java.util.List;

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
		int id = Integer.parseInt(req.getParameter("report_id"));
		ReportedProducts products = new ReportedProducts();
		try {
			products.updateStatus(id);
			resp.sendRedirect("ReportedProductsController");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
