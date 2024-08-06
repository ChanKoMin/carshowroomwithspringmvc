package com.carshowroom.model;

import java.time.LocalDateTime;
import javax.validation.constraints.NotEmpty;

import org.springframework.format.annotation.DateTimeFormat;

public class Brand {
	private int id;
	@NotEmpty(message = "Name is required")
    private String name;
	private String img;
    @DateTimeFormat
    private LocalDateTime createdAt;

//	public Brand() {
//		super();
//	}

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

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	@Override
	public String toString() {
		return "Brand [id=" + id + ", name=" + name + ", img=" + img + "]";
	}

	

}
