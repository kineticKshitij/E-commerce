package servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import dao.OrderDAO;
import model.Cart;
import model.Order;
import model.User;

public class CheckoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("cart.jsp?error=empty");
            return;
        }

        Order order = new Order();
        order.setUserId(user.getId());
        order.setTotal(cart.getTotal());

        OrderDAO orderDAO = new OrderDAO();
        boolean result = orderDAO.createOrder(order);

        if (result) {
            cart.clear();
            response.sendRedirect("checkout.jsp?success=true");
        } else {
            response.sendRedirect("checkout.jsp?error=true");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("checkout.jsp");
        rd.forward(request, response);
    }
}
