<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.User" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Session Info with Sidebar</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
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
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div id="mySidebar" class="sidebar">
    <span class="closebtn" onclick="toggleSidebar()">×</span>
    <a href="#">Dashboard</a>
    <a href="#">Orders</a>
    <a href="#">Settings</a>
    <a href="#">Reports</a>
    <a href="#">Help</a>
</div>

<!-- Navbar -->
<div class="navbar">
    <span class="menu-icon" onclick="toggleSidebar()">☰</span>
    <h1>SDAC</h1>
    <a href="#">Home</a>
    <a href="#">About</a>
    <a href="#">Contact</a>
    <a href="session_info.jsp">Profile</a>
</div>

<!-- Main Content -->
<div class="main-content">
    <h2>Session Information</h2>
    <%
        User user = (User) session.getAttribute("user");
        if (user != null) {
    %>
        <p><strong>Port ID:</strong> <%= user.getPortId() %></p>
        <p><strong>Location:</strong> <%= user.getLocation() %></p>
        <p><strong>Role:</strong> <%= user.getRole() %></p>
        <p><a href="logout.jsp">Logout</a></p>
    <%
        } else {
    %>
        <p style="color:red;">No user is currently logged in.</p>
        <p><a href="login.jsp">Login Here</a></p>
    <%
        }
    %>
</div>

<script>
    function toggleSidebar() {
        const sidebar = document.getElementById("mySidebar");
        sidebar.style.width = (sidebar.style.width === "250px") ? "0" : "250px";
    }
</script>

</body>
</html>
