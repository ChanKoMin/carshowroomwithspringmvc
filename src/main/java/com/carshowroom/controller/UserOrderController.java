package com.carshowroom.controller;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
    private CartDao cartDao;  // Assuming you have CartDao to fetch cart items

    @PostMapping("/order-now")
    public String orderNow(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if(user == null) {
        	return "redirect:/";
        }
        List<CartItemDetails> cartItems = cartDao.getCartItem(user.getId());        
        if (cartItems.isEmpty()) {
            model.addAttribute("message", "Your cart is empty.");
            return "cart";
        }
        
        
        
        int totalPrice = cartItems.stream()
                .mapToInt(item -> item.getCarPrice() * item.getQuantity())
                .sum();
        System.out.println(totalPrice);
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
        User user = (User) session.getAttribute("user");
        List<OrderItemDetails> orderItemsDetails = orderDao.getOrderItemsDetails(user.getId());
        model.addAttribute("orderItemsDetails", orderItemsDetails);
        return "user/bookings";
    }
}