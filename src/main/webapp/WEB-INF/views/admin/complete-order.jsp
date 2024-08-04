<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<c:import url="header.jsp">
	<c:param name="title" value="Orders" />
</c:import>
<!-- Main Content Start -->
<div class="w-50 mx-auto">
	<div class="my-4 d-flex justify-content-between">
		<h3 class="fw-bold">Complete Orders</h3>
		<a href="${pageContext.request.contextPath}/orders"
			class="btn btn-primary">Pending Orders</a>
	</div>
	<!--<c:choose>
		<c:when test="${empty confirmedOrder}">
			<h1 class="text-center my-5">No completed orders to show.</h1>
		</c:when>
		<c:otherwise>
			<div class="input-group mb-3">
				<input type="text" class="form-control"
					placeholder="Search for a car" name="brand" /> <i
					class="input-group-text bi bi-search"></i>
			</div>-->
	<!-- <div class="my-5">
		<table class="table table-striped table-bordered">
			<thead>
				<tr>
					<th class="text-center align-middle">Image</th>
					<th class="text-center align-middle">Name</th>
					<th class="text-center align-middle">Customer's Email</th>
					<th class="text-center align-middle">Quantity</th>
					<th class="text-end">Price</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="item" items="${orderItemDetails}">
					<tr>
						<td class="text-center"><img
							src="${pageContext.request.contextPath}/assets/images/${item.carImage}"
							width="150px" alt="" /></td>
						<td class="text-center align-middle">${item.carName}</td>
						<td class="text-center align-middle">${item.userEmail}</td>
						<td class="text-center align-middle">${item.quantity}</td>
						<td class="text-end align-middle">$${item.totalPricePerItem}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>-->
	<table class="table table-striped table-bordered">
		<thead>
			<tr>
				<th class="text-center align-middle">Car Name</th>
				<th class="text-center align-middle">Quantity</th>
				<th class="text-end align-middle">Price</th>
				<th class="text-end align-middle">Total Price Per Item</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${orderItemDetails}">
				<tr>
					<td class="text-center align-middle">${item.carName}</td>
					<td class="text-center align-middle">${item.quantity}</td>
					<td class="text-end align-middle">$${item.price}</td>
					<td class="text-end align-middle">$${item.totalPricePerItem}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!--</c:otherwise>
	</c:choose>-->

<ul class="pagination justify-content-center">
	<li class="page-item"><a class="page-link" href="#">Previous</a></li>
	<li class="page-item"><a class="page-link" href="#">1</a></li>
	<li class="page-item"><a class="page-link" href="#">2</a></li>
	<li class="page-item"><a class="page-link" href="#">3</a></li>
	<li class="page-item"><a class="page-link" href="#">Next</a></li>
</ul>
</div>
<!-- Main Content End -->
<c:import url="footer.jsp" />