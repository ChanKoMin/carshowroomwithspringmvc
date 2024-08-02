package com.carshowroom.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.carshowroom.dao.CartDao;
import com.carshowroom.model.Cart;
import com.carshowroom.model.CartItemDetails;
import com.carshowroom.model.User;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class CartController {

	@Autowired
	private CartDao cartDao;

	@Autowired
	public CartController(CartDao cartDao) {
		this.cartDao = cartDao;
	}

	@Autowired
	public void setCartDao(CartDao cartDao) {
		this.cartDao = cartDao;
	}

	@PostMapping("/addToCart/{id}")
	public String addToCart(@RequestParam("carId") int carId, @RequestParam("quantity") int quantity,
			HttpSession session, RedirectAttributes ra, Model m) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
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
		if (user == null) {
			return "redirect:/";
		}
		int userId = user.getId();
		List<CartItemDetails> cartItems = cartDao.getCarsFromCart(userId);
		model.addAttribute("cartItems", cartItems);
		// Calculate total price
		double totalPrice = calculateTotalPrice(cartItems);
		model.addAttribute("totalPrice", totalPrice);
		return "user/cart";
	}

	@GetMapping("/remove-item/{id}")
	public String removeCartItem(@PathVariable int id, HttpSession session, Model m) {
		System.out.println(id);
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/";
		}
		cartDao.deleteById(id);
		return "redirect:/cart";
	}

	@PostMapping("/update-cart-quantity")
	public String updateCartQuantity(@RequestParam("cartId") int cartId, @RequestParam("quantity") int quantity,
			@RequestParam("action") String action, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/";
		}

		// Adjust quantity based on action
		if ("increment".equals(action)) {
			quantity++;
		} else if ("decrement".equals(action) && quantity > 1) {
			quantity--;
		}

		// Update the quantity in the database
		cartDao.updateCartQuantity(cartId, quantity);

		// Retrieve updated cart items
		int userId = user.getId();
		List<CartItemDetails> cartItems = cartDao.getCarsFromCart(userId);
		model.addAttribute("cartItems", cartItems);

		// Calculate total price
		double totalPrice = calculateTotalPrice(cartItems);
		model.addAttribute("totalPrice", totalPrice);
		return "redirect:/cart";
	}

	private double calculateTotalPrice(List<CartItemDetails> cartItems) {
		return cartItems.stream().mapToDouble(item -> item.getCarPrice() * item.getQuantity()).sum();
		
	}

}
