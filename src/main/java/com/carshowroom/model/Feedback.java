package com.carshowroom.model;

public class Feedback {
	private int id;
	private int userId;
	private String description;
	private Rate rate;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Rate getRate() {
		return rate;
	}

	public void setRate(Rate rate) {
		this.rate = rate;
	}

	@Override
	public String toString() {
		return "Feedback [id=" + id + ", userId=" + userId + ", description=" + description + ", rate=" + rate + "]";
	}

}
