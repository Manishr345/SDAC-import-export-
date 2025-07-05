<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="models.User"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>Session Info - SDAC</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet" />


<style>
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
			href="view_consumer_reports.jsp">Reports</a>
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
			<span class="navbar-brand" onclick="toggleSidebar()"
				style="cursor: pointer;">☰</span> <a class="navbar-brand" href="#">SDAC</a>
			<div class="collapse navbar-collapse">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item"><a class="nav-link"
						href="ProductController?action=view">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
					<li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="test_session_info.jsp">Profile</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- Main Content -->
	<div class="main-content p-4">
		<div class="container mt-4">
			<h2 class="mb-4">Session Information</h2>

			<%
			if (user != null) {
			%>
			<div class="card shadow-sm border-0 mb-3">
				<div class="card-body">
					<p>
						<strong>Port ID:</strong>
						<%=user.getPortId()%></p>
					<p>
						<strong>Location:</strong>
						<%=user.getLocation()%></p>
					<p>
						<strong>Role:</strong>
						<%=user.getRole()%></p>
					<a href="Logout" class="btn btn-danger">Logout</a> <a
						href="update_profile.jsp" class="btn btn-warning me-2">Update</a>

					<form action="Login" method="post" style="display: inline;">
						<input type="hidden" name="action" value="delete"> 
						<input type="hidden" name="port_id" value="<%=user.getPortId()%>">
						<input type="hidden" name="role" value="<%= user.getRole() %>">

						<button type="submit" class="btn btn-danger mt-2">Delete</button>
					</form>
				</div>
			</div>
			<%
			} else {
			%>
			<div class="alert alert-warning">No user is currently logged
				in.</div>
			<a href="login.jsp" class="btn btn-primary">Login Here</a>
			<%
			}
			%>
		</div>
	</div>

	<!-- JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		function toggleSidebar() {
			document.body.classList.toggle("sidebar-open");
		}
	</script>

</body>
</html>
