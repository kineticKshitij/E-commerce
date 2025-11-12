package servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import dao.ProductDAO;
import model.Cart;
import model.Product;

public class CartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String action = request.getParameter("action");
        
        if ("add".equals(action) || action == null) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);
            
            if (product != null) {
                cart.addItem(product, 1);
            }
            response.sendRedirect("cart.jsp");
        } else if ("remove".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            cart.removeItem(productId);
            response.sendRedirect("cart.jsp");
        } else if ("clear".equals(action)) {
            cart.clear();
            response.sendRedirect("cart.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("cart.jsp");
    }
}
