<%@ page import="java.util.*, model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Products - E-Commerce</title>
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
                        <a class="nav-link active" href="products">Products</a>
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
                    <%
                        }
                    %>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h2 class="mb-4">Product List</h2>
        <div class="row">
        <%
            List<Product> products = (List<Product>) request.getAttribute("products");
            if (products != null && !products.isEmpty()) {
                for(Product p : products){
        %>
            <div class="col-md-3 mb-4">
                <div class="card h-100">
                    <img src="<%=p.getImage()%>" class="card-img-top" alt="<%=p.getName()%>" style="height: 200px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title"><%=p.getName()%></h5>
                        <p class="card-text"><%=p.getDescription()%></p>
                        <h6 class="text-primary">₹<%=p.getPrice()%></h6>
                        <form action="CartServlet" method="post">
                            <input type="hidden" name="productId" value="<%=p.getId()%>">
                            <input type="hidden" name="action" value="add">
                            <button type="submit" class="btn btn-primary w-100">Add to Cart</button>
                        </form>
                    </div>
                </div>
            </div>
        <%
                }
            } else {
        %>
            <div class="col-12">
                <div class="alert alert-info">No products available at the moment.</div>
            </div>
        <%
            }
        %>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
