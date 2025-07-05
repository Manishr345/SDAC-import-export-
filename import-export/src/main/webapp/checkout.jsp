<%@ page import="java.util.*, java.sql.*, models.Product, models.User" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 50px;
        }
        .container {
            max-width: 800px;
        }
    </style>
</head>
<body>
<%
    List<Product> cart = (List<Product>) session.getAttribute("cart");
    User user = (User) session.getAttribute("user");
    if (user == null || cart == null || cart.isEmpty()) {
        response.sendRedirect("cart.jsp");
        return;
    }
%>

<div class="container">
    <h2 class="mb-4 text-center">Confirm Your Order</h2>

    <form action="OrderController" method="post">
        <input type="hidden" name="action" value="placeOrder">

        <table class="table table-bordered table-hover">
            <thead class="table-dark text-center">
                <tr>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody class="text-center">
                <% 
                    double grandTotal = 0;
                    for (Product p : cart) {
                        double total = p.getPrice() * p.getQuantity();
                        grandTotal += total;
                %>
                <tr>
                    <td><%= p.getProduct_name() %></td>
                    <td><%= p.getQuantity() %></td>
                    <td><%= p.getPrice() %></td>
                    <td><%= total %></td>
                </tr>

                <!-- Hidden Fields to Send Order Details -->
                <input type="hidden" name="product_id" value="<%= p.getProduct_id() %>">
                <input type="hidden" name="quantity" value="<%= p.getQuantity() %>">
                <input type="hidden" name="seller_port_id" value="<%= p.getSeller_port_id() %>">
                <% } %>
                <tr class="table-success fw-bold">
                    <td colspan="3">Grand Total</td>
                    <td><%= grandTotal %></td>
                </tr>
            </tbody>
        </table>

        <input type="hidden" name="consumer_port_id" value="<%= user.getPortId() %>">

        <div class="text-end">
            <button type="submit" class="btn btn-success">Place Order</button>
            <a href="cart.jsp" class="btn btn-secondary">Back to Cart</a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
