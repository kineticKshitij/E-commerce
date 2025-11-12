package servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import dao.UserDAO;
import model.User;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        
        if (role == null || role.isEmpty()) {
            role = "customer";
        }

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        UserDAO userDAO = new UserDAO();
        boolean result = userDAO.registerUser(user);

        if (result) {
            response.sendRedirect("login.jsp?success=true");
        } else {
            response.sendRedirect("register.jsp?error=true");
        }
    }
}
