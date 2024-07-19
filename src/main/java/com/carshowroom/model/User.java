package com.carshowroom.model;

import javax.validation.constraints.Size;

public class User {
	private int id;
	private String name;
	@Size(min = 6, message = "Please provide a valid email address")
	private String email;
	@Size(min = 6, message = "Password must be at least 6 characters long")
	private String password;
	private String contact_number;
	private String address;
	private String image;
	private Role role;

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

	public String getContact_number() {
		return contact_number;
	}

	public void setContact_number(String contact_number) {
		this.contact_number = contact_number;
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

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", email=" + email + ", password=" + password + ", contact_number="
				+ contact_number + ", address=" + address + ", image=" + image + ", role=" + role + "]";
	}

}
