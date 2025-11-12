<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>E-Commerce - Home</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">E-Commerce</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="products">Products</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="cart.jsp">Cart</a>
                    </li>
                    <%
                        if (session.getAttribute("user") != null) {
                    %>
                        <li class="nav-item">
                            <a class="nav-link" href="login?action=logout">Logout</a>
                        </li>
                    <%
                        } else {
                    %>
                        <li class="nav-item">
                            <a class="nav-link" href="login.jsp">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="register.jsp">Register</a>
                        </li>
                    <%
                        }
                    %>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="jumbotron text-center">
            <h1 class="display-4">Welcome to E-Commerce Store</h1>
            <p class="lead">Find the best products at the best prices!</p>
            <hr class="my-4">
            <p>Browse our extensive catalog of products</p>
            <a class="btn btn-primary btn-lg" href="products" role="button">Shop Now</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
