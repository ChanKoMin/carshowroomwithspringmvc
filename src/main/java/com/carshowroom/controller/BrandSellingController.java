package com.carshowroom.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.carshowroom.dao.BrandDao;
import com.carshowroom.model.TopSellingBrand;

@RestController
@RequestMapping("/api")
public class BrandSellingController {
	@Autowired
	private BrandDao brandDao;
	
	private boolean isAuthenticated(HttpSession session) {
		return session != null && session.getAttribute("admin") != null;
	}
	
	@GetMapping("/top-selling-brands")
	public ResponseEntity<List<TopSellingBrand>> getTopSellingBrands(HttpSession session) {
        if (!isAuthenticated(session)) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
        List<TopSellingBrand> topSellingBrands = brandDao.getTopSellingBrands();
        return new ResponseEntity<>(topSellingBrands, HttpStatus.OK);
    }
//	public List<TopSellingBrand> getTopSellingBrands(HttpSession session){
//		if (!isAuthenticated(session)) {
//			return "redirect:/";
//		}
//		return brandDao.getTopSellingBrands();
//	}
}
