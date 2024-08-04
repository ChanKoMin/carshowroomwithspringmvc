package com.carshowroom.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
	
	@GetMapping("/top-selling-brands")
	public List<TopSellingBrand> getTopSellingBrands(){
		return brandDao.getTopSellingBrands();
	}
}
