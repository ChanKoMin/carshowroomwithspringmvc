package com.carshowroom.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.carshowroom.dao.AdminDao;
import com.carshowroom.dao.UserDao;
import com.carshowroom.model.Admin;
import com.carshowroom.model.User;

@Controller
public class LoginController {
	private AdminDao adminDao;
	private UserDao userDao;

	@Autowired
	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}
	
	@Autowired
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	@GetMapping("/")
	public String showLoginPage(Model m) {
		m.addAttribute("admin", new Admin());
		m.addAttribute("user", new User());
		return "user/login";
	}

	@PostMapping("/login")
	public String login(@ModelAttribute("admin") @Valid Admin admin, BindingResult adminResult,
			@ModelAttribute("user") @Valid User user, BindingResult userResult, HttpSession session ,Model m) {
		if (adminResult.hasErrors() || userResult.hasErrors()) {
			return "redirect:/";
		}

		try {
			Admin loggedAdmin = adminDao.findByEmailAndPassword(admin.getEmail(), admin.getPassword());
			if (loggedAdmin != null) {
				session.setAttribute("admin", loggedAdmin);
				return "redirect:/dashboard";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			User loggedUser = userDao.findByEmailAndPassword(user.getEmail(), user.getPassword());
			if (loggedUser != null) {
				session.setAttribute("user", loggedUser);
				return "redirect:/home";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		m.addAttribute("error", "Invalid email or password");
		return "user/login";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@GetMapping("/admin-logout")
	public String adminLogout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}
