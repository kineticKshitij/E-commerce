package model;

import java.sql.Timestamp;

public class Order {
    private int id;
    private int userId;
    private double total;
    private Timestamp createdAt;

    public Order() {}

    public Order(int id, int userId, double total, Timestamp createdAt) {
        this.id = id;
        this.userId = userId;
        this.total = total;
        this.createdAt = createdAt;
    }

    // Getters
    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public double getTotal() {
        return total;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
