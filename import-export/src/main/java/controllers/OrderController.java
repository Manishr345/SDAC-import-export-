package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.Order;
import models.User;
import db_config.DbConnection;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/OrderController")
public class OrderController extends HttpServlet {
    private final Order orderDAO = new Order();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect("test_login.jsp");
                return;
            }

            User user = (User) session.getAttribute("user");
            List<Order> orders = orderDAO.showOrders(user.getPortId());
            request.setAttribute("orderList", orders);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to fetch orders.");
        }

        request.getRequestDispatcher("view_seller_orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("placeOrder".equals(action)) {
                String consumerId = request.getParameter("consumer_port_id");
                String[] productIds = request.getParameterValues("product_id");
                String[] quantities = request.getParameterValues("quantity");
                String[] sellerIds = request.getParameterValues("seller_port_id");

                if (consumerId == null || productIds == null || quantities == null || sellerIds == null
                        || productIds.length != quantities.length || productIds.length != sellerIds.length) {
                    request.setAttribute("error", "Invalid cart data.");
                    request.getRequestDispatcher("cart.jsp").forward(request, response);
                    return;
                }

                try (Connection conn = DbConnection.getConnection()) {
                    LocalDate today = LocalDate.now();

                    for (int i = 0; i < productIds.length; i++) {
                    	System.out.println("Placing order for: Product=" + productIds[i] + 
                                ", Seller=" + sellerIds[i] + ", Consumer=" + consumerId);
                        try (CallableStatement stmt = conn.prepareCall("{CALL add_order(?, ?, ?, ?, ?)}")) {
                            stmt.setInt(1, Integer.parseInt(productIds[i]));
                            stmt.setString(2, consumerId);
                            stmt.setString(3, sellerIds[i]);
                            stmt.setInt(4, Integer.parseInt(quantities[i]));
                            stmt.setDate(5, java.sql.Date.valueOf(today));
                            stmt.execute();
                        }
                    }
                }

                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.removeAttribute("cart");
                }

                request.setAttribute("success", "Order placed successfully.");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                return;
            }

            else if ("changeStatus".equals(action)) {
                int orderId = Integer.parseInt(request.getParameter("order_id"));
                boolean shipped = request.getParameter("shipped") != null;
                boolean outForDelivery = request.getParameter("out_for_delivery") != null;
                boolean delivered = request.getParameter("delivered") != null;

                String status = orderDAO.updateStatus(orderId, shipped, outForDelivery, delivered);
                request.setAttribute("message", status);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to process order: " + e.getMessage());
        }

        // Reload seller's orders view
        doGet(request, response);
    }
}
