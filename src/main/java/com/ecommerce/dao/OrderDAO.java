package com.ecommerce.dao;

import com.ecommerce.model.Order;
import com.ecommerce.model.OrderItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

@Repository
public class OrderDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<Order> orderRowMapper = new RowMapper<Order>() {
        @Override
        public Order mapRow(ResultSet rs, int rowNum) throws SQLException {
            Order o = new Order();
            o.setId(rs.getInt("id"));
            o.setUserId(rs.getInt("user_id"));
            o.setTotalAmount(rs.getBigDecimal("total_amount"));
            o.setStatus(rs.getInt("status"));
            o.setAddress(rs.getString("address"));
            o.setPhone(rs.getString("phone"));
            o.setReceiver(rs.getString("receiver"));
            o.setCreateTime(rs.getTimestamp("create_time"));
            return o;
        }
    };

    public int createOrder(Order order) {
        String sql = "INSERT INTO orders (user_id, total_amount, status, address, phone, receiver) VALUES (?, ?, ?, ?, ?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getUserId());
            ps.setBigDecimal(2, order.getTotalAmount());
            ps.setInt(3, order.getStatus());
            ps.setString(4, order.getAddress());
            ps.setString(5, order.getPhone());
            ps.setString(6, order.getReceiver());
            return ps;
        }, keyHolder);

        return keyHolder.getKey().intValue();
    }

    public void createOrderItem(OrderItem item) {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, item.getOrderId(), item.getProductId(), item.getQuantity(), item.getPrice());
    }

    public List<Order> getOrdersByUserId(int userId) {
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY create_time DESC";
        return jdbcTemplate.query(sql, orderRowMapper, userId);
    }

    public List<Order> getAllOrders() {
        String sql = "SELECT * FROM orders ORDER BY create_time DESC";
        return jdbcTemplate.query(sql, orderRowMapper);
    }

    public Order getOrderById(int id) {
        String sql = "SELECT * FROM orders WHERE id = ?";
        try {
            Order order = jdbcTemplate.queryForObject(sql, orderRowMapper, id);
            if (order != null) {
                order.setItems(getOrderItems(id));
            }
            return order;
        } catch (Exception e) {
            return null;
        }
    }

    public void updateOrderStatus(int id, int status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        jdbcTemplate.update(sql, status, id);
    }

    private List<OrderItem> getOrderItems(int orderId) {
        String sql = "SELECT oi.*, p.name, p.image FROM order_items oi JOIN products p ON oi.product_id = p.id WHERE oi.order_id = ?";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            OrderItem item = new OrderItem();
            item.setId(rs.getInt("id"));
            item.setOrderId(rs.getInt("order_id"));
            item.setProductId(rs.getInt("product_id"));
            item.setQuantity(rs.getInt("quantity"));
            item.setPrice(rs.getBigDecimal("price"));
            item.setProductName(rs.getString("name"));
            item.setProductImage(rs.getString("image"));
            return item;
        }, orderId);
    }
}
