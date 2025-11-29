package com.ecommerce.controller;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.CartItem;
import com.ecommerce.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private ProductDAO productDAO;

    @GetMapping
    public String viewCart(HttpSession session, Model model) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart != null && !cart.isEmpty()) {
            BigDecimal total = BigDecimal.ZERO;
            for (CartItem item : cart) {
                total = total.add(item.getTotalPrice());
            }
            model.addAttribute("cartTotal", total);
        }
        return "cart";
    }

    @PostMapping
    public String handleCart(@RequestParam(required = false) String action,
                             @RequestParam(required = false) Integer productId,
                             @RequestParam(required = false) Integer quantity,
                             HttpSession session) {

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        if ("add".equals(action) && productId != null) {
            addToCart(cart, productId, quantity != null ? quantity : 1);
        } else if ("update".equals(action) && productId != null && quantity != null) {
            updateCart(cart, productId, quantity);
        } else if ("remove".equals(action) && productId != null) {
            removeFromCart(cart, productId);
        } else if ("clear".equals(action)) {
            cart.clear();
        }

        return "redirect:/cart";
    }

    private void addToCart(List<CartItem> cart, int productId, int quantity) {
        boolean exists = false;
        for (CartItem item : cart) {
            if (item.getProduct().getId() == productId) {
                item.setQuantity(item.getQuantity() + quantity);
                exists = true;
                break;
            }
        }

        if (!exists) {
            Product product = productDAO.getProductById(productId);
            if (product != null) {
                cart.add(new CartItem(product, quantity));
            }
        }
    }

    private void updateCart(List<CartItem> cart, int productId, int quantity) {
        for (CartItem item : cart) {
            if (item.getProduct().getId() == productId) {
                if (quantity > 0) {
                    item.setQuantity(quantity);
                }
                break;
            }
        }
    }

    private void removeFromCart(List<CartItem> cart, int productId) {
        Iterator<CartItem> iterator = cart.iterator();
        while (iterator.hasNext()) {
            CartItem item = iterator.next();
            if (item.getProduct().getId() == productId) {
                iterator.remove();
                break;
            }
        }
    }
}
