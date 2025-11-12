<%@ page import="java.util.*, model.Product, model.User, dao.ProductDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("../login.jsp");
        return;
    }
    ProductDAO productDAO = new ProductDAO();
    List<Product> products = productDAO.getAllProducts();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Products - Admin Panel</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="../index.jsp">E-Commerce Admin</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="manageProducts.jsp">Manage Products</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="addProduct.jsp">Add Product</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../login?action=logout">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Manage Products</h2>
            <a href="addProduct.jsp" class="btn btn-primary">Add New Product</a>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (products != null && !products.isEmpty()) {
                        for (Product p : products) {
                %>
                    <tr>
                        <td><%=p.getId()%></td>
                        <td><img src="<%=p.getImage()%>" alt="<%=p.getName()%>" style="width: 50px; height: 50px; object-fit: cover;"></td>
                        <td><%=p.getName()%></td>
                        <td><%=p.getDescription()%></td>
                        <td>₹<%=p.getPrice()%></td>
                        <td>
                            <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editModal<%=p.getId()%>">Edit</button>
                            <form action="../ProductServlet" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="<%=p.getId()%>">
                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this product?')">Delete</button>
                            </form>
                        </td>
                    </tr>

                    <!-- Edit Modal -->
                    <div class="modal fade" id="editModal<%=p.getId()%>" tabindex="-1">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Edit Product</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <form action="../ProductServlet" method="post">
                                    <div class="modal-body">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="id" value="<%=p.getId()%>">
                                        <div class="mb-3">
                                            <label class="form-label">Product Name</label>
                                            <input type="text" class="form-control" name="name" value="<%=p.getName()%>" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Description</label>
                                            <textarea class="form-control" name="description" rows="3" required><%=p.getDescription()%></textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Price (₹)</label>
                                            <input type="number" step="0.01" class="form-control" name="price" value="<%=p.getPrice()%>" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Image URL</label>
                                            <input type="text" class="form-control" name="image" value="<%=p.getImage()%>" required>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                        <button type="submit" class="btn btn-primary">Update Product</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="6" class="text-center">No products available.</td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
