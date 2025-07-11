<%@ page import="java.util.List" %>
<%@ page import="models.ReportedProducts" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
	<div class="container">
    <h2 class="mb-4">Reported Products List</h2>

    <%
        List<ReportedProducts> list = (List<ReportedProducts>) request.getAttribute("reportedList");
        if (list == null || list.isEmpty()) {
    %>
        <div class="alert alert-warning text-center">No reports available.</div>
    <%
        } else {
    %>
    <table class="table table-bordered table-hover">
        <thead class="table-dark text-center">
            <tr>
                <th>Report ID</th>
                <th>Consumer Port ID</th>
                <th>Product ID</th>
                <th>Issue Type</th>
                <th>Status</th>
                <th>Action Taken</th>
                <th>Report Date</th>
                <th>Update</th>
            </tr>
        </thead>
        <tbody class="text-center">
        <% for (ReportedProducts p : list) { %>
            <tr>
                <td><%= p.getReport_id() %></td>
                <td><%= p.getConsumer_port_id() %></td>
                <td><%= p.getProduct_id() %></td>
                <td><%= p.getIssue_type() %></td>
                <td><%= p.getStatus() %></td>
                <td><%= p.getAction_taken() %></td>
                <td><%= p.getReport_date() %></td>
                <td>
                    <form action="ReportedProductsController" method="post" class="d-flex flex-column gap-1">
                        <input type="hidden" name="report_id" value="<%= p.getReport_id() %>">
                        <input type="hidden" name="action" value="updateStatus">
                        <button class="btn btn-primary btn-sm" type="submit">Update</button>
                    </form>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>
    <% } %>
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
