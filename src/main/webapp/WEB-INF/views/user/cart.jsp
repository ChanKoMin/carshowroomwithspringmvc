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
					href="${pageContext.request.contextPath}/">Home</a></li>
				<li class="breadcrumb-item active" aria-current="page">Cart</li>
			</ol>
		</nav>
		<div class="col-8">
			<table class="table">
				<thead>
					<tr>
						<th>Product</th>
						<th>Name</th>
						<th>Quantity</th>
						<th>Price</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><img
							src="${pageContext.request.contextPath}/assets/images/car-8.png"
							class="w-25" alt="" /></td>
						<td class="align-middle">Ford</td>
						<td class="align-middle">
							<div
								class="border rounded-4 w-75 text-center d-flex justify-content-around bg-primary align-items-center">
								<button class="btn text-white" id="decrement-btn">
									<i class="bi bi-dash"></i>
								</button>
								<div id="counter-value" class="mx-2 text-white">1</div>
								<button class="btn text-white" id="increment-btn">
									<i class="bi bi-plus"></i>
								</button>
							</div>
						</td>
						<td class="align-middle">$36,789</td>
						<td class="align-middle"><a href="#" class="btn btn-danger">Remove</a>
						</td>
					</tr>
					<tr>
						<td><img
							src="${pageContext.request.contextPath}/assets/images/car-7.png"
							class="w-25" alt="" /></td>
						<td class="align-middle">Honda</td>
						<td class="align-middle">
							<div
								class="border rounded-4 w-75 text-center d-flex justify-content-around bg-primary align-items-center">
								<button class="btn text-white" id="decrement-btn">
									<i class="bi bi-dash"></i>
								</button>
								<div id="counter-value" class="mx-2 text-white">1</div>
								<button class="btn text-white" id="increment-btn">
									<i class="bi bi-plus"></i>
								</button>
							</div>
						</td>
						<td class="align-middle">$26,789</td>
						<td class="align-middle"><a href="#" class="btn btn-danger">Remove</a>
						</td>
					</tr>
					<tr>
						<td><img
							src="${pageContext.request.contextPath}/assets/images/car-6.png"
							class="w-25" alt="" /></td>
						<td class="align-middle">Mercedes</td>
						<td class="align-middle">
							<div
								class="border rounded-4 w-75 text-center d-flex justify-content-around bg-primary align-items-center">
								<button class="btn text-white" id="decrement-btn">
									<i class="bi bi-dash"></i>
								</button>
								<div id="counter-value" class="mx-2 text-white">1</div>
								<button class="btn text-white" id="increment-btn">
									<i class="bi bi-plus"></i>
								</button>
							</div>
						</td>
						<td class="align-middle">$46,989</td>
						<td class="align-middle"><a href="#" class="btn btn-danger">Remove</a>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="col-1"></div>
		<div class="col-3">
			<table class="table">
				<thead>
					<tr>
						<th colspan="2" class="text-center">Cart Summary</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Ford x 1</td>
						<td class="text-end">36789</td>
					</tr>
					<tr>
						<td>Honda x 1</td>
						<td class="text-end">26789</td>
					</tr>
					<tr>
						<td>Mercedes x 1</td>
						<td class="text-end">46989</td>
					</tr>
					<tr>
						<td>Shipping</td>
						<td class="text-end">100</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td>Total</td>
						<td class="text-end">$110667</td>
					</tr>
				</tfoot>
			</table>
			<button id="checkoutBtn" type="submit"
				class="btn w-100 btn-primary text-uppercase">
				Proceed to checkout</button>
			<button id="clearBtn" type="submit"
				class="btn w-100 mt-2 btn-danger text-uppercase">
				clear cart</button>
		</div>
	</div>
</div>
<!-- Car Type End -->
<c:import url="footer.jsp" />
