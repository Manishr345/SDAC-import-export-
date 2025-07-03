<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="models.Product"%>
<%@ page import="models.User"%>
<%@ page session="true"%>
<html>
<head>
<title>Products</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
}

body {
	overflow-x: hidden;
}

body.sidebar-open .main-content {
	margin-left: 250px; /* equal to sidebar width */
	transition: margin-left 0.3s;
}

.navbar {
	display: flex;
	background-color: #333;
	color: white;
	padding: 10px 20px;
	align-items: center;
}

.navbar h1 {
	flex: 1;
	margin: 0;
}

.navbar a {
	color: white;
	text-decoration: none;
	padding: 8px 12px;
}

.navbar a:hover {
	background-color: #575757;
}

.menu-icon {
	font-size: 24px;
	cursor: pointer;
	margin-right: 20px;
}

.sidebar {
	height: 100%;
	width: 0;
	position: fixed;
	top: 0;
	left: 0;
	background-color: #222;
	overflow-x: hidden;
	transition: 0.3s;
	padding-top: 60px;
}

.sidebar a {
	padding: 10px 20px;
	text-decoration: none;
	color: white;
	display: block;
}

.sidebar a:hover {
	background-color: #575757;
}

.sidebar .closebtn {
	position: absolute;
	top: 15px;
	right: 20px;
	font-size: 30px;
	cursor: pointer;
	color: white;
}

.main-content {
	margin: 20px;
	padding-left: 20px;
}

.card-container {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	margin-top: 20px;
}

.card {
	border: 1px solid #ccc;
	border-radius: 10px;
	padding: 16px;
	width: 250px;
	box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.1);
	transition: 0.3s ease-in-out;
	position: relative;
}

.card:hover {
	box-shadow: 4px 4px 15px rgba(0, 0, 0, 0.2);
}

.card h3 {
	margin-top: 0;
}

.card p {
	margin: 8px 0;
}

.card form {
	margin-top: 10px;
}

.btn {
	padding: 6px 12px;
	margin-right: 6px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
}

.btn-update {
	background-color: #007bff;
	color: white;
}

.btn-delete {
	background-color: #dc3545;
	color: white;
}

.btn:hover {
	opacity: 0.9;
}
</style>
</head>
<body>

	<!-- Sidebar -->
	<div id="mySidebar" class="sidebar">
		<span class="closebtn" onclick="toggleSidebar()">×</span> <a href="#">Dashboard</a>
		<a href="#">Orders</a> <a href="#">Settings</a> <a href="#">Reports</a>
		<a href="#">Help</a>
	</div>

	<!-- Navbar -->
	<div class="navbar">
		<span class="menu-icon" onclick="toggleSidebar()">☰</span>
		<h1>SDAC</h1>
		<a href="#">Home</a> <a href="#">About</a> <a href="#">Contact</a> <a
			href="session_info.jsp">Profile</a>
	</div>

	<!-- Main Content -->
	<div class="main-content">
		<h2>
			Products for Seller ID:
			<%=request.getAttribute("sellerId")%></h2>

		<%
		String success = (String) request.getAttribute("success");
		String error = (String) request.getAttribute("error");
		if (success != null) {
		%>
		<p style="color: green;"><%=success%></p>
		<%
		} else if (error != null) {
		%>
		<p style="color: red;"><%=error%></p>
		<%
		}
		%>

		<div class="card-container">
			<%
			List<Product> products = (List<Product>) request.getAttribute("productList");

			if (products == null || products.isEmpty()) {
			%>
			<p>No products found!</p>
			<%
			} else if (products.size() == 1 && products.get(0).getProduct_id() == 0 && products.get(0).getQuantity() == 0
					&& products.get(0).getPrice() == 0.0) {
			%>
			<p><%=products.get(0).getProduct_name()%></p>
			<%
			} else {
			for (Product p : products) {
			%>
			<div class="card">
				<h3><%=p.getProduct_name()%></h3>
				<p>
					<strong>Product ID:</strong>
					<%=p.getProduct_id()%></p>
				<p>
					<strong>Quantity:</strong>
					<%=p.getQuantity()%></p>
				<p>
					<strong>Price:</strong> ₹<%=p.getPrice()%></p>

				<a href="update_product.jsp?product_id=<%=p.getProduct_id()%>">
					<button type="button" class="btn btn-update">Update</button>
				</a>

				<form action="ProductController" method="post"
					style="display: inline;">
					<input type="hidden" name="action" value="delete" /> <input
						type="hidden" name="product_id" value="<%=p.getProduct_id()%>" />
					<button type="submit" class="btn btn-delete"
						onclick="return confirm('Are you sure to delete this product?');">
						Delete</button>
				</form>
			</div>
			<%
			}
			}
			%>
		</div>
	</div>

	<script>
		function toggleSidebar() {
			const body = document.body;
			const sidebar = document.getElementById("mySidebar");

			if (sidebar.style.width === "250px") {
				sidebar.style.width = "0";
				body.classList.remove("sidebar-open");
			} else {
				sidebar.style.width = "250px";
				body.classList.add("sidebar-open");
			}
		}
	</script>


</body>
</html>
