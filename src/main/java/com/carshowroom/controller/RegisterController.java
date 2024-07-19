package com.carshowroom.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.carshowroom.dao.UserDao;
import com.carshowroom.model.Role;
import com.carshowroom.model.User;

@Controller
public class RegisterController {
	@Autowired
	private UserDao userDao;

	@GetMapping("/register")
	public String showRegisterPage(Model m) {
		m.addAttribute("user", new User());
		m.addAttribute("roles", Role.values());
		return "user/register";
	}

	@PostMapping("/register")
	public String register(@ModelAttribute("user") @Valid User user, BindingResult result, Model model) {
		if (result.hasErrors()) {
			model.addAttribute("roles", Role.values()); // Pass roles again if there are errors
			return "user/register";
		}
		userDao.save(user); // Save user to database
		return "redirect:/"; // Redirect to login page
	}
}
