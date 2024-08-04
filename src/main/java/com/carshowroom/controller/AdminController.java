package com.carshowroom.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.carshowroom.dao.AdminDao;
import com.carshowroom.dao.BrandDao;
import com.carshowroom.dao.CarDao;
import com.carshowroom.dao.FeedbackDao;
import com.carshowroom.dao.OrderDao;
import com.carshowroom.dao.UserDao;
import com.carshowroom.model.Admin;

@Controller
public class AdminController {
	private AdminDao adminDao;
	private BrandDao brandDao;
	private CarDao carDao;
	private UserDao userDao;
	private FeedbackDao fbDao;
	private OrderDao orderDao;

	@Autowired
	public AdminController(AdminDao adminDao, BrandDao brandDao, CarDao carDao, UserDao userDao, FeedbackDao fbDao, OrderDao orderDao) {
		this.adminDao = adminDao;
		this.brandDao = brandDao;
		this.carDao = carDao;
		this.userDao = userDao;
		this.fbDao = fbDao;
		this.orderDao = orderDao;
	}

	@Autowired
	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}

	@Autowired
	public void setBrandDao(BrandDao brandDao) {
		this.brandDao = brandDao;
	}

	@Autowired
	public void setCarDao(CarDao carDao) {
		this.carDao = carDao;
	}

	@Autowired
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	@Autowired
	public void setFeedbackDao(FeedbackDao fbDao) {
		this.fbDao = fbDao;
	}
	
	@Autowired
	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}
	
	private boolean isAuthenticated(HttpSession session) {
		return session != null && session.getAttribute("admin") != null;
	}

	@GetMapping("/dashboard")
	public String showAdminDashboard(Model m, HttpSession session) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		Admin adm = (Admin) session.getAttribute("admin");
		m.addAttribute("admin", adm);
		Admin admin = adminDao.showAdmin();
		int totalBrands = brandDao.brandCount();
		int totalCars = carDao.carCount();
		int totalUsers = userDao.userCount();
		double totalFeedbacks = fbDao.calculateAverageRating();
		int totalOrders = orderDao.orderCount();
		String formattedValue = String.format("%.2f", totalFeedbacks);
		m.addAttribute("admin", admin);
		m.addAttribute("brand", totalBrands);
		m.addAttribute("car", totalCars);
		m.addAttribute("user", totalUsers);
		m.addAttribute("order", totalOrders);
		m.addAttribute("feedback", formattedValue);
		return "admin/index";
	}

	@RequestMapping("/admin-profile")
	public String showAdminProfilePage(Model m, HttpSession session) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		Admin adm = (Admin) session.getAttribute("admin");
		m.addAttribute("admin", adm);
		Admin admin = adminDao.showAdmin();
		m.addAttribute("admin", admin);
		return "admin/profile";
	}

	@RequestMapping("/admin-edit/{id}")
	public String showAdminEditPage(@PathVariable int id, Model m, HttpSession session) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		Admin adm = (Admin) session.getAttribute("admin");
		m.addAttribute("admin", adm);
		Admin admin = adminDao.findById(id);
		m.addAttribute("admin", admin);
		return "admin/edit-profile";
	}

	@PostMapping("/profile/update")
	public String updateProfile(@ModelAttribute("admin") @Valid Admin admin, BindingResult result,
			RedirectAttributes ra,Model m,HttpSession session) {
		if (result.hasErrors()) {
			return "admin/edit-profile";
		}
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		Admin adm = (Admin) session.getAttribute("admin");
		m.addAttribute("admin", adm);
		adminDao.update(admin);
		ra.addFlashAttribute("updatedSuccessfully", "Account updated successfully!");
		return "redirect:/admin-profile";
	}
}
