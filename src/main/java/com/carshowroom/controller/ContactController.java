package com.carshowroom.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.carshowroom.dao.AdminContactDao;
import com.carshowroom.dao.AdminDao;
import com.carshowroom.model.Admin;
import com.carshowroom.model.AdminContact;

@Controller
public class ContactController {
	private AdminDao adminDao;
	private AdminContactDao actDao;
	
	@Autowired
	public ContactController(AdminDao adminDao,AdminContactDao actDao) {
		this.adminDao = adminDao;
		this.actDao = actDao;
	}
	
	@Autowired
	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}
	
	@Autowired
	public void setAdminContactDao(AdminContactDao actDao) {
		this.actDao = actDao;
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
		m.addAttribute("admin", adm);
		m.addAttribute("admin", admin);
		m.addAttribute("admcontact", admcontact);
		return "admin/contact";
	}
}
