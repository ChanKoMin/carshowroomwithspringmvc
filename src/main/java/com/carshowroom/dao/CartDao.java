package com.carshowroom.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.carshowroom.model.Car;
import com.carshowroom.model.CarAvailability;
import com.carshowroom.model.CarTransmission;
import com.carshowroom.model.Cart;
import com.carshowroom.model.CartItemDetails;

@Repository
public class CartDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	public void addCartItem(Cart cart) {
		String sql = "INSERT INTO carts (car_id, user_id, quantity) VALUES (?, ?, ?)";
		jdbcTemplate.update(sql, cart.getCarId(), cart.getUserId(), cart.getQuantity());
	}

	public void updateCartItem(Cart cart) {
		String sql = "UPDATE carts SET quantity = quantity + ? WHERE car_id = ? AND user_id = ?";
		jdbcTemplate.update(sql, cart.getQuantity(), cart.getCarId(), cart.getUserId());
	}

	@SuppressWarnings("deprecation")
	public boolean cartItemExists(int userId, int carId) {
		String sql = "SELECT COUNT(*) FROM carts WHERE user_id = ? AND car_id = ?";
		Integer count = jdbcTemplate.queryForObject(sql, new Object[] { userId, carId }, Integer.class);
		return count != null && count > 0;
	}

	@SuppressWarnings("deprecation")
	public List<CartItemDetails> getCarsFromCart(int userId) {
		String sql = "SELECT c.car_id AS car_id, c.car_name AS car_name, c.car_image AS car_image, c.car_price AS car_price,ca.cart_id AS cart_id ,ca.quantity AS cart_quantity FROM carts ca JOIN cars c ON ca.car_id = c.car_id WHERE ca.user_id = ?";
		return jdbcTemplate.query(sql, new Object[] { userId }, (rs, rowNum) -> {
			CartItemDetails item = new CartItemDetails();
			item.setCarId(rs.getInt("car_id"));
			item.setCarName(rs.getString("car_name"));
			item.setCarImage(rs.getString("car_image"));
			item.setCarPrice(rs.getInt("car_price"));
			item.setCartId(rs.getInt("cart_id"));
			item.setQuantity(rs.getInt("cart_quantity"));
			return item;
		});
	}

	@SuppressWarnings("deprecation")
	public int getCartItemCount(int userId) {
		String sql = "SELECT SUM(quantity) FROM carts WHERE user_id = ?";
		Integer count = jdbcTemplate.queryForObject(sql, new Object[] { userId }, Integer.class);
		return count != null ? count : 0;
	}

	public void deleteCartItemsByUserId(int userId) {
		String sql = "DELETE FROM carts WHERE user_id = ?";
		jdbcTemplate.update(sql, userId);
	}

	public int deleteById(int id) {
		String sql = "DELETE FROM carts WHERE cart_id = ?";
		return jdbcTemplate.update(sql, id);
	}

	@SuppressWarnings("deprecation")
	public List<Cart> getCartItems(int userId) {
		String sql = "SELECT * FROM carts WHERE user_id = ?";
		return jdbcTemplate.query(sql, new Object[] { userId }, (rs, rowNum) -> {
			Cart cart = new Cart();
			cart.setId(rs.getInt("cart_id"));
			cart.setCarId(rs.getInt("car_id"));
			cart.setUserId(rs.getInt("user_id"));
			cart.setQuantity(rs.getInt("quantity"));
			return cart;
		});
	}
}
