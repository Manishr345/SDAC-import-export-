<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="models.User"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<title>Update Profile</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background: #f1f1f1;
}

.container {
	max-width: 500px;
	margin-top: 80px;
	background: #fff;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
}

body {
	background-color: #f8f9fa;
}

.form-container {
	max-width: 600px;
	margin: auto;
	background-color: #ffffff;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
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
	if (user == null) {
		response.sendRedirect("test_login.jsp");
		return;
	}
	%>

	<div class="container">
		<h3 class="mb-4 text-center">Update Profile</h3>

		<form action="Login" method="post">
			<input type="hidden" name="action" value="update"> <input
				type="hidden" name="port_id" value="<%=user.getPortId()%>">

			<div class="mb-3">
				<label for="location" class="form-label">Location</label> <input
					type="text" class="form-control" id="location" name="location"
					value="<%=user.getLocation()%>">
			</div>

			<div class="mb-3">
				<label for="password" class="form-label">New Password</label> <input
					type="password" class="form-control" id="password" name="password"
					value="<%=user.getPassword()%>" placeholder="Enter new password">
			</div>

			<div class="mb-3">
				<label for="role" class="form-label">Role</label> <select
					class="form-select" id="role" name="role">
					<option value="Consumer"
						<%="Consumer".equals(user.getRole()) ? "selected" : ""%>>Consumer</option>
					<option value="Seller"
						<%="Seller".equals(user.getRole()) ? "selected" : ""%>>Seller</option>
				</select>
			</div>

			<button type="submit" class="btn btn-primary w-100">Update
				Profile</button>
		</form>
	</div>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleSidebar() {
        document.body.classList.toggle("sidebar-open");
    }
</script>

</body>

</html>
