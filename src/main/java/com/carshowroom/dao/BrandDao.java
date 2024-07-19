package com.carshowroom.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.carshowroom.model.Brand;

@Repository
public class BrandDao {
	private JdbcTemplate jdbcTemplate;

	public BrandDao(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public void setDataSource(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public void save(Brand brand) {
		String sql = "INSERT INTO brands (name, img) VALUES (?,?)";
		jdbcTemplate.update(sql, brand.getName(), brand.getImg());
	}

	public void update(Brand brand) {
		String sql = "UPDATE brands SET name = ?, img = ? WHERE id = ?";
		jdbcTemplate.update(sql, brand.getName(), brand.getImg(), brand.getId());
	}

	public int deleteById(int id) {
		String sql = "DELETE FROM brands WHERE id= ?";
		return jdbcTemplate.update(sql, id);
	}

	@SuppressWarnings("deprecation")
	public Brand findById(int id) {
		String sql = "SELECT * FROM brands WHERE id = ?";
		return jdbcTemplate.queryForObject(sql, new Object[] { id }, new RowMapper<Brand>() {
			@Override
			public Brand mapRow(ResultSet rs, int rowNum) throws SQLException {
				Brand brand = new Brand();
				brand.setId(rs.getInt("id"));
				brand.setName(rs.getString("name"));
				brand.setImg(rs.getString("img"));
				return brand;
			}
		});
	}
	
	private class BrandRowMapper implements RowMapper<Brand>{
		@Override
		public Brand mapRow(ResultSet rs, int rowNum) throws SQLException {
			Brand brand = new Brand();
			brand.setId(rs.getInt("id"));
			brand.setName(rs.getString("name"));
			brand.setImg(rs.getString("img"));
			return brand;
		}
	}

	public List<Brand> findAll(int page, int pageSize) {
		int offset = (page - 1) * pageSize;
		String sql = "SELECT * FROM brands ORDER BY id DESC LIMIT ? OFFSET ?";
		return jdbcTemplate.query(sql, new BrandRowMapper(),pageSize, offset);
	}
	
	public List<Brand> findAll() {
		String sql = "SELECT * FROM brands";
		return jdbcTemplate.query(sql, new BrandRowMapper());
	}
	
	public int brandCount() {
		String sql = "SELECT COUNT(*) FROM brands";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}
}
