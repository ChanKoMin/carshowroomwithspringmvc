<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<c:import url="header.jsp">
	<c:param name="title" value="Cart" />
</c:import>

<!-- Car Type Start -->
	<div class="py-5">
		<div class="row m-auto" style="width: 90%">
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a
						href="${pageContext.request.contextPath}/home">Home</a></li>
					<li class="breadcrumb-item active" aria-current="page">Cart</li>
				</ol>
			</nav>
			<div class="col-1"></div>
			<c:if test="${not empty message}">
				<div class="alert alert-danger alert-dismissible fade show"
					role="alert">
					<strong>${message}</strong>
					<button type="button" class="btn-close" data-bs-dismiss="alert"
						aria-label="Close"></button>
				</div>
			</c:if>
			<c:if test="${not empty cartItems}">
				<div class="col-10">
					<table class="table">
						<thead>
							<tr>
								<th>Product</th>
								<th>Name</th>
								<th>Quantity</th>
								<th class="text-end">Price</th>
								<th class="text-end">Action</th>
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
										<form
											class="border rounded-4 w-75 text-center d-flex justify-content-around bg-primary align-items-center"
											action="${pageContext.request.contextPath}/update-cart-quantity"
											method="post" class="d-inline">
											<input type="hidden" name="cartId" value="${car.cartId}" />
											<input type="hidden" name="carId" value="${car.carId}" /> <input
												type="hidden" name="quantity" value="${quantity}" />
											<button type="submit" class="btn text-white decrement-btn"
												name="action" value="decrement">
												<i class="bi bi-dash"></i>
											</button>
											<div class="counter-value mx-2 text-white d-inline">${quantity}</div>
											<button type="submit" class="btn text-white increment-btn"
												name="action" value="increment">
												<i class="bi bi-plus"></i>
											</button>
										</form>
									</td>
									<td class="align-middle text-end">$<span
										class="total-price">${price * quantity}</span> <input
										type="hidden" class="item-price" value="${price}" />
									</td>
									<td class="align-middle text-end"><a
										href="${pageContext.request.contextPath}/remove-item/${car.cartId}"
										class="btn btn-danger">Remove</a></td>
								</tr>
							</c:forEach>
							<tr>
								<td class="fw-bold">Total</td>
								<td colspan="3" class="align-middle text-end fw-bold">$
									${totalPrice}</td>
							</tr>
						</tbody>
					</table>
					<div class="my-3 d-flex justify-content-end">
						<form action="${pageContext.request.contextPath}/order-now"
							method="post">
							<c:forEach var="car" items="${cartItems}">
								<input type="hidden" name="cartItems[${car.cartId}].carId"
									value="${car.carId}" />
								<input type="hidden" name="cartItems[${car.cartId}].quantity"
									value="${car.quantity}" />
								<input type="hidden" name="cartItems[${car.cartId}].price"
									value="${car.carPrice}" />
							</c:forEach>
							<button type="submit" class="btn btn-primary">Order Now</button>
						</form>
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
<c:import url="footer.jsp" />
