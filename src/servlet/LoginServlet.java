package servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import dao.UserDAO;
import model.User;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.loginUser(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            if ("admin".equals(user.getRole())) {
                response.sendRedirect("admin/manageProducts.jsp");
            } else {
                response.sendRedirect("products");
            }
        } else {
            response.sendRedirect("login.jsp?error=true");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login.jsp");
    }
}
