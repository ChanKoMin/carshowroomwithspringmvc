package com.carshowroom.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.carshowroom.dao.AdminDao;
import com.carshowroom.dao.FeedbackDao;
import com.carshowroom.model.Admin;
import com.carshowroom.model.Feedback;

@Controller
public class FeedbackController {
	private FeedbackDao fbDao;
	private AdminDao adminDao;

	@Autowired
	public FeedbackController(FeedbackDao fbDao, AdminDao adminDao) {
		this.fbDao = fbDao;
		this.adminDao = adminDao;
	}

	@Autowired
	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}

	@RequestMapping("/feedbacks")
	public String showFeedbackPage(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "5") int pageSize, Model m) {
		List<Feedback> fbs = fbDao.findAll(page, pageSize);
		Admin admin = adminDao.showAdmin();
		int totalFbs = fbDao.fbCount();
		int totalPages = (int) Math.ceil((double) totalFbs / pageSize);
		m.addAttribute("fbs", fbs);
		m.addAttribute("admin", admin);
		m.addAttribute("currentPage", page);
		m.addAttribute("totalPages", totalPages);
		m.addAttribute("isEmpty", fbs.isEmpty());
		return "admin/feedbacks";
	}

}
