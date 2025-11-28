package com.ecommerce.servlet;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.Category;
import com.ecommerce.model.Product;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "detail":
                showDetail(req, resp);
                break;
            case "search":
                searchProducts(req, resp);
                break;
            case "category":
                listByCategory(req, resp);
                break;
            default:
                listProducts(req, resp);
                break;
        }
    }

    private void listProducts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> products = productDAO.getAllProducts();
        List<Category> categories = productDAO.getAllCategories();
        req.setAttribute("products", products);
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }

    private void listByCategory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int categoryId = Integer.parseInt(req.getParameter("id"));
        List<Product> products = productDAO.getProductsByCategory(categoryId);
        List<Category> categories = productDAO.getAllCategories();
        req.setAttribute("products", products);
        req.setAttribute("categories", categories);
        req.setAttribute("currentCategoryId", categoryId);
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }

    private void searchProducts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        List<Product> products = productDAO.searchProducts(keyword);
        List<Category> categories = productDAO.getAllCategories();
        req.setAttribute("products", products);
        req.setAttribute("categories", categories);
        req.setAttribute("searchKeyword", keyword);
        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }

    private void showDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Product product = productDAO.getProductById(id);
        if (product != null) {
            req.setAttribute("product", product);
            req.getRequestDispatcher("product_detail.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("products");
        }
    }
}
