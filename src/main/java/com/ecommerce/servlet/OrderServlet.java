package com.ecommerce.servlet;

import com.ecommerce.dao.OrderDAO;
import com.ecommerce.model.CartItem;
import com.ecommerce.model.Order;
import com.ecommerce.model.OrderItem;
import com.ecommerce.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("checkout".equals(action)) {
            showCheckout(req, resp);
        } else if ("my".equals(action)) {
            listMyOrders(req, resp);
        } else if ("detail".equals(action)) {
            showOrderDetail(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("submit".equals(action)) {
            submitOrder(req, resp);
        }
    }

    private void showCheckout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp?msg=Please login to checkout");
            return;
        }
        
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect("cart?action=view");
            return;
        }

        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : cart) {
            total = total.add(item.getTotalPrice());
        }
        req.setAttribute("cartTotal", total);
        req.getRequestDispatcher("order_confirm.jsp").forward(req, resp);
    }

    private void submitOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect("cart?action=view");
            return;
        }

        String address = req.getParameter("address");
        String phone = req.getParameter("phone");
        String receiver = req.getParameter("receiver");
        BigDecimal total = new BigDecimal(req.getParameter("totalAmount"));

        Order order = new Order(user.getId(), total, 1, address, phone, receiver);
        int orderId = orderDAO.createOrder(order);

        if (orderId > 0) {
            for (CartItem item : cart) {
                OrderItem orderItem = new OrderItem(orderId, item.getProduct().getId(), item.getQuantity(), item.getProduct().getPrice());
                orderDAO.createOrderItem(orderItem);
            }
            session.removeAttribute("cart");
            resp.sendRedirect("order?action=my&msg=Order placed successfully");
        } else {
            req.setAttribute("error", "Failed to place order");
            req.getRequestDispatcher("order_confirm.jsp").forward(req, resp);
        }
    }

    private void listMyOrders(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        List<Order> orders = orderDAO.getOrdersByUserId(user.getId());
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("my_orders.jsp").forward(req, resp);
    }

    private void showOrderDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Order order = orderDAO.getOrderById(id);
        req.setAttribute("order", order);
        req.getRequestDispatcher("order_detail.jsp").forward(req, resp);
    }
}
