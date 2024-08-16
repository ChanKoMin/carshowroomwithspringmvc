package com.carshowroom.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.carshowroom.dao.AdminDao;
import com.carshowroom.dao.FeedbackDao;
import com.carshowroom.dao.OrderDao;
import com.carshowroom.model.Admin;
import com.carshowroom.model.Feedback;

@Controller
public class FeedbackController {
	private FeedbackDao fbDao;
	private AdminDao adminDao;
	private OrderDao orderDao;

	@Autowired
	public FeedbackController(FeedbackDao fbDao, AdminDao adminDao, OrderDao orderDao) {
		this.fbDao = fbDao;
		this.adminDao = adminDao;
		this.orderDao = orderDao;
	}

	@Autowired
	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}
	
	@Autowired
	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}
	
	@PostMapping("/feedback")
	public String saveFeedback(@ModelAttribute("feedback") Feedback feedback, Model m) {
		fbDao.save(feedback);
		return "redirect:/home";
	}
	
	private boolean isAuthenticated(HttpSession session) {
		return session != null && session.getAttribute("admin") != null;
	}

	@RequestMapping("/feedbacks")
	public String showFeedbackPage(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "5") int pageSize, Model m, HttpSession session) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		Admin adm = (Admin) session.getAttribute("admin");
		m.addAttribute("admin", adm);
		List<Feedback> fbs = fbDao.findAll(page, pageSize);
		Admin admin = adminDao.showAdmin();
		int totalFbs = fbDao.fbCount();
		int totalPages = (int) Math.ceil((double) totalFbs / pageSize);
		int newOrderCount = orderDao.getNewOrderCount();
		m.addAttribute("newOrderCount", newOrderCount);
		m.addAttribute("fbs", fbs);
		m.addAttribute("admin", admin);
		m.addAttribute("currentPage", page);
		m.addAttribute("totalPages", totalPages);
		m.addAttribute("isEmpty", fbs.isEmpty());
		return "admin/feedbacks";
	}

}
