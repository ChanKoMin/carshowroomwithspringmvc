package com.carshowroom.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.carshowroom.dao.AdminDao;
import com.carshowroom.dao.BrandDao;
import com.carshowroom.dao.CarDao;
import com.carshowroom.model.Admin;
import com.carshowroom.model.Car;
import com.carshowroom.util.ImageUploadUtil;

@Controller
public class CarController {

	private CarDao carDao;
	private BrandDao brandDao;
	private AdminDao adminDao;
	private final String imageUploadDir = "Downloads/CarShowroomManagement/src/main/webapp/assets/images/";


	@Autowired
	public CarController(CarDao carDao, BrandDao brandDao, AdminDao adminDao) {
		this.carDao = carDao;
		this.brandDao = brandDao;
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
	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}

	private boolean isAuthenticated(HttpSession session) {
		return session != null && session.getAttribute("admin") != null;
	}

	@RequestMapping("/cars")
	public String showCarPage(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "5") int pageSize, Model m, HttpSession session) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		Admin adm = (Admin) session.getAttribute("admin");
		m.addAttribute("admin", adm);
		List<Car> cars = carDao.findAll(page, pageSize);
		Admin admin = adminDao.showAdmin();
		int totalCars = carDao.carCount();
		int totalPages = (int) Math.ceil((double) totalCars / pageSize);
		m.addAttribute("cars", cars);
		m.addAttribute("admin", admin);
		m.addAttribute("currentPage", page);
		m.addAttribute("totalPages", totalPages);
		m.addAttribute("isEmpty", cars.isEmpty());
		return "admin/cars";
	}

	@RequestMapping("/add-car")
	public String showAddCarPage(Model m, HttpSession session) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		Admin adm = (Admin) session.getAttribute("admin");
		m.addAttribute("admin", adm);
		Admin admin = adminDao.showAdmin();
		m.addAttribute("admin", admin);
		m.addAttribute("car", new Car());
		m.addAttribute("brands", brandDao.findAll());
		return "admin/add-car";
	}

	@RequestMapping(value = "/add-car/save", method = RequestMethod.POST)
	public String addCar(@RequestParam("carImage") MultipartFile carImage, @ModelAttribute("car") @Valid Car car, BindingResult result, RedirectAttributes ra, Model m,
			HttpSession session) {
//		if (result.hasErrors()) {
//			return "redirect:/add-car";
//		}
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		try {
			// Use the reusable method to save the image
			String fileName = ImageUploadUtil.saveImage(carImage, imageUploadDir);
			// Set the image name in the brand and save
			car.setCarImage(fileName);
			carDao.save(car);
			ra.addFlashAttribute("createdSuccessfully", "Car created successfully!");
			
		} catch (IOException e) {
			e.printStackTrace();
			m.addAttribute("message", "Failed to upload image: " + e.getMessage());
		}
		Admin adm = (Admin) session.getAttribute("admin");
		m.addAttribute("admin", adm);
//		carDao.save(car);
//		ra.addFlashAttribute("createdSuccessfully", "Car created successfully!");
		return "redirect:/cars";
	}

	@RequestMapping("/view-car/{id}")
	public String showViewCarPage(@PathVariable int id, Model m, HttpSession session) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		Admin adm = (Admin) session.getAttribute("admin");
		m.addAttribute("admin", adm);
		Car car = carDao.findById(id);
		Admin admin = adminDao.showAdmin();
		m.addAttribute("admin", admin);
		m.addAttribute("car", car);
		return "admin/view-car";
	}

	@RequestMapping("/edit-car/{id}")
	public String showEditCarPage(@PathVariable int id, Model m, HttpSession session) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		Admin adm = (Admin) session.getAttribute("admin");
		m.addAttribute("admin", adm);
		Car car = carDao.findById(id);
		Admin admin = adminDao.showAdmin();
		m.addAttribute("admin", admin);
		m.addAttribute("car", car);
		return "admin/edit-car";
	}

	@RequestMapping(value = "/car/update", method = RequestMethod.POST)
	public String updateCar(@RequestParam("carImage") MultipartFile carImage ,@ModelAttribute("car") @Valid Car car, BindingResult result, RedirectAttributes ra, Model m,
			HttpSession session) {
//		if (result.hasErrors()) {
//			return "admin/edit-car";
//		}
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		try {
			// Use the reusable method to save the image
			String fileName = ImageUploadUtil.saveImage(carImage, imageUploadDir);
			// Set the image name in the brand and save
			car.setCarImage(fileName);
			carDao.update(car);
			ra.addFlashAttribute("updatedSuccessfully", "Car updated successfully!");
			
		} catch (IOException e) {
			e.printStackTrace();
			m.addAttribute("message", "Failed to upload image: " + e.getMessage());
		}
		Admin adm = (Admin) session.getAttribute("admin");
		Admin admin = adminDao.showAdmin();
		m.addAttribute("admin", adm);
		m.addAttribute("admin", admin);
		return "redirect:/cars";
	}

	@GetMapping("/car-delete/{id}")
	public String delete(@PathVariable int id, RedirectAttributes ra, Model m, HttpSession session) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		try {
            // Fetch the brand to get the image file name
            Car car = carDao.findById(id);
            if (car != null) {
                // Delete the image file
                deleteImageFile(car.getCarImage());
                int orderCount = carDao.countOrdersByCarId(id);
    		    if (orderCount > 0) {
    		    	System.out.println("Cannot delete car.");
    		        ra.addFlashAttribute("message", "Cannot delete car. There are existing orders associated with this car.");
    		        return "redirect:/cars";
    		    }
                // Delete the brand record from the database
                carDao.deleteById(id);
                ra.addFlashAttribute("deletedSuccessfully", "Car deleted successfully!");
                
            } else {
                ra.addFlashAttribute("deletedSuccessfully", "Car not found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ra.addFlashAttribute("message", "Failed to delete car.");
        }
		Admin adm = (Admin) session.getAttribute("admin");
		m.addAttribute("admin", adm);
		return "redirect:/cars";
	}
	private void deleteImageFile(String fileName) {
        File file = new File(imageUploadDir + fileName);
        if (file.exists()) {
            file.delete();
        }
    }
}
