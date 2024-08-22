package com.carshowroom.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.carshowroom.dao.AdminDao;
import com.carshowroom.dao.CarDao;
import com.carshowroom.dao.OrderDao;
import com.carshowroom.model.Admin;
import com.carshowroom.model.AdminOrderDetails;
import com.carshowroom.model.Order;
import com.carshowroom.model.OrderItemDetails;

@Controller
public class OrderController {
	private AdminDao adminDao;
	private OrderDao orderDao;
	private CarDao carDao;

	@Autowired
	public OrderController(AdminDao adminDao,OrderDao orderDao,CarDao carDao) {
		this.adminDao = adminDao;
		this.orderDao = orderDao;
		this.carDao = carDao;
	}

	@Autowired
	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}
	
	@Autowired
	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}
	
	@Autowired
	public void setCarDao(CarDao carDao) {
		this.carDao = carDao;
	}
	
	private boolean isAuthenticated(HttpSession session) {
		return session != null && session.getAttribute("admin") != null;
	}

	@RequestMapping("/orders")
	public String showOrderPage(@RequestParam(name = "page", defaultValue = "1") int page,@RequestParam(name = "size", defaultValue = "5") int pageSize,HttpSession session,Model m) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		Admin admin = adminDao.showAdmin();
		List<AdminOrderDetails> orderDetailsList = orderDao.getOrderDetails(page, pageSize);
		int totalOrders = orderDao.orderCount();
		int totalPages = (int) Math.ceil((double) totalOrders / pageSize);
		int newOrderCount = orderDao.getNewOrderCount();
		m.addAttribute("newOrderCount", newOrderCount);
	    m.addAttribute("orderDetailsList", orderDetailsList);
		m.addAttribute("admin", admin);
		m.addAttribute("currentPage", page);
		m.addAttribute("totalPages", totalPages);
		m.addAttribute("isEmpty", orderDetailsList.isEmpty());
		return "admin/orders";
	}
	
	@PostMapping("/update-order-status")
	public String confirmOrder(@RequestParam("orderId") int orderId, Model model, @RequestParam("status") String status, HttpSession session) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		orderDao.updateOrderStatus(orderId, status);
	    return "redirect:/orders";
	}
	
	@GetMapping("/complete-orders/{id}")
    public String completeOrdersPage(@RequestParam(value = "orderId", required = false) Integer orderId, Model model, HttpSession session) {
		if (!isAuthenticated(session)) {
			return "redirect:/";
		}
		// Fetch all completed orders with their items
        Admin admin = adminDao.showAdmin();
        if(orderId != null) {
        	List<OrderItemDetails> orderItemDetails = orderDao.fetchOrderItemDetails(orderId);
            System.out.println(orderItemDetails.size());
            model.addAttribute("orderItemDetails", orderItemDetails);
        }       
		model.addAttribute("admin", admin);		
		return "admin/complete-order";
        
    }
}
