<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:import url="header.jsp">
	<c:param name="title" value="Model" />
</c:import>
<!-- Car Model Start -->
<div class="my-5">
	<div class="row m-auto" style="width: 90%">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a
					href="${pageContext.request.contextPath}/home">Home</a></li>
				<li class="breadcrumb-item active" aria-current="page">Car
					Company</li>
			</ol>
		</nav>
		<c:forEach var="car" items="${cars}">
			<div class="col-3">
				<div class="card p-4" style="width: 350px">
					<img
						src="${pageContext.request.contextPath}/assets/images/${car.carImage}"
						height="180px" class="card-img-top" alt="" />
					<div class="card-body">
						<h5 class="card-title fw-bolder">${car.carName}</h5>
						<p class="card-text text-black-50">${fn:substring(car.carDescription, 0, 80)}...</p>
						<div class="d-flex card-text justify-content-between">
							<p class="d-flex align-items-center gap-1">
								<img
									src="${pageContext.request.contextPath}/assets/images/calendar.png"
									width="20px" alt="" /> ${car.carYear}
							</p>
							<p class="d-flex align-items-center gap-1">
								<img
									src="${pageContext.request.contextPath}/assets/images/dollar.png"
									width="20px" alt="" /> $${car.carPrice }
							</p>
						</div>
						<a href="${pageContext.request.contextPath}/viewproduct/${car.id}"
							class="btn btn-outline-primary mt-1">View Product</a>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<!-- Car Model End -->
<c:import url="footer.jsp" />