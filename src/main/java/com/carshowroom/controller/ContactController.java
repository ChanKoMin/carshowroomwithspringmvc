package com.carshowroom.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.carshowroom.dao.AdminContactDao;
import com.carshowroom.dao.AdminDao;
import com.carshowroom.dao.OrderDao;
import com.carshowroom.model.Admin;
import com.carshowroom.model.AdminContact;

@Controller
public class ContactController {
	private AdminDao adminDao;
	private AdminContactDao actDao;
	private OrderDao orderDao;
	
	@Autowired
	public ContactController(AdminDao adminDao,AdminContactDao actDao,OrderDao orderDao) {
		this.adminDao = adminDao;
		this.actDao = actDao;
		this.orderDao = orderDao;
	}
	
	@Autowired
	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}
	
	@Autowired
	public void setAdminContactDao(AdminContactDao actDao) {
		this.actDao = actDao;
	}
	
	@Autowired
	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}

	private boolean isAuthenticated(HttpSession session) {
		return session != null && session.getAttribute("admin") != null;
	}

	@RequestMapping("/contacts")
	public String showAdminContactPage(Model m, HttpSession session) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		Admin adm = (Admin) session.getAttribute("admin");
		Admin admin = adminDao.showAdmin();
		List<AdminContact> admcontact = actDao.findAll();
		int newOrderCount = orderDao.getNewOrderCount();
		m.addAttribute("newOrderCount", newOrderCount);
		m.addAttribute("admin", adm);
		m.addAttribute("admin", admin);
		m.addAttribute("admcontact", admcontact);
		return "admin/contact";
	}
}
