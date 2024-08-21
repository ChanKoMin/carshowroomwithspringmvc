package com.carshowroom.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.carshowroom.dao.AdminContactDao;
import com.carshowroom.dao.AdminDao;
import com.carshowroom.dao.BrandDao;
import com.carshowroom.dao.CarDao;
import com.carshowroom.dao.FeedbackDao;
import com.carshowroom.dao.OrderDao;
import com.carshowroom.dao.UserDao;
import com.carshowroom.model.Admin;
import com.carshowroom.model.Brand;
import com.carshowroom.model.Car;
import com.carshowroom.model.Contact;
import com.carshowroom.model.Feedback;
import com.carshowroom.model.Rate;
import com.carshowroom.model.Testimonial;
import com.carshowroom.model.User;
import com.carshowroom.util.ImageUploadUtil;

@Controller
public class UserController {

	private UserDao userDao;
	private AdminDao adminDao;
	private BrandDao brandDao;
	private CarDao carDao;
	private FeedbackDao fbDao;
	private OrderDao orderDao;
	private AdminContactDao actDao;
	private final String imageUploadDir = "Downloads/CarShowroomManagement/src/main/webapp/assets/images/";

	@Autowired
	public UserController(UserDao userDao, AdminDao adminDao, CarDao carDao, BrandDao brandDao, FeedbackDao fbDao,OrderDao orderDao,AdminContactDao actDao) {
		this.userDao = userDao;
		this.adminDao = adminDao;
		this.carDao = carDao;
		this.brandDao = brandDao;
		this.fbDao = fbDao;
		this.orderDao = orderDao;
		this.actDao = actDao;
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
	
	@Autowired
	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}
	
	@Autowired
	public void setAdminContactDao(AdminContactDao actDao) {
		this.actDao = actDao;
	}

	private boolean isAuthenticated(HttpSession session) {
		return session != null && session.getAttribute("user") != null;
	}

	private boolean isAuthenticatedAdm(HttpSession session) {
		return session != null && session.getAttribute("admin") != null;
	}

	@RequestMapping("/home")
	public String showHomePage(Model m, HttpSession session, RedirectAttributes ra) {
		if (!isAuthenticated(session)) {
			ra.addFlashAttribute("message", "Please login first.");
			return "redirect:/";
		}
		User user = (User) session.getAttribute("user");
		int currentUserId = user.getId();
		m.addAttribute("user", user);
		List<Car> cars = carDao.findAll();
		List<Brand> brands = brandDao.findAll();
		List<String> carTypes = carDao.getAllCarTypes();
		List<Testimonial> testimonials = fbDao.showFeedbackOnUser(currentUserId);
		m.addAttribute("cars", cars);
		m.addAttribute("brands", brands);
		m.addAttribute("carTypes", carTypes);
		m.addAttribute("testimonials", testimonials);
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
		List<Car> relatedCars = carDao.relatedCars(car.getCarType(), car.getId());
		m.addAttribute("car", car);
		m.addAttribute("relatedCars", relatedCars);
		return "user/viewproduct";
	}

	@RequestMapping("/all-products")
	public String showAllProductPage(@RequestParam(value = "filter", required = false) String filter,Model m, HttpSession session, RedirectAttributes ra) {
		if (!isAuthenticated(session)) {
			ra.addFlashAttribute("message", "Please login first.");
			return "redirect:/";
		}
		User user = (User) session.getAttribute("user");
		m.addAttribute("user", user);
		List<Car> cars = carDao.findAll(filter);
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
	
	@RequestMapping("/contact")
	public String showContactPage(Model m, HttpSession session, RedirectAttributes ra) {
		if (!isAuthenticated(session)) {
			ra.addFlashAttribute("message", "Please login first.");
			return "redirect:/";
		}
		User user = (User) session.getAttribute("user");
		m.addAttribute("user", user);
		return "user/contact";
	}
	
	@PostMapping("/contact")
	public String postContact(@RequestParam("message") String message, HttpSession session, Model m) {
		User user = (User) session.getAttribute("user");
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		if (user == null) {
			return "redirect:/";
		}
		Contact contact = new Contact();
		contact.setUserId(user.getId());
		contact.setMessage(message);
		actDao.save(contact);
		return "redirect:/contact";
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
	
	@RequestMapping("/user-edit/{id}")
	public String showUserEditPage(@PathVariable int id, Model m, HttpSession session) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		User usr = (User) session.getAttribute("user");
		m.addAttribute("user", usr);
		User user = userDao.findById(id);
		m.addAttribute("user", user);
		return "user/edit-profile";
	}

	@PostMapping("/user-profile/update")
	public String updateProfile(@RequestParam("image") MultipartFile image ,@ModelAttribute("user") @Valid User user, BindingResult result,
			RedirectAttributes ra,Model m,HttpSession session) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		try {
			// Use the reusable method to save the image
			String fileName = ImageUploadUtil.saveImage(image, imageUploadDir);
			// Set the image name in the brand and save
			user.setImage(fileName);
			userDao.update(user);
			ra.addFlashAttribute("updatedSuccessfully", "Profile updated successfully!");
			
		} catch (IOException e) {
			e.printStackTrace();
			m.addAttribute("message", "Failed to upload image: " + e.getMessage());
		}
		session.setAttribute("user",user);
		//m.addAttribute("user", user);
		return "redirect:/profile";
	}

	@PostMapping("/post-feedback")
	public String postFeedback(@RequestParam("description") String description, @RequestParam("rate") int rate,
			HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		if (user == null) {
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
			@RequestParam(name = "size", defaultValue = "5") int pageSize, Model m, HttpSession session) {
		if (!isAuthenticatedAdm(session)) {
			return "redirect:/";
		}
		Admin adm = (Admin) session.getAttribute("admin");
		m.addAttribute("admin", adm);
		List<User> users = userDao.findAll(page, pageSize);
		Admin admin = adminDao.showAdmin();
		int totalUsers = userDao.userCount();
		int totalPages = (int) Math.ceil((double) totalUsers / pageSize);
		int newOrderCount = orderDao.getNewOrderCount();
		m.addAttribute("newOrderCount", newOrderCount);
		m.addAttribute("users", users);
		m.addAttribute("admin", admin);
		m.addAttribute("currentPage", page);
		m.addAttribute("totalPages", totalPages);
		m.addAttribute("isEmpty", users.isEmpty());
		return "admin/users";
	}
}
