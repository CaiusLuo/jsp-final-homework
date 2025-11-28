package com.ecommerce.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class Order {
    private int id;
    private int userId;
    private BigDecimal totalAmount;
    private int status; // 1: Pending, 2: Paid, 3: Shipped, 4: Completed, 5: Cancelled
    private String address;
    private String phone;
    private String receiver;
    private Timestamp createTime;
    
    // Helper
    private List<OrderItem> items;

    public Order() {}

    public Order(int userId, BigDecimal totalAmount, int status, String address, String phone, String receiver) {
        this.userId = userId;
        this.totalAmount = totalAmount;
        this.status = status;
        this.address = address;
        this.phone = phone;
        this.receiver = receiver;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getReceiver() { return receiver; }
    public void setReceiver(String receiver) { this.receiver = receiver; }
    public Timestamp getCreateTime() { return createTime; }
    public void setCreateTime(Timestamp createTime) { this.createTime = createTime; }
    public List<OrderItem> getItems() { return items; }
    public void setItems(List<OrderItem> items) { this.items = items; }
    
    public String getStatusText() {
        switch (status) {
            case 1: return "Pending";
            case 2: return "Paid";
            case 3: return "Shipped";
            case 4: return "Completed";
            case 5: return "Cancelled";
            default: return "Unknown";
        }
    }
}
