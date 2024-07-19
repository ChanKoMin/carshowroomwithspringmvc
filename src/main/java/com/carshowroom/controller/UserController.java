package com.carshowroom.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.carshowroom.dao.AdminDao;
import com.carshowroom.dao.BrandDao;
import com.carshowroom.dao.CarDao;
import com.carshowroom.dao.UserDao;
import com.carshowroom.model.Admin;
import com.carshowroom.model.Brand;
import com.carshowroom.model.Car;
import com.carshowroom.model.User;

@Controller
public class UserController {

	private UserDao userDao;
	private AdminDao adminDao;
	private BrandDao brandDao;
	private CarDao carDao;

	@Autowired
	public UserController(UserDao userDao, AdminDao adminDao, CarDao carDao, BrandDao brandDao) {
		this.userDao = userDao;
		this.adminDao = adminDao;
		this.carDao = carDao;
		this.brandDao = brandDao;
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

	@RequestMapping("/home")
	public String showHomePage(Model m) {
		List<Car> cars = carDao.findAll();
		List<Brand> brands = brandDao.findAll();
		List<String> carTypes = carDao.getAllCarTypes();
		m.addAttribute("cars", cars);
		m.addAttribute("brands", brands);
		m.addAttribute("carTypes", carTypes);
		return "index";
	}

	@RequestMapping("/car-company/{id}")
	public String showCarModelPage(@PathVariable int id, Model m) {
		List<Car> cars = carDao.findByBrandId(id);
		m.addAttribute("cars", cars);
		return "user/carmodel";
	}
	
	@RequestMapping("/cartype/{car}")
	public String showCarTypePage(@PathVariable("car") String car,Model m) {
		List<Car> cars = carDao.getCarByTypes(car);
		m.addAttribute("cars", cars);
		return "user/cartype";
	}
	
	@RequestMapping("/viewproduct/{id}")
	public String showViewProductPage(@PathVariable int id, Model m ) {
		Car car = carDao.findById(id);
		m.addAttribute("car", car);
		return "user/viewproduct";
	}
	
	@RequestMapping("/all-products")
	public String showAllProductPage(Model m) {
		List<Car> cars = carDao.findAll();
		m.addAttribute("cars", cars);
		return "user/allproducts";
	}
	
	@RequestMapping("/all-brands")
	public String showAllBrandPage(Model m) {
		List<Brand> brands = brandDao.findAll();
		m.addAttribute("brands", brands);
		return "user/allbrands";
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
