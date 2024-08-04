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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.carshowroom.dao.AdminDao;
import com.carshowroom.dao.OrderDao;
import com.carshowroom.model.Admin;
import com.carshowroom.model.AdminOrderDetails;
import com.carshowroom.model.OrderItemDetails;

@Controller
public class OrderController {
	private AdminDao adminDao;
	private OrderDao orderDao;

	@Autowired
	public OrderController(AdminDao adminDao,OrderDao orderDao) {
		this.adminDao = adminDao;
		this.orderDao = orderDao;
	}

	@Autowired
	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}
	
	@Autowired
	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}

	@RequestMapping("/orders")
	public String showOrderPage(@RequestParam(name = "page", defaultValue = "1") int page,@RequestParam(name = "size", defaultValue = "5") int pageSize,HttpSession session,Model m) {
		Admin admin = adminDao.showAdmin();
		List<AdminOrderDetails> orderDetailsList = orderDao.getOrderDetails(page, pageSize);
		int totalOrders = orderDao.orderCount();
		int totalPages = (int) Math.ceil((double) totalOrders / pageSize);
	    m.addAttribute("orderDetailsList", orderDetailsList);
		m.addAttribute("admin", admin);
		m.addAttribute("currentPage", page);
		m.addAttribute("totalPages", totalPages);
		m.addAttribute("isEmpty", orderDetailsList.isEmpty());
		return "admin/orders";
	}

//	@RequestMapping("/complete-order")
//	public String showCompleteOrderPage(Model m) {
//		Admin admin = adminDao.showAdmin();
//		m.addAttribute("admin", admin);
//		return "admin/complete-order";
//	}
	
	@PostMapping("/update-order-status")
	public String confirmOrder(@RequestParam("orderId") int orderId, Model model, @RequestParam("status") String status) {
	    orderDao.updateOrderStatus(orderId, status);

	    // Get the confirmed order details to pass to the complete-orders page
	    //AdminOrderDetails confirmedOrder = orderDao.getOrderDetailsById(orderId);
	    //System.out.println(confirmedOrder);
	    //model.addAttribute("confirmedOrder", confirmedOrder);
	    //ra.addAttribute("id", orderId);
	    // Redirect to the complete-orders page
	    return "redirect:/orders";
	}
	
	@GetMapping("/complete-orders/{id}")
    public String completeOrdersPage(@RequestParam(value = "orderId", required = false) Integer orderId, Model model) {
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
