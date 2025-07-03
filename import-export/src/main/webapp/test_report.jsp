<%@ page import="java.util.List" %>
<%@ page import="models.ReportedProducts" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reported Products</title>
    <style>
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #999;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .container {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Reported Products List</h2>

    <%
        List<ReportedProducts> list = (List<ReportedProducts>) request.getAttribute("reportedList");
        if (list == null || list.isEmpty()) {
    %>
        <p>No reports available.</p>
    <%
        } else {
    %>
        <table>
            <thead>
                <tr>
                    <th>Report ID</th>
                    <th>Consumer Port ID</th>
                    <th>Seller Port ID</th>
                    <th>Product ID</th>
                    <th>Issue Type</th>
                    <th>Status</th>
                    <th>Action Taken</th>
                    <th>Report Date</th>
                </tr>
            </thead>
            <tbody>
            <% for (ReportedProducts p : list) { %>
                <tr>
                    <td><%= p.getReport_id() %></td>
                    <td><%= p.getConsumer_port_id() %></td>
                    <td><%= p.getSeller_port_id() %></td>
                    <td><%= p.getProduct_id() %></td>
                    <td><%= p.getIssue_type() %></td>
                    <td><%= p.getStatus() %></td>
                    <td><%= p.getAction_taken() %></td>
                    <td><%= p.getReport_date() %></td>
                </tr>
            <% } %>
            </tbody>
        </table>
    <% } %>
</div>

</body>
</html>
