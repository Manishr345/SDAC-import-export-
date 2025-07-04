<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="models.User"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Add Product</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
body {
	background-color: #f8f9fa;
}

.card {
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}
</style>
</head>
<body>

	<%
	User user = (User) session.getAttribute("user");
	if (user == null) {
	%>
	<div class="container mt-5">
		<div class="alert alert-danger">
			You must be logged in to add a product. <a href="login.jsp"
				class="alert-link">Login here</a>.
		</div>
	</div>
	<%
	} else {
	%>

	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-md-6">
				<div class="card p-4">
					<h4 class="mb-4 text-center">Add New Product</h4>
					<form action="ProductController" method="POST">
						<input type="hidden" name="action" value="add"> <input
							type="hidden" name="seller_port_id"
							value="<%=user.getPortId()%>">

						<div class="mb-3">
							<label for="product_name" class="form-label">Product Name</label>
							<input type="text" class="form-control" id="product_name"
								name="product_name" maxlength="50" required>
						</div>

						<div class="mb-3">
							<label for="quantity" class="form-label">Quantity</label> <input
								type="number" class="form-control" id="quantity" name="quantity"
								required>
						</div>

						<div class="mb-3">
							<label for="price" class="form-label">Price (₹)</label> <input
								type="number" class="form-control" id="price" name="price"
								step="0.01" required>
						</div>

						<div class="d-flex justify-content-between">
							<a href="ProductController?action=view" class="btn btn-secondary">Cancel</a>
							<button type="submit" class="btn btn-primary">Add
								Product</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<%
	}
	%>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
