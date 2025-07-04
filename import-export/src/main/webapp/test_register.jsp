<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="true" %>
<html>
<head>
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f9f9f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            width: 400px;
        }

        .container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin: 8px 0 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            width: 100%;
            padding: 10px;
            background: #4285f4;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background: #357ae8;
        }

        .success {
            color: green;
            text-align: center;
            margin-bottom: 10px;
        }

        .error {
            color: red;
            text-align: center;
            margin-bottom: 10px;
        }

        .actions a {
            display: block;
            text-align: center;
            margin-top: 10px;
            color: #555;
            text-decoration: none;
        }

        .actions a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Register</h2>

    <% String error = (String) request.getAttribute("error");
       String success = (String) request.getAttribute("success");
       models.User user = (models.User) session.getAttribute("user");
    %>

    <% if (success != null) { %>
        <div class="success"><%= success %></div>
    <% } else if (error != null) { %>
        <div class="error"><%= error %></div>
    <% } %>

    <div class="actions">
        <a href="test_login.jsp">Already have an account? Login</a>
    </div>

    <form action="/import-export/Registration" method="post">
        <input type="text" name="port_id" placeholder="Port ID" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="password" name="confirm_password" placeholder="Confirm Password" required>
                <input type="text" name="location" placeholder="Location" required>
        <select name="role" required>
            <option value="">Select Role</option>
            <option>Consumer</option>
            <option>Seller</option>
        </select>
        <button type="submit">Register</button>
    </form>
</div>
</body>
</html>
