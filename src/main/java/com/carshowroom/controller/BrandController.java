package com.carshowroom.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.carshowroom.dao.AdminDao;
import com.carshowroom.dao.BrandDao;
import com.carshowroom.model.Admin;
import com.carshowroom.model.Brand;

@Controller
public class BrandController {
	private BrandDao brandDao;
	private AdminDao adminDao;

	@Autowired
	public BrandController(BrandDao brandDao, AdminDao adminDao) {
		this.brandDao = brandDao;
		this.adminDao = adminDao;
	}

	@Autowired
	public void setBrandDao(BrandDao brandDao) {
		this.brandDao = brandDao;
	}
	
	@Autowired
	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}

	@RequestMapping("/brands")
	public String showBrandPage(@RequestParam(name = "page", defaultValue = "1") int page,@RequestParam(name = "size", defaultValue = "5") int pageSize ,Model m) {
		List<Brand> brands = brandDao.findAll(page,pageSize);
		Admin admin = adminDao.showAdmin();
		int totalBrands = brandDao.brandCount();
		int totalPages = (int) Math.ceil((double)totalBrands / pageSize);
		m.addAttribute("brands", brands);
		m.addAttribute("admin", admin);
		m.addAttribute("currentPage", page);
		m.addAttribute("totalPages", totalPages);
        m.addAttribute("isEmpty", brands.isEmpty());
		return "admin/brands";
	}

	@RequestMapping("/add-brand")
	public String showAddBrandPage(Model m) {
		Admin admin = adminDao.showAdmin();
		m.addAttribute("brand", new Brand());
		m.addAttribute("admin", admin);
		return "admin/add-brand";
	}

	@PostMapping("/brand/save")
	public String saveBrand(@ModelAttribute("brand") @Valid Brand brand, BindingResult result, RedirectAttributes ra) {
		if(result.hasErrors()) {
			return "redirect:/add-brand";
		}
		brandDao.save(brand);
        ra.addFlashAttribute("createdSuccessfully", "Brand created successfully!");
		return "redirect:/brands";
	}

	@RequestMapping(value = "/edit-brand/{id}")
	public String showEditBrandPage(@PathVariable int id, Model m) {
		Brand brand = brandDao.findById(id);
		Admin admin = adminDao.showAdmin();
		m.addAttribute("admin", admin);
		m.addAttribute("brand",brand);
		return "admin/edit-brand";
	}
	
	@RequestMapping(value = "/brand/update", method = RequestMethod.POST)
    public String updateBrand(@ModelAttribute("brand") @Valid Brand brand, BindingResult result, RedirectAttributes ra) {
        if(result.hasErrors()) {
        	return "admin/edit-brand";
        }
		brandDao.update(brand);
        ra.addFlashAttribute("updatedSuccessfully", "Brand updated successfully!");
        return "redirect:/brands";
    }
	
	@RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
	public String delete(@PathVariable int id, RedirectAttributes ra) {
		brandDao.deleteById(id);
        ra.addFlashAttribute("deletedSuccessfully", "Brand deleted successfully!");
		return "redirect:/brands";
	}

}
