package com.carshowroom.model;

public class Testimonial {
	private String description;
	private String userName;
	private String userImage;

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserImage() {
		return userImage;
	}

	public void setUserImage(String userImage) {
		this.userImage = userImage;
	}

	@Override
	public String toString() {
		return "Testimonial [description=" + description + ", userName=" + userName + ", userImage=" + userImage + "]";
	}
	
	

}
