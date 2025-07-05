<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="models.Order"%>
<html>
<head>
<title>Products</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
	rel="stylesheet">
<style>
body {
	overflow-x: hidden;
}

.sidebar {
	height: 100vh;
	width: 250px;
	position: fixed;
	top: 0;
	left: -250px;
	background-color: #343a40;
	transition: all 0.3s;
	padding-top: 60px;
	z-index: 1000;
}

.sidebar a {
	padding: 15px;
	display: block;
	color: white;
	text-decoration: none;
}

.sidebar a:hover {
	background-color: #495057;
}

.sidebar-open .sidebar {
	left: 0;
}

.sidebar-open .content {
	margin-left: 250px;
}

.card {
	min-height: 250px;
}
</style>
</head>
<body>

	<!-- Sidebar -->
	<div class="sidebar bg-dark" id="mySidebar">
		<a href="javascript:void(0)" class="text-white"
			onclick="toggleSidebar()">✖ Close</a> <a href="ProductController?action=view">My Products</a> <a
			href="OrderController">Orders</a> <a href="ReportedProductsController">Reports</a> <a href="#">Sales</a>
	</div>

	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<span class="navbar-brand" onclick="toggleSidebar()"
				style="cursor: pointer;">☰</span> <a class="navbar-brand" href="#">SDAC</a>
			<div class="collapse navbar-collapse">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item"><a class="nav-link active"
						href="ProductController?action=view">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
					<li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
					<li class="nav-item"><a class="nav-link"
						href="test_session_info.jsp">Profile</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- Main Content -->
	<h3 class="mb-4">Seller Orders</h3>

	<%
	String msg = (String) request.getAttribute("message");
	if (msg != null) {
	%>
	<div class="alert alert-success"><%=msg%></div>
	<%
	}
	%>

	<table class="table table-bordered table-hover">
		<thead class="table-dark">
			<tr>
				<th>Order ID</th>
				<th>Product ID</th>
				<th>Product</th>
				<th>Price</th>
				<th>Consumer ID</th>
				<th>Quantity</th>
				<th>Date</th>
				<th>Shipped</th>
				<th>Out for Delivery</th>
				<th>Delivered</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
			<%
			List<Order> orders = (List<Order>) request.getAttribute("orderList");
			if (orders != null) {
				for (Order o : orders) {
			%>
			<form action="OrderController" method="post">
				<tr>
					<td><%=o.getOrderId()%></td>
					<td><%=o.getProductId()%></td>
					<td><%=o.getProductName()%></td>
					<td>₹<%=o.getPrice()%></td>
					<td><%=o.getConsumerPortId()%></td>
					<td><%=o.getQuantity()%></td>
					<td><%=o.getOrderDate()%></td>
					<td><input type="checkbox" name="shipped"
						<%=o.isShipped() ? "checked" : ""%> />
						<input type="hidden" name="action" value="changeStatus" /></td>
					<td><input type="checkbox" name="out_for_delivery"
						<%=o.isOutForDelivery() ? "checked" : ""%> /></td>
					<td><input type="checkbox" name="delivered"
						<%=o.isDelivered() ? "checked" : ""%> /></td>
					<td><input type="hidden" name="order_id"
						value="<%=o.getOrderId()%>" />
						<button type="submit" class="btn btn-primary btn-sm">Update</button>
					</td>
				</tr>
			</form>
			<%
			}
			}
			%>
		</tbody>
	</table>

	<!-- Bootstrap JS + Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

	<script>
		function toggleSidebar() {
			document.body.classList.toggle("sidebar-open");
		}
	</script>

</body>
</html>

