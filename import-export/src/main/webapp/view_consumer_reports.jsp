<%@ page import="db_config.DbConnection, java.sql.*, java.util.*, models.User" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Product Reports</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { background-color: #f0f2f5; padding: 30px; }
    </style>
</head>
<body>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("test_login.jsp");
        return;
    }

    List<Map<String, Object>> reports = new ArrayList<>();

    try (Connection conn = DbConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(
            "SELECT rp.*, p.product_name FROM reported_products rp JOIN products p ON rp.product_id = p.product_id WHERE rp.consumer_port_id = ?"
         )) {
        ps.setString(1, user.getPortId());
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, Object> r = new HashMap<>();
            r.put("report_id", rs.getInt("report_id"));
            r.put("product_name", rs.getString("product_name"));
            r.put("issue_type", rs.getString("issue_type"));
            r.put("status", rs.getString("status"));
            r.put("action_taken", rs.getString("action_taken"));
            r.put("report_date", rs.getDate("report_date"));
            reports.add(r);
        }

        rs.close();
    } catch (Exception e) {
        out.println("<div class='alert alert-danger'>Failed to fetch reports: " + e.getMessage() + "</div>");
    }
%>

<div class="container">
    <h2 class="text-center mb-4"> My Reported Products</h2>

    <% if (reports.isEmpty()) { %>
        <div class="alert alert-info text-center">You haven't reported any products yet.</div>
    <% } else { %>
        <table class="table table-bordered text-center">
            <thead class="table-dark">
                <tr>
                    <th>Report ID</th>
                    <th>Product</th>
                    <th>Issue</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Action Taken</th>
                </tr>
            </thead>
            <tbody>
            <% for (Map<String, Object> r : reports) { %>
                <tr>
                    <td><%= r.get("report_id") %></td>
                    <td><%= r.get("product_name") %></td>
                    <td><%= r.get("issue_type") %></td>
                    <td><%= r.get("report_date") %></td>
                    <td><%= r.get("status") %></td>
                    <td><%= r.get("action_taken") != null ? r.get("action_taken") : "Pending" %></td>
                </tr>
            <% } %>
            </tbody>
        </table>
    <% } %>
</div>
</body>
</html>
