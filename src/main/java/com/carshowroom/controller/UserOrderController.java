package com.carshowroom.controller;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import com.carshowroom.dao.CartDao;
import com.carshowroom.dao.OrderDao;
import com.carshowroom.model.CartItemDetails;
import com.carshowroom.model.Order;
import com.carshowroom.model.OrderItem;
import com.carshowroom.model.OrderItemDetails;
import com.carshowroom.model.User;

@Controller
public class UserOrderController {

    @Autowired
    private OrderDao orderDao;

    @Autowired
    private CartDao cartDao;
    
    private boolean isAuthenticated(HttpSession session) {
		return session != null && session.getAttribute("user") != null;
	}
    
    @PostMapping("/order-now")
    public String orderNow(HttpSession session,Model model) {
    	if (!isAuthenticated(session)) {
			return "redirect:/";
		}
        User user = (User) session.getAttribute("user");
        if(user == null) {
        	return "redirect:/";
        }
        
        List<CartItemDetails> cartItems = cartDao.getCartItem(user.getId());        
        if (cartItems.isEmpty()) {
            model.addAttribute("message", "Your cart is empty.");
            return "redirect:/cart";
        }
                       
        int totalPrice = cartItems.stream()
                .mapToInt(item -> item.getCarPrice() * item.getQuantity())
                .sum();
        Order order = new Order();
        order.setUserId(user.getId());
        order.setTotalPrice(totalPrice);
        order.setStatus("PENDING");

        int orderId = orderDao.createOrder(order);

        for (CartItemDetails item : cartItems) {
            OrderItem orderItem = new OrderItem();
            orderItem.setOrderId(orderId);
            orderItem.setCarId(item.getCarId());
            orderItem.setQuantity(item.getQuantity());
            orderItem.setPrice(item.getCarPrice());
            orderDao.addOrderItem(orderItem);
        }

        model.addAttribute("order", order);
        model.addAttribute("orderItems", cartItems);
        return "redirect:/bookings";
    }
    
    @GetMapping("/bookings")
    public String viewUserBookings(HttpSession session, Model model) {
    	if (!isAuthenticated(session)) {
			return "redirect:/";
		}
        User user = (User) session.getAttribute("user");
        List<OrderItemDetails> orderItemsDetails = orderDao.getOrderDetails(user.getId());
        model.addAttribute("orderItemsDetails", orderItemsDetails);
        return "user/bookings";
    }
}
