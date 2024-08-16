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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.carshowroom.dao.AdminDao;
import com.carshowroom.dao.BrandDao;
import com.carshowroom.dao.OrderDao;
import com.carshowroom.model.Admin;
import com.carshowroom.model.Brand;
import com.carshowroom.util.ImageUploadUtil;

@Controller
public class BrandController {
	private BrandDao brandDao;
	private AdminDao adminDao;
	private OrderDao orderDao;
	private final String imageUploadDir = "Downloads/CarShowroomManagement/src/main/webapp/assets/images/";

	@Autowired
	public BrandController(BrandDao brandDao, AdminDao adminDao, OrderDao orderDao) {
		this.brandDao = brandDao;
		this.adminDao = adminDao;
		this.orderDao = orderDao;
	}

	@Autowired
	public void setBrandDao(BrandDao brandDao) {
		this.brandDao = brandDao;
	}

	@Autowired
	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}
	
	@Autowired
	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}

	private boolean isAuthenticated(HttpSession session) {
		return session != null && session.getAttribute("admin") != null;
	}

	@RequestMapping("/brands")
	public String showBrandPage(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "size", defaultValue = "5") int pageSize, Model m, HttpSession session) {
		List<Brand> brands = brandDao.findAll(page, pageSize);
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		Admin adm = (Admin) session.getAttribute("admin");
		m.addAttribute("admin", adm);
		Admin admin = adminDao.showAdmin();
		int totalBrands = brandDao.brandCount();
		int totalPages = (int) Math.ceil((double) totalBrands / pageSize);
		int newOrderCount = orderDao.getNewOrderCount();
		m.addAttribute("newOrderCount", newOrderCount);
		m.addAttribute("brands", brands);
		m.addAttribute("admin", admin);
		m.addAttribute("currentPage", page);
		m.addAttribute("totalPages", totalPages);
		m.addAttribute("isEmpty", brands.isEmpty());
		return "admin/brands";
	}

	@RequestMapping("/add-brand")
	public String showAddBrandPage(Model m, HttpSession session) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		Admin adm = (Admin) session.getAttribute("admin");
		m.addAttribute("admin", adm);
		Admin admin = adminDao.showAdmin();
		int newOrderCount = orderDao.getNewOrderCount();
		m.addAttribute("newOrderCount", newOrderCount);
		m.addAttribute("brand", new Brand());
		m.addAttribute("admin", admin);
		return "admin/add-brand";
	}

	@RequestMapping(value = "/brand/save", method = RequestMethod.POST)
	public String saveBrand(@RequestParam("img") MultipartFile img, @ModelAttribute("brand") @Valid Brand brand,
			BindingResult result, RedirectAttributes ra, Model m, HttpSession session) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}

		try {
			// Use the reusable method to save the image
			String fileName = ImageUploadUtil.saveImage(img, imageUploadDir);
			// Set the image name in the brand and save
			brand.setImg(fileName);
			brandDao.save(brand);
			ra.addFlashAttribute("createdSuccessfully", "Brand created successfully!");
			
		} catch (IOException e) {
			e.printStackTrace();
			m.addAttribute("message", "Failed to upload image: " + e.getMessage());
		}
		Admin adm = (Admin) session.getAttribute("admin");
		m.addAttribute("admin", adm);
		return "redirect:/brands";
	}

	@RequestMapping(value = "/edit-brand/{id}")
	public String showEditBrandPage(@PathVariable int id, Model m, HttpSession session) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		Admin adm = (Admin) session.getAttribute("admin");
		m.addAttribute("admin", adm);
		Brand brand = brandDao.findById(id);
		Admin admin = adminDao.showAdmin();
		int newOrderCount = orderDao.getNewOrderCount();
		m.addAttribute("newOrderCount", newOrderCount);
		m.addAttribute("admin", admin);
		m.addAttribute("brand", brand);
		return "admin/edit-brand";
	}

	@RequestMapping(value = "/brand/update", method = RequestMethod.POST)
	public String updateBrand(@RequestParam("img") MultipartFile img, @ModelAttribute("brand") @Valid Brand brand, BindingResult result, RedirectAttributes ra,
			Model m, HttpSession session) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		try {
			// Use the reusable method to save the image
			String fileName = ImageUploadUtil.saveImage(img, imageUploadDir);
			// Set the image name in the brand and save
			brand.setImg(fileName);
			brandDao.update(brand);
			ra.addFlashAttribute("updatedSuccessfully", "Brand updated successfully!");
			
		} catch (IOException e) {
			e.printStackTrace();
			m.addAttribute("message", "Failed to upload image: " + e.getMessage());
		}
		Admin adm = (Admin) session.getAttribute("admin");
		m.addAttribute("admin", adm);
		return "redirect:/brands";
	}

	@RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
	public String delete(@PathVariable("id") int id, RedirectAttributes ra, Model m, HttpSession session) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		try {
            // Fetch the brand to get the image file name
            Brand brand = brandDao.findById(id);
            if (brand != null) {
                // Delete the image file
                deleteImageFile(brand.getImg());

                // Delete the brand record from the database
                brandDao.deleteById(id);

                ra.addFlashAttribute("deletedSuccessfully", "Brand deleted successfully!");
            } else {
                ra.addFlashAttribute("deletedSuccessfully", "Brand not found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            ra.addFlashAttribute("message", "Failed to delete brand.");
        }
		Admin adm = (Admin) session.getAttribute("admin");
		m.addAttribute("admin", adm);
		return "redirect:/brands";
	}
	
	private void deleteImageFile(String fileName) {
        File file = new File(imageUploadDir + fileName);
        if (file.exists()) {
            file.delete();
        }
    }

}
