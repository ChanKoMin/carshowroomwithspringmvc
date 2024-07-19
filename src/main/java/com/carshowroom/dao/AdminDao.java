package com.carshowroom.dao;


import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.carshowroom.model.Admin;
@Repository
public class AdminDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
	
	@SuppressWarnings("deprecation")
	public Admin findById(int id) {
		String sql = "SELECT * FROM admin WHERE id = ?";
		return jdbcTemplate.queryForObject(sql, new Object[] {id}, new RowMapper<Admin>() {
			@Override
			public Admin mapRow(ResultSet rs, int rowNum) throws SQLException {
				Admin admin = new Admin();
				admin.setId(rs.getInt("id"));
				admin.setName(rs.getString("name"));
				admin.setEmail(rs.getString("email"));
				admin.setPassword(rs.getString("password"));
				admin.setPhone(rs.getString("phone"));
				admin.setAddress(rs.getString("address"));
				admin.setImage(rs.getString("image"));
				return admin;
			}
			
		});
	}
	
	public void update(Admin admin) {
		String sql = "UPDATE admin SET name = ?, email = ?, password = ?, phone = ?, address = ?, image = ? WHERE id = ?";
		jdbcTemplate.update(sql,admin.getName(),admin.getEmail(),admin.getPassword(),admin.getPhone(),admin.getAddress(),admin.getImage(),admin.getId());
	}
	
	@SuppressWarnings("deprecation")
	public Admin findByEmailAndPassword(String email, String password) {
		String sql = "SELECT * FROM admin WHERE email = ? AND password = ?";
		return jdbcTemplate.queryForObject(sql,new Object[] {email, password}, new RowMapper<Admin>() {
			@Override
			public Admin mapRow(ResultSet rs, int rowNum) throws SQLException {
				Admin admin = new Admin();
				admin.setId(rs.getInt("id"));
				admin.setEmail(rs.getString("email"));
				admin.setPassword(rs.getString("password"));
				return admin;
			}
		});
	}
	
	public Admin showAdmin() {
		String sql = "SELECT * FROM admin";
		return jdbcTemplate.queryForObject(sql, new RowMapper<Admin>() {

			@Override
			public Admin mapRow(ResultSet rs, int rowNum) throws SQLException {
				Admin admin = new Admin();
				admin.setId(rs.getInt("id"));
				admin.setName(rs.getString("name"));
				admin.setEmail(rs.getString("email"));
				admin.setPassword(rs.getString("password"));
				admin.setPhone(rs.getString("phone"));
				admin.setAddress(rs.getString("address"));
				admin.setImage(rs.getString("image"));
				return admin;
			}
			
		});
	}
	
}
