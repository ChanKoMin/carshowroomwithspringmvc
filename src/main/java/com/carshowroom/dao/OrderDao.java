package com.carshowroom.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.carshowroom.model.AdminOrderDetails;
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
			PreparedStatement ps = connection.prepareStatement(sql, new String[] { "order_id" });
			ps.setInt(1, order.getUserId());
			ps.setInt(2, order.getTotalPrice());
			ps.setString(3, order.getStatus());
			return ps;
		}, keyHolder);
		return keyHolder.getKey().intValue();
	}

	public void addOrderItem(OrderItem orderItem) {
		String sql = "INSERT INTO order_items (order_id, car_id, quantity, price) VALUES (?, ?, ?, ?)";
		jdbcTemplate.update(sql, orderItem.getOrderId(), orderItem.getCarId(), orderItem.getQuantity(),
				orderItem.getPrice());
	}

//    @SuppressWarnings("deprecation")
//	public List<OrderItemDetails> getOrderItemsDetails(int userId) {
//        String sql = "SELECT oi.order_item_id, oi.order_id, c.car_name AS car_name, oi.quantity, oi.price, o.status FROM order_items oi JOIN orders o ON oi.order_id = o.order_id JOIN cars c ON oi.car_id = c.car_id WHERE o.user_id = ?";
//        return jdbcTemplate.query(sql, new Object[]{userId}, new RowMapper<OrderItemDetails>() {
//            @Override
//            public OrderItemDetails mapRow(ResultSet rs, int rowNum) throws SQLException {
//                OrderItemDetails orderItemDetails = new OrderItemDetails();
//                orderItemDetails.setOrderItemId(rs.getInt("order_item_id"));
//                orderItemDetails.setOrderId(rs.getInt("order_id"));
//                orderItemDetails.setCarName(rs.getString("car_name"));
//                orderItemDetails.setQuantity(rs.getInt("quantity"));
//                orderItemDetails.setPrice(rs.getInt("price"));
//                orderItemDetails.setStatus(rs.getString("status"));
//                return orderItemDetails;
//            }
//        });
//    }

	public List<AdminOrderDetails> getOrderDetails(int page, int pageSize) {
		int offset = (page - 1) * pageSize;
		String sql = "SELECT o.order_id, u.email AS user_email, c.car_name, c.car_image, oi.quantity, oi.price * oi.quantity AS total_price_per_item, o.total_price AS total_order_price, o.status FROM orders o JOIN order_items oi ON o.order_id = oi.order_id JOIN cars c ON oi.car_id = c.car_id JOIN users u ON o.user_id = u.id ORDER BY order_id DESC LIMIT ? OFFSET ?";
		return jdbcTemplate.query(sql, (rs, rowNum) -> {
			AdminOrderDetails orderDetails = new AdminOrderDetails();
			orderDetails.setOrderId(rs.getInt("order_id"));
			orderDetails.setUserEmail(rs.getString("user_email"));
			orderDetails.setCarName(rs.getString("car_name"));
			orderDetails.setCarImage(rs.getString("car_image"));
			orderDetails.setQuantity(rs.getInt("quantity"));
			orderDetails.setTotalPricePerItem(rs.getDouble("total_price_per_item"));
			orderDetails.setTotalOrderPrice(rs.getDouble("total_order_price"));
			orderDetails.setStatus(rs.getString("status"));
			return orderDetails;
		}, pageSize, offset);
	}

	public void updateOrderStatus(int orderId, String status) {
		String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
		jdbcTemplate.update(sql, status, orderId);
	}

	@SuppressWarnings("deprecation")
	public AdminOrderDetails getOrderDetailsById(int orderId) {
		String sql = "SELECT o.order_id, o.user_id, oi.car_id, u.email AS user_email, c.car_name, c.car_image, oi.quantity,oi.price, (oi.price * oi.quantity) AS total_price_per_item, o.total_price FROM orders o JOIN order_items oi ON o.order_id = oi.order_id JOIN cars c ON oi.car_id = c.car_id JOIN users u ON o.user_id = u.id WHERE o.order_id = ?";
		//String sql = "SELECT o.order_id, o.user_id,oi.car_id,u.email AS user_email,c.car_name, c.car_image,oi.quantity, (oi.price * oi.quantity) AS total_price_per_item, o.total_price FROM orders o JOIN order_items oi ON o.order_id = oi.order_id JOIN cars c ON oi.car_id = c.car_id JOIN users u ON o.user_id = u.id WHERE o.order_id = ?";

		return jdbcTemplate.queryForObject(sql, new Object[] { orderId }, (rs, rowNum) -> {
			AdminOrderDetails orderDetails = new AdminOrderDetails();
			orderDetails.setOrderId(rs.getInt("order_id"));
			orderDetails.setUserId(rs.getInt("user_id"));
			orderDetails.setCarId(rs.getInt("car_id"));
			orderDetails.setUserEmail(rs.getString("user_email"));
			orderDetails.setCarName(rs.getString("car_name"));
			orderDetails.setCarImage(rs.getString("car_image"));
			orderDetails.setQuantity(rs.getInt("quantity"));
			orderDetails.setPrice(rs.getDouble("price"));
			orderDetails.setTotalPricePerItem(rs.getDouble("total_price_per_item"));
			orderDetails.setTotalOrderPrice(rs.getDouble("total_price"));
			return orderDetails;
		});
	}

	@SuppressWarnings("deprecation")
	public List<OrderItemDetails> getOrderDetails(int userId) {
		String sql = "SELECT o.order_id, c.car_name, oi.quantity,oi.price,(oi.quantity * oi.price) AS total_price_per_item,o.total_price AS total_order_price, o.status FROM orders o JOIN order_items oi ON o.order_id = oi.order_id JOIN cars c ON oi.car_id = c.car_id WHERE o.user_id = ?";
		return jdbcTemplate.query(sql, new Object[] { userId }, (rs, rowNum) -> {
			OrderItemDetails orderDetails = new OrderItemDetails();
			orderDetails.setOrderId(rs.getInt("order_id"));
			orderDetails.setCarName(rs.getString("car_name"));
			orderDetails.setQuantity(rs.getInt("quantity"));
			orderDetails.setPrice(rs.getDouble("price"));
			orderDetails.setTotalPricePerItem(rs.getDouble("total_price_per_item"));
			orderDetails.setTotalOrderPrice(rs.getDouble("total_order_price"));
			orderDetails.setStatus(rs.getString("status"));
			return orderDetails;
		});
	}
	
	@SuppressWarnings("deprecation")
	public List<OrderItemDetails> fetchOrderItemDetails(int orderId) {
        String sql = "SELECT oi.order_item_id, oi.order_id, c.car_name, oi.quantity, oi.price, (oi.quantity * oi.price) AS total_price_per_item, o.total_price AS total_order_price, o.status FROM order_items oi JOIN cars c ON oi.car_id = c.car_id JOIN orders o ON oi.order_id = o.order_id WHERE oi.order_id = ?";
        return jdbcTemplate.query(sql, new Object[]{orderId}, new OrderItemDetailsRowMapper());
    }
	
	public class OrderItemDetailsRowMapper implements RowMapper<OrderItemDetails> {

	    @Override
	    public OrderItemDetails mapRow(ResultSet rs, int rowNum) throws SQLException {
	        OrderItemDetails details = new OrderItemDetails();
	        details.setOrderItemId(rs.getInt("order_item_id"));
	        details.setOrderId(rs.getInt("order_id"));
	        details.setCarName(rs.getString("car_name"));
	        details.setQuantity(rs.getInt("quantity"));
	        details.setPrice(rs.getDouble("price"));
	        details.setTotalPricePerItem(rs.getDouble("total_price_per_item"));
	        details.setTotalOrderPrice(rs.getDouble("total_order_price"));
	        details.setStatus(rs.getString("status"));
	        return details;
	    }
	}

	public int orderCount() {
		String sql = "SELECT COUNT(*) FROM orders";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}

}
