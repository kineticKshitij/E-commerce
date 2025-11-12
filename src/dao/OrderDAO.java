package dao;

import java.sql.*;
import java.util.*;
import model.Order;
import util.DBConnection;

public class OrderDAO {

    public boolean createOrder(Order order) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO orders (user_id, total) VALUES (?, ?)"
            );
            ps.setInt(1, order.getUserId());
            ps.setDouble(2, order.getTotal());
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Order> getOrdersByUserId(int userId) {
        List<Order> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM orders WHERE user_id = ? ORDER BY created_at DESC"
            );
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Order(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getDouble("total"),
                    rs.getTimestamp("created_at")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM orders ORDER BY created_at DESC"
            );
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Order(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getDouble("total"),
                    rs.getTimestamp("created_at")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
