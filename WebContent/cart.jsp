<%@ page import="model.Cart, model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shopping Cart - E-Commerce</title>
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
                        <a class="nav-link active" href="cart.jsp">Cart</a>
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
        <h2 class="mb-4">Shopping Cart</h2>
        <%
            Cart cart = (Cart) session.getAttribute("cart");
            String error = request.getParameter("error");
            if ("empty".equals(error)) {
        %>
            <div class="alert alert-warning">Your cart is empty!</div>
        <%
            }
            if (cart == null || cart.getItems().isEmpty()) {
        %>
            <div class="alert alert-info">Your cart is empty. <a href="products">Continue shopping</a></div>
        <%
            } else {
        %>
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Subtotal</th>
                            <th>Action</th>
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
                            <td>
                                <form action="CartServlet" method="post" style="display: inline;">
                                    <input type="hidden" name="productId" value="<%=item.getProduct().getId()%>">
                                    <input type="hidden" name="action" value="remove">
                                    <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                                </form>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="3" class="text-end"><strong>Total:</strong></td>
                            <td colspan="2"><strong>₹<%=cart.getTotal()%></strong></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
            <div class="d-flex justify-content-between">
                <a href="products" class="btn btn-secondary">Continue Shopping</a>
                <div>
                    <form action="CartServlet" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="clear">
                        <button type="submit" class="btn btn-warning">Clear Cart</button>
                    </form>
                    <a href="checkout" class="btn btn-success ms-2">Proceed to Checkout</a>
                </div>
            </div>
        <%
            }
        %>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
