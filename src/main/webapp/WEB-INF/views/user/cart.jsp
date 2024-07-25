<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<c:import url="header.jsp">
	<c:param name="title" value="Cart" />
</c:import>

<!-- Car Type Start -->
<div class="my-5">
	<div class="row m-auto" style="width: 90%">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a
					href="${pageContext.request.contextPath}/home">Home</a></li>
				<li class="breadcrumb-item active" aria-current="page">Cart</li>
			</ol>
		</nav>
		<div class="col-1"></div>
		<c:if test="${not empty cartItems}">
			<div class="col-10">
				<table class="table">
					<thead>
						<tr>
							<th>Product</th>
							<th>Name</th>
							<th>Quantity</th>
							<th>Price</th>
							<th>Action</th>
							<th class="text-end fw-bold">Total</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="car" items="${cartItems}">
							<c:set var="quantity" value="${car.quantity}" />
							<c:set var="price" value="${car.carPrice}" />
							<tr>
								<td><img
									src="${pageContext.request.contextPath}/assets/images/${car.carImage}"
									class="w-25" alt="" /></td>
								<td class="align-middle">${car.carName}</td>
								<td class="align-middle">
									<div
										class="border rounded-4 w-75 text-center d-flex justify-content-around bg-primary align-items-center">
										<button class="btn text-white decrement-btn">
											<i class="bi bi-dash"></i>
										</button>
										<div class="counter-value mx-2 text-white">${quantity}</div>
										<button class="btn text-white increment-btn">
											<i class="bi bi-plus"></i>
										</button>
									</div>
								</td>
								<td class="align-middle">$<span class="total-price">${price * quantity}</span>
									<input type="hidden" class="item-price" value="${price}" />
								</td>
								<td class="align-middle"><a
									href="${pageContext.request.contextPath}/remove-item/${car.cartId}"
									class="btn btn-danger">Remove</a></td>
								<td rowspan="4" class="align-middle text-end fw-bold"><span
									id="cart-total"></span></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="my-3 d-flex justify-content-end">
					<a href="${pageContext.request.contextPath}/cart/order" class="btn btn-primary">Order</a>
				</div>
			</div>
		</c:if>
		<c:if test="${empty cartItems}">
			<h2 class="text-center">Your cart is empty.</h2>
		</c:if>
		<div class="col-1"></div>
	</div>
</div>
<!-- Car Type End -->
<script>
document.addEventListener('DOMContentLoaded', function () {
    const cartItems = document.querySelectorAll('tbody tr');
    const cartTotal = document.getElementById('cart-total');
    let total = 0;

    cartItems.forEach((item) => {
        const decrementBtn = item.querySelector('.decrement-btn');
        const incrementBtn = item.querySelector('.increment-btn');
        const counterValue = item.querySelector('.counter-value');
        const itemPrice = parseFloat(item.querySelector('.item-price').value);
        const totalPrice = item.querySelector('.total-price');
        let quantity = parseInt(counterValue.textContent);

        decrementBtn.addEventListener('click', function () {
            if (quantity > 1) {
                quantity--;
                counterValue.textContent = quantity;
                totalPrice.textContent = (itemPrice * quantity).toFixed(2);
                updateCartTotal();
            }
        });

        incrementBtn.addEventListener('click', function () {
            quantity++;
            counterValue.textContent = quantity;
            totalPrice.textContent = (itemPrice * quantity).toFixed(2);
            updateCartTotal();
        });

        total += itemPrice * quantity;
    });

    cartTotal.textContent = total.toFixed(2);

    function updateCartTotal() {
        let newTotal = 0;
        cartItems.forEach((item) => {
            const itemPrice = parseFloat(item.querySelector('.item-price').value);
            const quantity = parseInt(item.querySelector('.counter-value').textContent);
            newTotal += itemPrice * quantity;
        });
        cartTotal.textContent = newTotal.toFixed(2);
    }
});
</script>
<c:import url="footer.jsp" />