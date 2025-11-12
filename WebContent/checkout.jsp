<%@ page import="model.Cart, model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout - E-Commerce</title>
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
                        User user = (User) session.getAttribute("user");
                        if (user != null) {
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
        <h2 class="mb-4">Checkout</h2>
        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            
            if ("true".equals(success)) {
        %>
            <div class="alert alert-success">
                <h4>Order Placed Successfully!</h4>
                <p>Thank you for your purchase. Your order has been confirmed.</p>
                <a href="products" class="btn btn-primary">Continue Shopping</a>
            </div>
        <%
            } else if ("true".equals(error)) {
        %>
            <div class="alert alert-danger">
                There was an error processing your order. Please try again.
            </div>
        <%
            } else {
                Cart cart = (Cart) session.getAttribute("cart");
                if (user == null) {
        %>
            <div class="alert alert-warning">
                Please <a href="login.jsp">login</a> to complete your purchase.
            </div>
        <%
                } else if (cart == null || cart.getItems().isEmpty()) {
        %>
            <div class="alert alert-info">
                Your cart is empty. <a href="products">Continue shopping</a>
            </div>
        <%
                } else {
        %>
            <div class="row">
                <div class="col-md-8">
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5>Order Summary</h5>
                        </div>
                        <div class="card-body">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Product</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Subtotal</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                    for (Cart.CartItem item : cart.getItems()) {
                                %>
                                    <tr>
                                        <td><%=item.getProduct().getName()%></td>
                                        <td>₹<%=item.getProduct().getPrice()%></td>
                                        <td><%=item.getQuantity()%></td>
                                        <td>₹<%=item.getProduct().getPrice() * item.getQuantity()%></td>
                                    </tr>
                                <%
                                    }
                                %>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="3" class="text-end"><strong>Total:</strong></td>
                                        <td><strong>₹<%=cart.getTotal()%></strong></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            <h5>Customer Information</h5>
                        </div>
                        <div class="card-body">
                            <p><strong>Name:</strong> <%=user.getName()%></p>
                            <p><strong>Email:</strong> <%=user.getEmail()%></p>
                            <hr>
                            <form action="checkout" method="post">
                                <button type="submit" class="btn btn-success w-100">Place Order</button>
                            </form>
                            <a href="cart.jsp" class="btn btn-secondary w-100 mt-2">Back to Cart</a>
                        </div>
                    </div>
                </div>
            </div>
        <%
                }
            }
        %>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
