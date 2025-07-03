<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Product</title>
</head>
<body>
    <h2>Update Product</h2>
    <%
    String productId = request.getParameter("product_id");
    String error = (String) request.getAttribute("error");
%>

<% if (error != null) { %>
    <p style="color: red;"><%= error %></p>
<% } %>
    
    <form action="ProductController" method="POST">
        <input type="hidden" name="action" value="update"> <!-- Important -->
        <input type="hidden" id="product_id" name="product_id" required 
           value="<%= productId != null ? productId : "" %>">

        <label for="product_name">Product Name:</label>
        <input type="text" id="product_name" name="product_name" required><br><br>

        <label for="quantity">Quantity:</label>
        <input type="number" id="quantity" name="quantity" required><br><br>

        <label for="price">Price (₹):</label>
        <input type="number" id="price" name="price" step="0.01" required><br><br>

        <input type="submit" value="Update Product">
    </form>
</body>
</html>
