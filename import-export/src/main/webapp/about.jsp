<%@page import="models.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">

<head>
    <title>About Us - SDAC</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
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
			href="view_consumer_reports.jsp">Reports</a>
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
<div class="main-content p-4">
        <div class="container mt-5">
            <div class="row align-items-center mb-5">
                <div class="col-md-6 mb-4">
                    <img src="https://wallpapercave.com/wp/wp8859317.jpg" class="img-fluid hero-img" alt="About Image">
                </div>
                <div class="col-md-6">
                    <h3 class="mb-3">Who We Are</h3>
                    <p>
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptates, blanditiis quas molestiae
                        deleniti magnam facilis beatae enim deserunt. Fuga itaque suscipit porro veniam corporis
                        reprehenderit nihil in obcaecati repellat quidem.
                    </p>
                </div>
            </div>

            <div class="row align-items-center mb-5 flex-md-row-reverse">
                <div class="col-md-6 mb-4">
                    <img src="https://static0.givemesportimages.com/wordpress/wp-content/uploads/2024/05/epl_pl-date_tiime_fixtures.jpg"
                        class="img-fluid hero-img" alt="Vision">
                </div>
                <div class="col-md-6">
                    <h3 class="mb-3">Our Vision</h3>
                    <p>
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit. Illum obcaecati, atque asperiores
                        quisquam temporibus quas possimus deleniti dolorem sequi nihil hic libero! Quod ratione
                        molestiae, consequatur aliquid laboriosam corrupti culpa!
                    </p>
                </div>
            </div>

            <div class="row text-center mb-5">
                <div class="col">
                    <h4 class="mb-4">Watch Our Introduction</h4>
                    <div class="ratio ratio-16x9">
                        <iframe src="https://www.youtube.com/embed/IQuf2Mj3AsQ?si=E1WwbUmh1ROX78-o"
                            title="YouTube video player" allowfullscreen
                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture">
                        </iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>

<!-- Bootstrap JS + Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function toggleSidebar() {
        document.body.classList.toggle("sidebar-open");
    }
</script>

</body>

</html>
