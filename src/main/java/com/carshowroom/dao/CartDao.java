package com.carshowroom.dao;

import com.carshowroom.model.Car;
import com.carshowroom.model.CarAvailability;
import com.carshowroom.model.CarTransmission;
import com.carshowroom.model.Cart;
import com.carshowroom.model.CartItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class CartDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // SQL queries
    private static final String INSERT_CART_ITEM = "INSERT INTO carts (car_id, user_id, quantity) VALUES (?, ?, ?)";
    private static final String SELECT_CART_ITEMS_BY_USER = "SELECT * FROM carts WHERE user_id = ?";
    private static final String SELECT_CART_ITEM_COUNT_BY_USER = "SELECT COUNT(*) FROM carts WHERE user_id = ?";

    // Add an item to the cart
    public void addCartItem(Cart cart) {
        jdbcTemplate.update(INSERT_CART_ITEM,
                cart.getCarId(),
                cart.getUserId(),
                cart.getQuantity());
    }
    
    @SuppressWarnings("deprecation")
	public Car getCarById(int carId) {
        String sql = "SELECT * FROM cars WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{carId}, new RowMapper<Car>() {
            @Override
            public Car mapRow(ResultSet rs, int rowNum) throws SQLException {
                Car car = new Car();
                car.setId(rs.getInt("car_id"));
				car.setBrandId(rs.getInt("brand_id"));
				car.setCarName(rs.getString("car_name"));
				car.setCarModel(rs.getString("car_model"));
				car.setCarType(rs.getString("car_type"));
				car.setCarYear(rs.getString("car_year"));
				car.setCarColor(rs.getString("car_color"));
				car.setCarCylinder(rs.getString("car_cylinder"));
				car.setCarEngine(rs.getString("car_engine"));
				car.setCarTransmission(CarTransmission.valueOf(rs.getString("car_transmission")));
				car.setCarAvailability(CarAvailability.valueOf(rs.getString("car_availability")));
				car.setCarDescription(rs.getString("car_description"));
				car.setCarPrice(rs.getString("car_price"));
				car.setCarImage(rs.getString("car_image"));
                return car;
            }
        });
    }

    // Get all cart items for a specific user
    public List<CartItem> getCartItemsForUser(int userId) {
        return jdbcTemplate.query(SELECT_CART_ITEMS_BY_USER,
                new BeanPropertyRowMapper<>(CartItem.class),
                userId);
    }

    // Get the count of items in the cart for a specific user
    public int getCartItemCountByUserId(int userId) {
        return jdbcTemplate.queryForObject(SELECT_CART_ITEM_COUNT_BY_USER, Integer.class, userId);
    }

    // Optionally: You can add more methods like updateCartItem, deleteCartItem, etc.
}
