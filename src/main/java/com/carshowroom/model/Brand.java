package com.carshowroom.model;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

public class Brand {
	private int id;
	@Size(min = 1, message = "Brand name must be required")
	private String name;
    @NotBlank(message = "Image must not be blank")
	private String img;

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
