package com.carshowroom.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.carshowroom.model.Order;
import com.carshowroom.model.OrderItem;
import com.carshowroom.model.OrderItemDetails;

@Repository
public class OrderDao {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public int createOrder(Order order) {
        String sql = "INSERT INTO orders (user_id, total_price, status) VALUES (?, ?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, new String[] {"order_id"});
            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getTotalPrice());
            ps.setString(3, order.getStatus());
            return ps;
        }, keyHolder);
        return keyHolder.getKey().intValue();
    }

    public void addOrderItem(OrderItem orderItem) {
        String sql = "INSERT INTO order_items (order_id, car_id, quantity, price) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, orderItem.getOrderId(), orderItem.getCarId(), orderItem.getQuantity(), orderItem.getPrice());
    }
    
    @SuppressWarnings("deprecation")
	public List<OrderItemDetails> getOrderItemsDetails(int userId) {
        String sql = "SELECT oi.order_item_id, oi.order_id, c.car_name AS car_name, oi.quantity, oi.price, o.status FROM order_items oi JOIN orders o ON oi.order_id = o.order_id JOIN cars c ON oi.car_id = c.car_id WHERE o.user_id = ?";
        return jdbcTemplate.query(sql, new Object[]{userId}, new RowMapper<OrderItemDetails>() {
            @Override
            public OrderItemDetails mapRow(ResultSet rs, int rowNum) throws SQLException {
                OrderItemDetails orderItemDetails = new OrderItemDetails();
                orderItemDetails.setOrderItemId(rs.getInt("order_item_id"));
                orderItemDetails.setOrderId(rs.getInt("order_id"));
                orderItemDetails.setCarName(rs.getString("car_name"));
                orderItemDetails.setQuantity(rs.getInt("quantity"));
                orderItemDetails.setPrice(rs.getInt("price"));
                orderItemDetails.setStatus(rs.getString("status"));
                return orderItemDetails;
            }
        });
    }

}
