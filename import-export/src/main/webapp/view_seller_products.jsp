<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="models.Product"%>
<%@ page import="models.User"%>
<%@ page session="true"%>
<!DOCTYPE html>
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
	<div class="container mt-4 content">
		<div class="mb-4 text-end">
			<a href="add_product.jsp" class="btn btn-success"> ➕ Add New
				Product </a>
		</div>

		<h2>
			Products for Seller ID:
			<%=request.getAttribute("sellerId")%></h2>

		<%
		String success = (String) request.getAttribute("success");
		String error = (String) request.getAttribute("error");
		if (success != null) {
		%>
		<div class="alert alert-success"><%=success%></div>
		<%
		} else if (error != null) {
		%>
		<div class="alert alert-danger"><%=error%></div>
		<%
		}
		%>

		<div class="row">
			<%
			List<Product> products = (List<Product>) request.getAttribute("productList");

			if (products == null || products.isEmpty()) {
			%>
			<div class="col-12">
				<p>No products found!</p>
			</div>
			<%
			} else if (products.size() == 1 && products.get(0).getProduct_id() == 0 && products.get(0).getQuantity() == 0
					&& products.get(0).getPrice() == 0.0) {
			%>
			<div class="col-12">
				<p><%=products.get(0).getProduct_name()%></p>
			</div>
			<%
			} else {
			for (Product p : products) {
			%>
			<div class="col-md-4 mb-4">
				<div class="card shadow-sm">
					<div class="card-body">
						<h5 class="card-title"><%=p.getProduct_name()%></h5>
						<p class="card-text">
							<strong>Product ID:</strong>
							<%=p.getProduct_id()%></p>
						<p class="card-text">
							<strong>Quantity:</strong>
							<%=p.getQuantity()%></p>
						<p class="card-text">
							<strong>Price:</strong> ₹<%=p.getPrice()%></p>

						<a href="update_product.jsp?product_id=<%=p.getProduct_id()%>"
							class="btn btn-primary btn-sm me-2">Update</a>

						<form action="ProductController" method="post" class="d-inline">
							<input type="hidden" name="action" value="delete" /> <input
								type="hidden" name="product_id" value="<%=p.getProduct_id()%>" />
							<button type="submit" class="btn btn-danger"
								onclick="return confirm('Are you sure you want to delete this product?');"
								title="Delete Product">
								<i class="bi bi-trash"></i>
							</button>

						</form>
					</div>
				</div>
			</div>
			<%
			}
			}
			%>
		</div>
	</div>

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
