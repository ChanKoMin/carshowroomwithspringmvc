package com.carshowroom.model;

import javax.validation.constraints.Size;

public class Admin {
	private int id;
	@Size(min = 1, message = "Name must be required")
	private String name;
	@Size(min = 6, message = "Please provide a valid email address")
	private String email;
	@Size(min = 6, message = "Password must be at least 6 characters long")
	private String password;
	@Size(min = 11, message = "Phone number must be required")
	private String phone;
	@Size(min = 1, message = "Address must be required")
	private String address;
	@Size(min = 1, message = "Image must be required")
	private String image;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	@Override
	public String toString() {
		return "Admin [id=" + id + ", name=" + name + ", email=" + email + ", password=" + password + ", phone=" + phone
				+ ", address=" + address + ", image=" + image + "]";
	}

}
