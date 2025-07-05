<%@page import="db_config.DbConnection"%>
<%@ page import="java.sql.*, java.util.*, models.User" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Track My Orders</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            padding: 30px;
            background-color: #f0f2f5;
        }
        .table td, .table th {
            vertical-align: middle;
        }
    </style>
</head>
<body>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("test_login.jsp");
        return;
    }

    String consumerId = user.getPortId();
    List<Map<String, Object>> orderList = new ArrayList<>();

    try {
        Connection conn = DbConnection.getConnection();

        CallableStatement stmt = conn.prepareCall("{CALL view_consumer_orders(?)}");
        stmt.setString(1, consumerId);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            Map<String, Object> order = new HashMap<>();
            order.put("order_id", rs.getInt("order_id"));
            order.put("product_id", rs.getInt("product_id")); // ✅ added
            order.put("product_name", rs.getString("product_name"));
            order.put("quantity", rs.getInt("quantity"));
            order.put("price", rs.getDouble("price"));
            order.put("order_date", rs.getDate("order_date"));
            order.put("shipped", rs.getBoolean("shipped"));
            order.put("out_for_delivery", rs.getBoolean("out_for_delivery"));
            order.put("delivered", rs.getBoolean("delivered"));
            orderList.add(order);
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("<div class='alert alert-danger'>Error fetching orders: " + e.getMessage() + "</div>");
    }
%>

<div class="container">
    <h2 class="text-center mb-4"> My Orders</h2>

    <% if (orderList.isEmpty()) { %>
        <div class="alert alert-info text-center">No orders found.</div>
    <% } else { %>
        <table class="table table-bordered table-hover text-center">
            <thead class="table-dark">
                <tr>
                    <th>Order ID</th>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Report</th>
                </tr>
            </thead>
            <tbody>
                <% for (Map<String, Object> order : orderList) {
                    boolean shipped = (boolean) order.get("shipped");
                    boolean outForDelivery = (boolean) order.get("out_for_delivery");
                    boolean delivered = (boolean) order.get("delivered");
                    String status = delivered ? "Delivered" :
                                    outForDelivery ? "Out for Delivery" :
                                    shipped ? "Shipped" : "Order Placed";
                %>
                    <tr>
                        <td><%= order.get("order_id") %></td>
                        <td><%= order.get("product_name") %></td>
                        <td><%= order.get("quantity") %></td>
                        <td><%= order.get("price") %></td>
                        <td><%= order.get("order_date") %></td>
                        <td><%= status %></td>
                        <td>
                            <% if (!delivered) { %>
                                <span class="text-muted">Report after delivery</span>
                            <% } else { %>
                                <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#reportModal<%= order.get("order_id") %>">Report</button>
                            <% } %>
                        </td>
                    </tr>

                    <!-- ✅ Modal placed OUTSIDE the row -->
                    <div class="modal fade" id="reportModal<%= order.get("order_id") %>" tabindex="-1" aria-labelledby="reportLabel<%= order.get("order_id") %>" aria-hidden="true">
                      <div class="modal-dialog">
                        <form action="ReportedProductsController" method="post">
                          <div class="modal-content">
                            <div class="modal-header bg-danger text-white">
                              <h5 class="modal-title" id="reportLabel<%= order.get("order_id") %>">Report Issue - Order ID <%= order.get("order_id") %></h5>
                              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>

                            <div class="modal-body">
                              <input type="hidden" name="action" value="addReport">
                              <input type="hidden" name="product_id" value="<%= order.get("product_id") %>">
                              <input type="hidden" name="consumer_port_id" value="<%= consumerId %>">
                              <input type="hidden" name="order_id" value="<%= order.get("order_id") %>">

                              <label class="form-label">Select Issue Type:</label>
                              <select name="issue_type" class="form-select" required>
                                  <option value="">-- Select Issue --</option>
                                  <option value="Damage">Damage</option>
                                  <option value="Wrong Product">Wrong Product</option>
                                  <option value="Delayed">Delayed</option>
                                  <option value="Still Not Received">Still Not Received</option>
                                  <option value="Missing">Missing</option>
                              </select>
                            </div>

                            <div class="modal-footer">
                              <button type="submit" class="btn btn-danger">Submit Report</button>
                            </div>
                          </div>
                        </form>
                      </div>
                    </div>
                <% } %>
            </tbody>
        </table>
    <% } %>
</div>

<!-- ✅ Bootstrap JS for modal -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
