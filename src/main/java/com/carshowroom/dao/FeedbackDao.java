package com.carshowroom.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.carshowroom.model.Feedback;
import com.carshowroom.model.Rate;
import com.carshowroom.model.Testimonial;

@Repository
public class FeedbackDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	public FeedbackDao(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public void setDataSource(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public void save(Feedback feedback) {
		String sql = "INSERT INTO feedbacks (user_id, description, rate) VALUES (?,?,?)";
		jdbcTemplate.update(sql, feedback.getUserId(), feedback.getDescription(), feedback.getRate().getValue());

	}

	public List<Feedback> findAll(int page, int pageSize) {
		int offset = (page - 1) * pageSize;
		String sql = "SELECT * FROM feedbacks ORDER BY id DESC LIMIT ? OFFSET ?";
		return jdbcTemplate.query(sql, new RowMapper<Feedback>() {
			@Override
			public Feedback mapRow(ResultSet rs, int rowNum) throws SQLException {
				Feedback fb = new Feedback();
				fb.setId(rs.getInt("id"));
				fb.setUserId(rs.getInt("user_id"));
				fb.setDescription(rs.getString("description"));
				fb.setRate(Rate.fromValue(rs.getInt("rate")));
				return fb;
			}

		}, pageSize, offset);

	}

	@SuppressWarnings("deprecation")
	public List<Testimonial> showFeedbackOnUser(int currentUserId) {
		String sql = "SELECT f.description, u.name as user_name, u.image as user_image FROM feedbacks f JOIN users u ON f.user_id = u.id WHERE f.rate = 5 AND f.user_id != ? AND f.id IN (SELECT MIN(f2.id) FROM feedbacks f2 WHERE f2.rate = 5 AND f2.user_id != ? GROUP BY f2.user_id ORDER BY RAND()) ORDER BY RAND() LIMIT 3";
		//String sql = "SELECT f.description, u.name as user_name, u.image as user_image FROM feedbacks f JOIN users u ON f.user_id = u.id WHERE f.rate = 5 AND f.id IN (SELECT MIN(f2.id) FROM feedbacks f2 WHERE f2.rate = 5 GROUP BY f2.user_id ORDER BY RAND()) ORDER BY RAND() LIMIT 3";
		return jdbcTemplate.query(sql, new Object[]{currentUserId, currentUserId}, (rs, rowNum) -> {
			Testimonial test = new Testimonial();
			test.setDescription(rs.getString("description"));
			test.setUserName(rs.getString("user_name"));
			test.setUserImage(rs.getString("user_image"));
			return test;
		});
	}

	public int fbCount() {
		String sql = "SELECT COUNT(*) FROM feedbacks";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}

	public double calculateAverageRating() {
		String sql = "SELECT AVG(rate) AS average_rating FROM feedbacks";
		Double averageRating = jdbcTemplate.queryForObject(sql, Double.class);
		return averageRating != null ? averageRating : 0.0;
	}

}
