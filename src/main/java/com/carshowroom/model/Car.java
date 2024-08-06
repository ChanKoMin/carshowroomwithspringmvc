package com.carshowroom.model;

import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;

public class Car {
	private int id;
	private int brandId;
	@NotEmpty(message = "Car name is required")
	private String carName;
	@NotEmpty(message = "Car model is required")
	private String carModel;
	@NotEmpty(message = "Car type is required")
	private String carType;
	@NotEmpty(message = "Car year is required")
	private String carYear;
	@NotEmpty(message = "Car color is required")
	private String carColor;
	@NotEmpty(message = "Car cylinder is required")
	private String carCylinder;
	@NotEmpty(message = "Car engine is required")
	private String carEngine;
	private CarTransmission carTransmission;
	private CarAvailability carAvailability;
	@NotEmpty(message = "Car description is required")
	private String carDescription;
	@NotEmpty(message = "Car price is required")
	private String carPrice;
	private String carImage;
	private Brand brand;
	private int count;
	private LocalDateTime createdAt;

	public Car() {
		this.createdAt = LocalDateTime.now();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getBrandId() {
		return brandId;
	}

	public void setBrandId(int brandId) {
		this.brandId = brandId;
	}

	public String getCarName() {
		return carName;
	}

	public void setCarName(String carName) {
		this.carName = carName;
	}

	public String getCarModel() {
		return carModel;
	}

	public void setCarModel(String carModel) {
		this.carModel = carModel;
	}

	public String getCarType() {
		return carType;
	}

	public void setCarType(String carType) {
		this.carType = carType;
	}

	public String getCarYear() {
		return carYear;
	}

	public void setCarYear(String carYear) {
		this.carYear = carYear;
	}

	public String getCarColor() {
		return carColor;
	}

	public void setCarColor(String carColor) {
		this.carColor = carColor;
	}

	public String getCarCylinder() {
		return carCylinder;
	}

	public void setCarCylinder(String carCylinder) {
		this.carCylinder = carCylinder;
	}

	public String getCarEngine() {
		return carEngine;
	}

	public void setCarEngine(String carEngine) {
		this.carEngine = carEngine;
	}

	public CarTransmission getCarTransmission() {
		return carTransmission;
	}

	public void setCarTransmission(CarTransmission carTransmission) {
		this.carTransmission = carTransmission;
	}

	public CarAvailability getCarAvailability() {
		return carAvailability;
	}

	public void setCarAvailability(CarAvailability carAvailability) {
		this.carAvailability = carAvailability;
	}

	public String getCarDescription() {
		return carDescription;
	}

	public void setCarDescription(String carDescription) {
		this.carDescription = carDescription;
	}

	public String getCarPrice() {
		return carPrice;
	}

	public void setCarPrice(String carPrice) {
		this.carPrice = carPrice;
	}

	public String getCarImage() {
		return carImage;
	}

	public void setCarImage(String carImage) {
		this.carImage = carImage;
	}

	public Brand getBrand() {
		return brand;
	}

	public void setBrand(Brand brand) {
		this.brand = brand;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	@Override
	public String toString() {
		return "Car [id=" + id + ", carName=" + carName + ", carModel=" + carModel + ", carType=" + carType
				+ ", carYear=" + carYear + ", carColor=" + carColor + ", carCylinder=" + carCylinder + ", carEngine="
				+ carEngine + ", carTransmission=" + carTransmission + ", carAvailability=" + carAvailability
				+ ", carDescription=" + carDescription + ", carPrice=" + carPrice + ", carImage=" + carImage + "]";
	}

}
