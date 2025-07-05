<%@ page import="java.util.List" %>
<%@ page import="models.Product" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Cart</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            padding: 40px;
        }
        .container {
            max-width: 800px;
        }
        h2 {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center"> Your Cart</h2>

    <%
        List<Product> cart = (List<Product>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
    %>
        <div class="alert alert-info text-center">Your cart is empty.</div>
    <%
        } else {
    %>
        <table class="table table-bordered table-hover">
            <thead class="table-dark text-center">
                <tr>
                    <th>Product Name</th>
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
            <% } %>
            <tr class="table-success fw-bold">
                <td colspan="3">Grand Total</td>
                <td><%= grandTotal %></td>
            </tr>
            </tbody>
        </table>
        <div class="text-end">
            <a href="checkout.jsp" class="btn btn-success">Proceed to Checkout</a>
        </div>
    <%
        }
    %>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
