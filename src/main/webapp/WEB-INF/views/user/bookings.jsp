<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<c:import url="header.jsp">
	<c:param name="title" value="Bookings" />
</c:import>
<!-- Bookings Start -->
<div class="company-bg" style="padding-bottom: 270px">
	<div class="py-5">
		<div class="row m-auto" style="width: 90%">
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a
						href="${pageContext.request.contextPath}/home">Home</a></li>
					<li class="breadcrumb-item active" aria-current="page">
						Bookings</li>
				</ol>
			</nav>
			<c:if test="${not empty orderItemsDetails}">
				<div class="">
				<table class="table table-hover w-75 mx-auto">
					<thead>
						<tr>
							<th class="bg-black text-white text-center">Name</th>
							<th class="bg-black text-white text-center">Quantity</th>
							<th class="bg-black text-white text-center">Price</th>
							<th class="bg-black text-white text-end">Total Price</th>
							<th class="bg-black text-white text-center">Status</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="item" items="${orderItemsDetails}">
							<tr>
								<td class="text-center">${item.carName}</td>
								<td class="text-center">${item.quantity}</td>
								<td class="text-center">$ ${item.price}</td>
								<td class="text-end">$ ${item.totalPricePerItem}</td>
								<c:if test="${item.status == 'PENDING'}">
									<td class="text-warning text-center"><i
										class="bi bi-hourglass-split"></i> ${item.status}</td>
								</c:if>
								<c:if test="${item.status == 'COMPLETE'}">
									<td class="text-success text-center"><i
										class="bi bi-check2"></i> ${item.status}</td>
								</c:if>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			</c:if>
			<c:if test="${empty orderItemsDetails}">
				<div class="d-flex flex-column align-items-center mt-5">
					<img alt="" class="" width="200px" src="${pageContext.request.contextPath}/assets/images/book-now.png">
					<p>You don't have a booking here, make a reservation today!</p>
					<a href="${pageContext.request.contextPath}/home" class="btn btn-primary text-uppercase">Book Now</a>
				</div>
			</c:if>
		</div>
	</div>
</div>
<!-- Bookings End -->
<c:import url="footer.jsp" />
