package com.carshowroom.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PageController {

	@RequestMapping("/logout")
	public String showLogout() {
		return "redirect:/";
	}

	@RequestMapping("/bookings")
	public String showBookingPage() {
		return "user/bookings";
	}

	@RequestMapping("/contact")
	public String showContactPage() {
		return "user/contact";
	}

	@RequestMapping("/cart")
	public String showCartPage() {
		return "user/cart";
	}

	

}
