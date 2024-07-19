package com.carshowroom.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.carshowroom.model.Role;
import com.carshowroom.model.User;

@Repository
public class UserDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

	public void save(User user) {
		String sql = "INSERT INTO users (name,email,password,contact_number,address,image,role) VALUES (?,?,?,?,?,?,?)";
		jdbcTemplate.update(connection -> {
			PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, user.getName());
			stmt.setString(2, user.getEmail());
			stmt.setString(3, user.getPassword());
			stmt.setString(4, user.getContact_number());
			stmt.setString(5, user.getAddress());
			stmt.setString(6, user.getImage());
			stmt.setString(7, user.getRole().name()); // Convert enum to string
			return stmt;
		});
	}

	@SuppressWarnings("deprecation")
	public User findByEmailAndPassword(String email, String password) {
		String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
		return jdbcTemplate.queryForObject(sql, new Object[] { email, password }, new UserRowMapper());
	}

	private static final class UserRowMapper implements RowMapper<User> {

		@Override
		public User mapRow(ResultSet rs, int rowNum) throws SQLException {
			User user = new User();
			user.setId(rs.getInt("id"));
			user.setName(rs.getString("name"));
			user.setEmail(rs.getString("email"));
			user.setPassword(rs.getString("password"));
			user.setContact_number(rs.getString("contact_number"));
			user.setAddress(rs.getString("address"));
			user.setImage(rs.getString("image"));
			user.setRole(Role.valueOf(rs.getString("role")));
			return user;
		}

	}

	public List<User> findAll(int page, int pageSize) {
		int offset = (page - 1) * pageSize;
		String sql = "SELECT * FROM users ORDER BY id DESC LIMIT ? OFFSET ?";
		return jdbcTemplate.query(sql, new RowMapper<User>() {

			@Override
			public User mapRow(ResultSet rs, int rowNum) throws SQLException {
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setContact_number(rs.getString("contact_number"));
				user.setAddress(rs.getString("address"));
				user.setImage(rs.getString("image"));
				user.setRole(Role.valueOf(rs.getString("role")));
				return user;
			}

		}, pageSize, offset);
	}
	
	public int userCount() {
		String sql = "SELECT COUNT(*) FROM users";
		return jdbcTemplate.queryForObject(sql,Integer.class);
	}
}
