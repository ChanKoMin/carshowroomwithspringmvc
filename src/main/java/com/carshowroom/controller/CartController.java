package com.carshowroom.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.carshowroom.dao.CartDao;
import com.carshowroom.model.Admin;
import com.carshowroom.model.Car;
import com.carshowroom.model.Cart;
import com.carshowroom.model.CartItemDetails;
import com.carshowroom.model.User;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class CartController {

    @Autowired
    private CartDao cartDao;

    @PostMapping("/addToCart/{id}")
    public String addToCart(@RequestParam("carId") int carId, 
                            @RequestParam("quantity") int quantity, 
                            HttpSession session, RedirectAttributes ra, Model m) {
    	User user = (User) session.getAttribute("user");
    	if(user == null) {
    		return "redirect:/";
    	}
    	int userId = user.getId();
        Cart cart = new Cart();
        cart.setCarId(carId);
        cart.setUserId(userId);
        cart.setQuantity(quantity);
        
        if (cartDao.cartItemExists(userId, carId)) {
            cartDao.updateCartItem(cart);
        } else {
            cartDao.addCartItem(cart);
        }
        int cartCount = cartDao.getCartItemCount(userId);
		ra.addFlashAttribute("createdSuccessfully", "Item add to cart successfully!");
		ra.addAttribute("id", carId);
        session.setAttribute("cartCount", cartCount);
        return "redirect:/viewproduct/{id}";
    }

    @GetMapping("/cart")
    public String viewCart(HttpSession session, Model model) {
    	User user = (User) session.getAttribute("user");
    	if(user == null) {
    		return "redirect:/";
    	}
        int userId = user.getId();
        List<CartItemDetails> cartItems = cartDao.getCarsFromCart(userId);
        model.addAttribute("cartItems", cartItems);
        return "user/cart";
    }
    
    @GetMapping("/remove-item/{id}")
    public String removeCartItem(@PathVariable int id,HttpSession session, Model m) {
        System.out.println(id);
    	User user = (User) session.getAttribute("user");
    	if(user == null) {
    		return "redirect:/";
    	}
    	cartDao.deleteById(id);
    	return "redirect:/cart";
    }
    
    @RequestMapping("/cart/order")
    public String showOrderPage() {
    	return "user/orderdetails";
    }
    
}

