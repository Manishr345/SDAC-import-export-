<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>

<div class="container">
    <h2>Login</h2>

    <% 
        String error = (String) request.getAttribute("error");
        String success = (String) request.getAttribute("success");
    %>
	
    <% if (success != null) { %>
        <div class="success"><%= success %></div>
    <% } else if (error != null) { %>
        <div class="error"><%= error %></div>
    <% } %>

    <form action="/import-export/Login" method="post">
            <input type="hidden" name="action" value="login">
        <input type="text" name="port_id" placeholder="Port ID" required>
        <input type="password" name="password" placeholder="Password" required>
        <select name="role" required>
            <option value="">Select Role</option>
            <option>consumer</option>
            <option>seller</option>
        </select>
        <button type="submit">Login</button>
    </form>
</div>
</body>
</html>
