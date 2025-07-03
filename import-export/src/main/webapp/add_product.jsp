<!DOCTYPE html>
<html>
<head>
    <title>Add Product</title>
</head>
<body>
    <h2>Add New Product</h2>
    <form action="ProductController" method="POST">
        <input type="hidden" name="action" value="add"> <!-- Add this line -->

        <label for="seller_port_id">Seller ID:</label>
        <input type="text" id="seller_port_id" name="seller_port_id" required><br><br>

        <label for="product_name">Product Name:</label>
        <input type="text" id="product_name" name="product_name" maxlength="50" required><br><br>

        <label for="quantity">Quantity:</label>
        <input type="number" id="quantity" name="quantity" required><br><br>

        <label for="price">Price:</label>
        <input type="number" id="price" name="price" step="0.01" required><br><br>

        <input type="submit" value="Add Product">
    </form>
</body>
</html>
