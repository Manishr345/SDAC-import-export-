<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page import="models.User" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Session Info</title>
</head>
<body>

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

</body>
</html>

</body>
</html>