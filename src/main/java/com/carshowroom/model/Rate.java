package com.carshowroom.model;

public enum Rate {
	ONE(1), TWO(2), THREE(3), FOUR(4), FIVE(5);

	private int value;

	private Rate(int value) {
		this.value = value;
	}

	public int getValue() {
		return value;
	}

	public static Rate fromValue(int value) {
		for (Rate rate : Rate.values()) {
			if (rate.getValue() == value) {
				return rate;
			}
		}
		throw new IllegalArgumentException("Invalid value: " + value);
	}
}
