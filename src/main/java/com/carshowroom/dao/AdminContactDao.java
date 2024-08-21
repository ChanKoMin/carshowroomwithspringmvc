package com.carshowroom.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.carshowroom.model.AdminContact;
import com.carshowroom.model.Contact;

@Repository
public class AdminContactDao {
	private JdbcTemplate jdbcTemplate;

	public AdminContactDao(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public void setDataSource(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	public void save(Contact contact) {
		String sql = "INSERT INTO contacts (user_id, message) VALUES (?,?)";
		jdbcTemplate.update(sql, contact.getUserId(), contact.getMessage());
	}
	
	public List<AdminContact> findAll(){
		String sql = "SELECT u.name AS user_name, u.email, c.message FROM contacts c JOIN users u ON c.user_id = u.id;";
		return jdbcTemplate.query(sql, new RowMapper<>() {

			@Override
			public AdminContact mapRow(ResultSet rs, int rowNum) throws SQLException {
				AdminContact admcontact = new AdminContact();
				admcontact.setUserName(rs.getString("user_name"));
				admcontact.setEmail(rs.getString("email"));
				admcontact.setMessage(rs.getString("message"));
				return admcontact;
			}
			
		});
	}
}
