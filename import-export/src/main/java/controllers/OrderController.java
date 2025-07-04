package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Order;
import models.User;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class OrderController
 */
@WebServlet("/OrderController")
public class OrderController extends HttpServlet {
	Order orderDAO = new Order();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sellerId = request.getParameter("seller_port_id");
        try {
        	HttpSession httpSession = request.getSession(false);
        	User user = (User) httpSession.getAttribute("user");
            List<Order> orders = orderDAO.showOrders(user.getPortId());
            request.setAttribute("orderList", orders);
            request.getRequestDispatcher("view_seller_orders.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to fetch orders.");
            request.getRequestDispatcher("view_seller_orders.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("order_id"));
        Boolean shipped = request.getParameter("shipped") != null;
        Boolean outForDelivery = request.getParameter("out_for_delivery") != null;
        Boolean delivered = request.getParameter("delivered") != null;

        try {
            String status = orderDAO.updateStatus(orderId, shipped, outForDelivery, delivered);
            request.setAttribute("message", status);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to update order status.");
        }

        // Redirect or refresh list
        doGet(request, response);
    }

}
