package com.carshowroom.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.carshowroom.model.Feedback;
import com.carshowroom.model.Rate;

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
	
	public List<Feedback> findAll(int page, int pageSize){
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
			
		},pageSize, offset);
		
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
