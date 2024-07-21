var script = document.createElement('script');
script.src = 'https://code.jquery.com/jquery-3.6.3.min.js'; // Check https://jquery.com/ for the current version
document.getElementsByTagName('head')[0].appendChild(script);

function addToCart(productId, productImage, productName, productPrice) {
	let cart = JSON.parse(localStorage.getItem('cart')) || [];

	let product = cart.find(item => item.id === productId);
	if (product) {
		product.quantity += productQuantity;
	} else {
		cart.push({
			id: productId,
			image: productImage,
			name: productName,
			price: productPrice,
			quantity: 1
		});
	}

	localStorage.setItem('cart', JSON.stringify(cart));
	updateCartCount();
	updateCartNav();
}

function updateCartCount() {
	let cart = JSON.parse(localStorage.getItem('cart')) || [];
	let totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
	document.getElementById('cart-count').innerText = totalItems;
}

function updateCartNav() {
	let cart = JSON.parse(localStorage.getItem('cart')) || [];

	$.ajax({
		url: '${pageContext.request.contextPath}/updateCartNav',
		method: 'POST',
		data: { cart: JSON.stringify(cart) },
		success: function(response) {
			$('#cart-nav').html(response);
		},
		error: function(xhr, status, error) {
			console.error('Error updating cart nav:', error);
		}
	});
}

$(document).ready(function() {
	updateCartCount();
	updateCartNav();
});
