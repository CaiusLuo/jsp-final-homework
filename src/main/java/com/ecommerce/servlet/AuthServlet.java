package com.ecommerce.servlet;

import com.ecommerce.dao.UserDAO;
import com.ecommerce.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("register".equals(action)) {
            handleRegister(req, resp);
        } else if ("login".equals(action)) {
            handleLogin(req, resp);
        } else if ("updateProfile".equals(action)) {
            handleUpdateProfile(req, resp);
        } else {
            resp.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("logout".equals(action)) {
            handleLogout(req, resp);
        } else if ("profile".equals(action)) {
            req.getRequestDispatcher("profile.jsp").forward(req, resp);
        }
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");

        if (userDAO.isUsernameExists(username)) {
            req.setAttribute("error", "Username already exists");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }

        User user = new User(username, password, email, phone, 0); // Default role 0 (User)
        if (userDAO.register(user)) {
            resp.sendRedirect("login.jsp?msg=Registration successful, please login");
        } else {
            req.setAttribute("error", "Registration failed");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = userDAO.login(username, password);
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            if (user.getRole() == 1) {
                resp.sendRedirect("admin/dashboard.jsp");
            } else {
                resp.sendRedirect("index.jsp");
            }
        } else {
            req.setAttribute("error", "Invalid username or password");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }

    private void handleLogout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        resp.sendRedirect("login.jsp");
    }

    private void handleUpdateProfile(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String password = req.getParameter("password");
            
            user.setEmail(email);
            user.setPhone(phone);
            if (password != null && !password.isEmpty()) {
                user.setPassword(password);
            }
            
            // In a real app, we should update DB here. 
            // userDAO.updateUser(user);
            // For simplicity, we just update session and assume DB update (need to add update method in DAO)
            userDAO.updateUser(user);
            
            session.setAttribute("user", user);
            resp.sendRedirect("profile.jsp?msg=Profile updated");
        } else {
            resp.sendRedirect("login.jsp");
        }
    }
}
