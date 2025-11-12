package servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import dao.ProductDAO;
import model.Product;

public class ProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO dao = new ProductDAO();
        List<Product> products = dao.getAllProducts();
        request.setAttribute("products", products);
        RequestDispatcher rd = request.getRequestDispatcher("products.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        ProductDAO dao = new ProductDAO();

        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String image = request.getParameter("image");

            Product product = new Product();
            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setImage(image);

            dao.addProduct(product);
            response.sendRedirect("admin/manageProducts.jsp");
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String image = request.getParameter("image");

            Product product = new Product(id, name, description, price, image);
            dao.updateProduct(product);
            response.sendRedirect("admin/manageProducts.jsp");
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteProduct(id);
            response.sendRedirect("admin/manageProducts.jsp");
        }
    }
}
