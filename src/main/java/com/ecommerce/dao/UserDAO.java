package com.ecommerce.dao;

import com.ecommerce.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class UserDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private RowMapper<User> userRowMapper = new RowMapper<User>() {
        @Override
        public User mapRow(ResultSet rs, int rowNum) throws SQLException {
            User user = new User();
            user.setId(rs.getInt("id"));
            user.setUsername(rs.getString("username"));
            user.setPassword(rs.getString("password"));
            user.setEmail(rs.getString("email"));
            user.setPhone(rs.getString("phone"));
            user.setRole(rs.getInt("role"));
            user.setCreateTime(rs.getTimestamp("create_time"));
            return user;
        }
    };

    public boolean register(User user) {
        String sql = "INSERT INTO users (username, password, email, phone, role) VALUES (?, ?, ?, ?, ?)";
        int rows = jdbcTemplate.update(sql, user.getUsername(), user.getPassword(), user.getEmail(), user.getPhone(), user.getRole());
        return rows > 0;
    }

    public User login(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try {
            return jdbcTemplate.queryForObject(sql, userRowMapper, username, password);
        } catch (Exception e) {
            return null;
        }
    }

    public boolean isUsernameExists(String username) {
        String sql = "SELECT count(*) FROM users WHERE username = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, username);
        return count != null && count > 0;
    }

    public void updateUser(User user) {
        String sql = "UPDATE users SET email=?, phone=?, password=? WHERE id=?";
        jdbcTemplate.update(sql, user.getEmail(), user.getPhone(), user.getPassword(), user.getId());
    }
    
    public List<User> getAllUsers() {
        String sql = "SELECT * FROM users";
        return jdbcTemplate.query(sql, userRowMapper);
    }
}    

