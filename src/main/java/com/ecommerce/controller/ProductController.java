package com.ecommerce.controller;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ProductController {

    @Autowired
    private ProductDAO productDAO;

    @GetMapping({"/", "/products"})
    public String listProducts(@RequestParam(required = false) String action,
                               @RequestParam(required = false) Integer categoryId,
                               @RequestParam(required = false) String keyword,
                               @RequestParam(required = false) Integer id,
                               Model model) {
        
        if ("detail".equals(action) && id != null) {
            Product product = productDAO.getProductById(id);
            model.addAttribute("product", product);
            return "product_detail";
        }

        List<Product> products;
        if ("category".equals(action) && categoryId != null) {
            products = productDAO.getProductsByCategory(categoryId);
        } else if ("search".equals(action) && keyword != null) {
            products = productDAO.searchProducts(keyword);
        } else {
            products = productDAO.getAllProducts();
        }

        model.addAttribute("products", products);
        model.addAttribute("categories", productDAO.getAllCategories());
        return "index";
    }
}
