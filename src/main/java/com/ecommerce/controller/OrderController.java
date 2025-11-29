package com.ecommerce.controller;

import com.ecommerce.dao.OrderDAO;
import com.ecommerce.model.CartItem;
import com.ecommerce.model.Order;
import com.ecommerce.model.OrderItem;
import com.ecommerce.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderDAO orderDAO;

    @GetMapping
    public String handleOrder(@RequestParam(required = false) String action,
                              @RequestParam(required = false) Integer id,
                              HttpSession session,
                              Model model) {
        
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        if ("checkout".equals(action)) {
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart != null && !cart.isEmpty()) {
                BigDecimal total = BigDecimal.ZERO;
                for (CartItem item : cart) {
                    total = total.add(item.getTotalPrice());
                }
                model.addAttribute("cartTotal", total);
            }
            return "order_confirm";
        } else if ("myOrders".equals(action)) {
            List<Order> orders = orderDAO.getOrdersByUserId(user.getId());
            model.addAttribute("orders", orders);
            return "my_orders";
        } else if ("detail".equals(action) && id != null) {
            Order order = orderDAO.getOrderById(id);
            if (order != null && order.getUserId() == user.getId()) {
                model.addAttribute("order", order);
                return "order_detail";
            }
        }
        return "redirect:/products";
    }

    @PostMapping
    public String submitOrder(@RequestParam String action,
                              @RequestParam String address,
                              @RequestParam String phone,
                              @RequestParam String receiver,
                              HttpSession session) {
        
        if ("submit".equals(action)) {
            User user = (User) session.getAttribute("user");
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

            if (user != null && cart != null && !cart.isEmpty()) {
                Order order = new Order();
                order.setUserId(user.getId());
                order.setAddress(address);
                order.setPhone(phone);
                order.setReceiver(receiver);
                order.setStatus(1); // Pending

                BigDecimal total = BigDecimal.ZERO;
                for (CartItem item : cart) {
                    total = total.add(item.getTotalPrice());
                }
                order.setTotalAmount(total);

                int orderId = orderDAO.createOrder(order);
                if (orderId > 0) {
                    for (CartItem item : cart) {
                        OrderItem orderItem = new OrderItem();
                        orderItem.setOrderId(orderId);
                        orderItem.setProductId(item.getProduct().getId());
                        orderItem.setQuantity(item.getQuantity());
                        orderItem.setPrice(item.getProduct().getPrice());
                        orderDAO.createOrderItem(orderItem);
                    }
                    cart.clear(); // Clear cart
                    return "redirect:/order?action=myOrders";
                }
            }
        }
        return "redirect:/cart";
    }
}
