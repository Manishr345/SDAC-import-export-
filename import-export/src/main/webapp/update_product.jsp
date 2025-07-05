<%@page import="models.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .form-container {
            max-width: 600px;
            margin: auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
        }
        body {
            overflow-x: hidden;
        }

        .sidebar {
            height: 100%;
            width: 250px;
            position: fixed;
            top: 0;
            left: -250px;
            background-color: #343a40;
            transition: 0.3s ease;
            padding-top: 60px;
            z-index: 1050;
        }

        .sidebar a {
            padding: 12px 20px;
            text-decoration: none;
            font-size: 16px;
            color: white;
            display: block;
        }

        .sidebar a:hover {
            background-color: #495057;
        }

        .sidebar-open .sidebar {
            left: 0;
        }

        .sidebar-open .main-content {
            margin-left: 250px;
        }

        .hero-img {
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .main-content {
            transition: margin-left 0.3s ease;
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<%
HttpSession httpSession = request.getSession(false);
User user = (User) httpSession.getAttribute("user");
if(user.getRole().equals("Consumer")) {
%>
<div class="sidebar bg-dark" id="mySidebar">
		<a href="javascript:void(0)" class="text-white"
			onclick="toggleSidebar()">✖ Close</a> <a
			href="ProductController?action=view">Products</a> <a
			href="track_orders.jsp">Orders</a> <a
			href="ReportedProductsController">Reports</a>
	</div>
<%
}else {
%>
	
<div class="sidebar bg-dark" id="mySidebar">
    <a href="javascript:void(0)" class="text-white" onclick="toggleSidebar()">✖ Close</a>
    <a href="ProductController?action=view">My Products</a> <a
			href="OrderController">Orders</a> <a href="ReportedProductsController">Reports</a> <a href="#">Sales</a>
</div>
<%} %>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand" onclick="toggleSidebar()" style="cursor:pointer;">☰</span>
        <a class="navbar-brand" href="#">SDAC</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="ProductController?action=view">Home</a></li>
                <li class="nav-item"><a class="nav-link active" href="about.jsp">About</a></li>
                <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                <li class="nav-item"><a class="nav-link" href="test_session_info.jsp">Profile</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->
<%
    String productId = request.getParameter("product_id");
    String name = request.getParameter("name");
    String price = request.getParameter("price");
    String quantity = request.getParameter("quantity");
    String error = (String) request.getAttribute("error");
%>

<div class="container">
    <div class="form-container mt-5">
        <h2 class="mb-4 text-center">✏️ Update Product</h2>

        <% if (error != null) { %>
            <div class="alert alert-danger text-center"><%= error %></div>
        <% } %>

        <form action="ProductController" method="POST">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="product_id" value="<%= productId != null ? productId : "" %>">

            <div class="mb-3">
                <label for="product_name" class="form-label">Product Name</label>
                <input type="text" id="product_name" name="product_name" class="form-control"
                       value="<%= name != null ? name : "" %>" required>
            </div>

            <div class="mb-3">
                <label for="quantity" class="form-label">Quantity</label>
                <input type="number" id="quantity" name="quantity" class="form-control"
                       value="<%= quantity != null ? quantity : "" %>" required min="1">
            </div>

            <div class="mb-3">
                <label for="price" class="form-label">Price (₹)</label>
                <input type="number" id="price" name="price" class="form-control"
                       value="<%= price != null ? price : "" %>" step="0.01" required>
            </div>

            <div class="text-end">
                <button type="submit" class="btn btn-primary">✅ Update Product</button>
                <a href="ProductController?action=view" class="btn btn-secondary">⬅ Back</a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleSidebar() {
        document.body.classList.toggle("sidebar-open");
    }
</script>

</body>
</html>
