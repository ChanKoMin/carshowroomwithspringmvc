package com.carshowroom.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.carshowroom.dao.AdminDao;
import com.carshowroom.dao.BrandDao;
import com.carshowroom.dao.CarDao;
import com.carshowroom.dao.FeedbackDao;
import com.carshowroom.dao.UserDao;
import com.carshowroom.model.Admin;
import com.carshowroom.model.Brand;
import com.carshowroom.model.Car;
import com.carshowroom.model.Feedback;
import com.carshowroom.model.Rate;
import com.carshowroom.model.User;

@Controller
public class UserController {

	private UserDao userDao;
	private AdminDao adminDao;
	private BrandDao brandDao;
	private CarDao carDao;
	private FeedbackDao fbDao;

	@Autowired
	public UserController(UserDao userDao, AdminDao adminDao, CarDao carDao, BrandDao brandDao, FeedbackDao fbDao) {
		this.userDao = userDao;
		this.adminDao = adminDao;
		this.carDao = carDao;
		this.brandDao = brandDao;
		this.fbDao = fbDao;
	}

	@Autowired
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	@Autowired
	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}

	@Autowired
	public void setCarDao(CarDao carDao) {
		this.carDao = carDao;
	}

	@Autowired
	public void setBrandDao(BrandDao brandDao) {
		this.brandDao = brandDao;
	}
	
	@Autowired
	public void setFeedbackDao(FeedbackDao fbDao) {
		this.fbDao = fbDao;
	}

	private boolean isAuthenticated(HttpSession session) {
		return session != null && session.getAttribute("user") != null;
	}

	@RequestMapping("/home")
	public String showHomePage(Model m, HttpSession session, RedirectAttributes ra) {
		if (!isAuthenticated(session)) {
			ra.addFlashAttribute("message", "Please login first.");
			return "redirect:/";
		}
		User user = (User) session.getAttribute("user");
		m.addAttribute("user", user);
		List<Car> cars = carDao.findAll();
		List<Brand> brands = brandDao.findAll();
		List<String> carTypes = carDao.getAllCarTypes();
		m.addAttribute("cars", cars);
		m.addAttribute("brands", brands);
		m.addAttribute("carTypes", carTypes);
		return "index";
	}

	@RequestMapping("/car-company/{id}")
	public String showCarModelPage(@PathVariable int id, Model m, HttpSession session, RedirectAttributes ra) {
		if (!isAuthenticated(session)) {
			ra.addFlashAttribute("message", "Please login first.");
			return "redirect:/";
		}
		User user = (User) session.getAttribute("user");
		m.addAttribute("user", user);
		List<Car> cars = carDao.findByBrandId(id);
		m.addAttribute("cars", cars);
		return "user/carmodel";
	}

	@RequestMapping("/cartype/{car}")
	public String showCarTypePage(@PathVariable("car") String car, Model m, HttpSession session,
			RedirectAttributes ra) {
		if (!isAuthenticated(session)) {
			ra.addFlashAttribute("message", "Please login first.");
			return "redirect:/";
		}
		User user = (User) session.getAttribute("user");
		m.addAttribute("user", user);
		List<Car> cars = carDao.getCarByTypes(car);
		m.addAttribute("cars", cars);
		return "user/cartype";
	}

	@RequestMapping("/viewproduct/{id}")
	public String showViewProductPage(@PathVariable int id, Model m, HttpSession session, RedirectAttributes ra) {
		if (!isAuthenticated(session)) {
			ra.addFlashAttribute("message", "Please login first.");
			return "redirect:/";
		}
		User user = (User) session.getAttribute("user");
		m.addAttribute("user", user);
		Car car = carDao.findById(id);
		m.addAttribute("car", car);
		return "user/viewproduct";
	}

	@RequestMapping("/all-products")
	public String showAllProductPage(Model m, HttpSession session, RedirectAttributes ra) {
		if (!isAuthenticated(session)) {
			ra.addFlashAttribute("message", "Please login first.");
			return "redirect:/";
		}
		User user = (User) session.getAttribute("user");
		m.addAttribute("user", user);
		List<Car> cars = carDao.findAll();
		m.addAttribute("cars", cars);
		return "user/allproducts";
	}

	@RequestMapping("/all-brands")
	public String showAllBrandPage(Model m, HttpSession session, RedirectAttributes ra) {
		if (!isAuthenticated(session)) {
			ra.addFlashAttribute("message", "Please login first.");
			return "redirect:/";
		}
		User user = (User) session.getAttribute("user");
		m.addAttribute("user", user);
		List<Brand> brands = brandDao.findAll();
		m.addAttribute("brands", brands);
		return "user/allbrands";
	}

	@RequestMapping("/profile")
	public String showProfilePage(Model m, HttpSession session, RedirectAttributes ra) {
		if (!isAuthenticated(session)) {
			ra.addFlashAttribute("message", "Please login first.");
			return "redirect:/";
		}
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/";
		}
		m.addAttribute("user", user);
		return "user/profile";
	}

	@PostMapping("/update-profile")
	public String updateProfile(@RequestParam("name") String name, @RequestParam("email") String email,
			@RequestParam("password") String password, @RequestParam("contact_number") String contact_number,
			@RequestParam("address") String address, @RequestParam("image") String image, HttpSession session,
			Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/";
		}
		user.setName(name);
		user.setEmail(email);
		user.setPassword(password);
		user.setContact_number(contact_number);
		user.setAddress(address);
		user.setImage(image);

		userDao.update(user); // Update the user in the database
		session.setAttribute("user", user); // Update the user in the session
		return "redirect:/profile"; // Redirect to the profile page or wherever appropriate
	}

	@PostMapping("/post-feedback")
	public String postFeedback(@RequestParam("description") String description,
			@RequestParam("rate") int rate, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if(user == null) {
			return "redirect:/";
		}
		Feedback fb = new Feedback();
		fb.setUserId(user.getId());
		fb.setDescription(description);
		fb.setRate(Rate.fromValue(rate));
		fbDao.save(fb);
		return "redirect:/home";
	}

	@RequestMapping("/users")
	public String showUserPage(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "5") int pageSize, Model m) {
		List<User> users = userDao.findAll(page, pageSize);
		Admin admin = adminDao.showAdmin();
		int totalUsers = userDao.userCount();
		int totalPages = (int) Math.ceil((double) totalUsers / pageSize);
		m.addAttribute("users", users);
		m.addAttribute("admin", admin);
		m.addAttribute("currentPage", page);
		m.addAttribute("totalPages", totalPages);
		m.addAttribute("isEmpty", users.isEmpty());
		return "admin/users";
	}
}
