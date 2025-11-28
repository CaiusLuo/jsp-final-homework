package com.ecommerce.controller;

import com.ecommerce.dao.OrderDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.dao.UserDAO;
import com.ecommerce.model.Order;
import com.ecommerce.model.Product;
import com.ecommerce.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private OrderDAO orderDAO;

    @Autowired
    private UserDAO userDAO;

    @GetMapping("/dashboard")
    public String dashboard() {
        return "admin/dashboard";
    }

    @GetMapping("/manage")
    public String manage(@RequestParam(required = false) String action,
                         @RequestParam(required = false) Integer id,
                         Model model) {
        
        if ("products".equals(action)) {
            List<Product> products = productDAO.getAllProducts();
            model.addAttribute("products", products);
            return "admin/products";
        } else if ("orders".equals(action)) {
            List<Order> orders = orderDAO.getAllOrders();
            model.addAttribute("orders", orders);
            return "admin/orders";
        } else if ("users".equals(action)) {
            List<User> users = userDAO.getAllUsers();
            model.addAttribute("users", users);
            return "admin/users";
        } else if ("deleteProduct".equals(action) && id != null) {
            productDAO.deleteProduct(id);
            return "redirect:/admin/manage?action=products";
        } else if ("editProduct".equals(action)) {
            if (id != null) {
                Product product = productDAO.getProductById(id);
                model.addAttribute("product", product);
            }
            model.addAttribute("categories", productDAO.getAllCategories());
            return "admin/product_form";
        }
        
        return "admin/dashboard";
    }

    @PostMapping("/product/save")
    public String saveProduct(@RequestParam(required = false) Integer id,
                              @RequestParam String name,
                              @RequestParam Integer categoryId,
                              @RequestParam BigDecimal price,
                              @RequestParam Integer stock,
                              @RequestParam String description,
                              @RequestParam(required = false) MultipartFile image,
                              HttpServletRequest request) throws IOException {
        
        Product p = new Product();
        if (id != null) {
            p.setId(id);
        }
        p.setName(name);
        p.setCategoryId(categoryId);
        p.setPrice(price);
        p.setStock(stock);
        p.setDescription(description);

        if (image != null && !image.isEmpty()) {
            String fileName = UUID.randomUUID().toString() + "_" + image.getOriginalFilename();
            String uploadDir = request.getServletContext().getRealPath("/assets/images");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();
            
            image.transferTo(new File(uploadDir + File.separator + fileName));
            p.setImage(fileName);
        }

        if (id == null) {
            productDAO.addProduct(p);
        } else {
            productDAO.updateProduct(p);
        }

        return "redirect:/admin/manage?action=products";
    }

    @PostMapping("/order/update")
    public String updateOrder(@RequestParam int id, @RequestParam int status) {
        orderDAO.updateOrderStatus(id, status);
        return "redirect:/admin/manage?action=orders";
    }
}
