package com.carshowroom.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.carshowroom.model.Car;
import com.carshowroom.model.CarAvailability;
import com.carshowroom.model.CarTransmission;

@Repository
public class CarDao {
	private JdbcTemplate jdbcTemplate;

	public CarDao(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public void setDataSource(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public void save(Car car) {
		String sql = "INSERT INTO cars (brand_id,car_name,car_model,car_type,car_year,car_color,car_cylinder,car_engine,car_transmission,car_availability,current_inventory,car_description,car_price,car_image) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		jdbcTemplate.update(sql, car.getBrandId(), car.getCarName(), car.getCarModel(), car.getCarType(),
				car.getCarYear(), car.getCarColor(), car.getCarCylinder(), car.getCarEngine(),
				car.getCarTransmission().name(), car.getCarAvailability().name(),car.getCurrentInventory() ,car.getCarDescription(),
				car.getCarPrice(), car.getCarImage());
	}

	public int deleteById(int id) {
		String sql = "DELETE FROM cars WHERE car_id = ?";
		return jdbcTemplate.update(sql, id);
	}

	public int update(Car car) {
		String sql = "UPDATE cars SET brand_id = ?, car_name = ?, car_model = ?, car_type = ?, car_year = ?, car_color = ?, car_cylinder = ?, car_engine = ?, car_transmission = ?, car_availability = ?,current_inventory = ? ,car_description = ?, car_price = ?, car_image = ? WHERE car_id = ?";
		return jdbcTemplate.update(sql, car.getBrandId(), car.getCarName(), car.getCarModel(), car.getCarType(),
				car.getCarYear(), car.getCarColor(), car.getCarCylinder(), car.getCarEngine(),
				car.getCarTransmission().name(), car.getCarAvailability().name(),car.getCurrentInventory() ,car.getCarDescription(),
				car.getCarPrice(), car.getCarImage(), car.getId());
	}

	@SuppressWarnings("deprecation")
	public Car findById(int id) {
		String sql = "SELECT * FROM cars WHERE car_id = ?";
		return jdbcTemplate.queryForObject(sql, new Object[] { id }, new RowMapper<Car>() {
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
				car.setCurrentInventory(rs.getInt("current_inventory"));
				car.setCarDescription(rs.getString("car_description"));
				car.setCarPrice(rs.getString("car_price"));
				car.setCarImage(rs.getString("car_image"));
				return car;
			}
		});
	}

	private class CarRowMapper implements RowMapper<Car> {
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
			car.setCurrentInventory(rs.getInt("current_inventory"));
			car.setCarDescription(rs.getString("car_description"));
			car.setCarPrice(rs.getString("car_price"));
			car.setCarImage(rs.getString("car_image"));
			return car;
		}
	}

	public List<Car> findAll(int page, int pageSize) {
		int offset = (page - 1) * pageSize;
		String sql = "SELECT * FROM cars ORDER BY car_id DESC LIMIT ? OFFSET ?";
		return jdbcTemplate.query(sql, new CarRowMapper(), pageSize, offset);
	}
	
	public List<Car> findAll() {
		String sql = "SELECT * FROM cars";
		return jdbcTemplate.query(sql, new CarRowMapper());
	}

	public List<Car> findAll(String filter) {
		String sql = "SELECT * FROM cars";
		if ("INSTOCK".equals(filter)) {
            sql += " WHERE car_availability = true";
        } else if ("New Cars".equals(filter)) {
            sql += " ORDER BY created_at DESC LIMIT 5";
        }
		return jdbcTemplate.query(sql, new CarRowMapper());
	}
	
	@SuppressWarnings("deprecation")
	public List<Car> findByBrandId(int id){
		String sql = "SELECT * FROM cars WHERE brand_id = ?";
		return jdbcTemplate.query(sql,new Object[] {id} ,new CarRowMapper());
	}
	
	public List<String> getAllCarTypes(){
		String sql = "SELECT DISTINCT car_type FROM cars";
		return jdbcTemplate.queryForList(sql, String.class);
	}
	
	@SuppressWarnings("deprecation")
	public List<Car> getCarByTypes(String carType){
		String sql = "SELECT * FROM cars WHERE car_type = ?";
		return jdbcTemplate.query(sql, new Object[] {carType}, new CarRowMapper());
	}

	public int carCount() {
		String sql = "SELECT COUNT(*) FROM cars";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}
	
	public int countOrdersByCarId(int carId) {
	    String sql = "SELECT COUNT(*) FROM order_items WHERE car_id = ?";
	    return jdbcTemplate.queryForObject(sql, Integer.class, carId);
	}
	
	@SuppressWarnings("deprecation")
	public List<Car> relatedCars(String carType, int carId){
		String sql = "SELECT * FROM cars WHERE car_type = ? AND car_id != ? LIMIT 4";
		return jdbcTemplate.query(sql, new Object[] {carType,carId}, new CarRowMapper());
	}

	public void decreaseInventory(int carId, int quantity) {
		String sql = "UPDATE cars SET current_inventory = current_inventory - ? WHERE car_id = ?";
		jdbcTemplate.update(sql,quantity,carId);
	}
}
