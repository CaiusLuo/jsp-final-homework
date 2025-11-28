package com.ecommerce.dao;

import com.ecommerce.model.Category;
import com.ecommerce.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ProductDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<Product> productRowMapper = new RowMapper<Product>() {
        @Override
        public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
            Product p = new Product();
            p.setId(rs.getInt("id"));
            p.setCategoryId(rs.getInt("category_id"));
            p.setName(rs.getString("name"));
            p.setDescription(rs.getString("description"));
            p.setPrice(rs.getBigDecimal("price"));
            p.setStock(rs.getInt("stock"));
            p.setImage(rs.getString("image"));
            p.setCreateTime(rs.getTimestamp("create_time"));
            try {
                p.setCategoryName(rs.getString("category_name"));
            } catch (SQLException e) {
                // Column might not exist in some queries
            }
            return p;
        }
    };

    public List<Product> getAllProducts() {
        String sql = "SELECT p.*, c.name as category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id ORDER BY p.create_time DESC";
        return jdbcTemplate.query(sql, productRowMapper);
    }

    public List<Product> getProductsByCategory(int categoryId) {
        String sql = "SELECT p.*, c.name as category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id WHERE p.category_id = ?";
        return jdbcTemplate.query(sql, productRowMapper, categoryId);
    }

    public List<Product> searchProducts(String keyword) {
        String sql = "SELECT p.*, c.name as category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id WHERE p.name LIKE ? OR p.description LIKE ?";
        String like = "%" + keyword + "%";
        return jdbcTemplate.query(sql, productRowMapper, like, like);
    }

    public Product getProductById(int id) {
        String sql = "SELECT p.*, c.name as category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id WHERE p.id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, productRowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }

    public List<Category> getAllCategories() {
        String sql = "SELECT * FROM categories";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Category c = new Category();
            c.setId(rs.getInt("id"));
            c.setName(rs.getString("name"));
            c.setDescription(rs.getString("description"));
            return c;
        });
    }

    public void deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    public void addProduct(Product p) {
        String sql = "INSERT INTO products (name, category_id, price, stock, description, image) VALUES (?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, p.getName(), p.getCategoryId(), p.getPrice(), p.getStock(), p.getDescription(), p.getImage());
    }

    public void updateProduct(Product p) {
        if (p.getImage() != null) {
            String sql = "UPDATE products SET name=?, category_id=?, price=?, stock=?, description=?, image=? WHERE id=?";
            jdbcTemplate.update(sql, p.getName(), p.getCategoryId(), p.getPrice(), p.getStock(), p.getDescription(), p.getImage(), p.getId());
        } else {
            String sql = "UPDATE products SET name=?, category_id=?, price=?, stock=?, description=? WHERE id=?";
            jdbcTemplate.update(sql, p.getName(), p.getCategoryId(), p.getPrice(), p.getStock(), p.getDescription(), p.getId());
        }
    }
}
