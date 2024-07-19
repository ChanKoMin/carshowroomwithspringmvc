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
		<a href="${pageContext.request.contextPath}/orders" class="btn btn-primary">Pending Orders</a>
	</div>
	<div class="input-group mb-3">
		<input type="text" class="form-control" placeholder="Search for a car"
			name="brand" /> <i class="input-group-text bi bi-search"></i>
	</div>
	<div class="my-5">
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
				<tr>
					<td class="text-center"><img
						src="${pageContext.request.contextPath}/assets/images/car-8.png"
						width="150px" alt="" /></td>
					<td class="text-center align-middle">Cheverolet</td>
					<td class="text-center align-middle">dof@zo.gt</td>
					<td class="text-center align-middle">3</td>
					<td class="text-end align-middle">$70000</td>
				</tr>
			</tbody>
		</table>
	</div>
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