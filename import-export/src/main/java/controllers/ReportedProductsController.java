package controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.ReportedProducts;

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
			List<ReportedProducts> list = products.showReport("yash");
			req.setAttribute("reportedList", list);
			RequestDispatcher rd = req.getRequestDispatcher("test_report.jsp");
			rd.forward(req, resp);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}

}
