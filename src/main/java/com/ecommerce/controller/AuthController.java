package com.ecommerce.controller;

import com.ecommerce.dao.UserDAO;
import com.ecommerce.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class AuthController {

    @Autowired
    private UserDAO userDAO;

    @GetMapping("/login")
    public String showLogin() {
        return "login";
    }

    @GetMapping("/register")
    public String showRegister() {
        return "register";
    }

    @PostMapping("/auth")
    public String handleAuth(@RequestParam String action,
                             @RequestParam(required = false) String username,
                             @RequestParam(required = false) String password,
                             @RequestParam(required = false) String email,
                             @RequestParam(required = false) String phone,
                             HttpSession session,
                             Model model) {
        
        if ("login".equals(action)) {
            User user = userDAO.login(username, password);
            if (user != null) {
                session.setAttribute("user", user);
                return "redirect:/products";
            } else {
                model.addAttribute("msg", "Invalid username or password");
                return "login";
            }
        } else if ("register".equals(action)) {
            if (userDAO.isUsernameExists(username)) {
                model.addAttribute("msg", "Username already exists");
                return "register";
            }
            User user = new User();
            user.setUsername(username);
            user.setPassword(password);
            user.setEmail(email);
            user.setPhone(phone);
            user.setRole(0); // Default user
            
            if (userDAO.register(user)) {
                return "redirect:/login.jsp?msg=Registration successful";
            } else {
                model.addAttribute("msg", "Registration failed");
                return "register";
            }
        } else if ("updateProfile".equals(action)) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                user.setEmail(email);
                user.setPhone(phone);
                if (password != null && !password.isEmpty()) {
                    user.setPassword(password);
                }
                userDAO.updateUser(user);
                session.setAttribute("user", user);
                return "redirect:/profile?msg=Profile updated";
            }
            return "redirect:/login";
        }
        return "redirect:/";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/profile")
    public String profile(HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        return "profile";
    }
}
