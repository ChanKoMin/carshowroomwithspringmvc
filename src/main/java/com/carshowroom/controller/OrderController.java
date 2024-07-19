package com.carshowroom.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.carshowroom.dao.AdminDao;
import com.carshowroom.dao.BrandDao;
import com.carshowroom.model.Admin;

@Controller
public class OrderController {
	private AdminDao adminDao;

	@Autowired
	public OrderController(AdminDao adminDao) {
		this.adminDao = adminDao;
	}

	@Autowired
	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}

	@RequestMapping("/orders")
	public String showOrderPage(Model m) {
		Admin admin = adminDao.showAdmin();
		m.addAttribute("admin", admin);
		return "admin/orders";
	}

	@RequestMapping("/complete-order")
	public String showCompleteOrderPage(Model m) {
		Admin admin = adminDao.showAdmin();
		m.addAttribute("admin", admin);
		return "admin/complete-order";
	}
}
