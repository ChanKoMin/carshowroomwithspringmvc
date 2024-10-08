<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:import url="header.jsp">
	<c:param name="title" value="View Product" />
</c:import>
<!-- Product Details Start -->
<div class="" style="background-color: #e2e8f0">
	<div class="py-5">
		<div class="row m-auto" style="width: 90%">
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a
						href="${pageContext.request.contextPath}/home">Home</a></li>
					<li class="breadcrumb-item active" aria-current="page">Details
					</li>
				</ol>
			</nav>
			<!--<c:if test="${not empty createdSuccessfully}">
				<div class="alert alert-success alert-dismissible fade show"
					role="alert">
					<strong>${createdSuccessfully}</strong>
					<button type="button" class="btn-close" data-bs-dismiss="alert"
						aria-label="Close"></button>
				</div>
			</c:if>-->
			<div
				class="d-flex justify-content-between align-items-center shadow p-3 my-3">
				<h4 class="fw-bold">${car.carName }</h4>
				<div class="d-flex justify-content-between gap-2 align-items-center">
					<!-- <div
					class="border bg-primary px-2 rounded-4 text-center d-flex align-items-center">
					<button class="btn text-white" id="decrement-btn">
						<i class="bi bi-dash"></i>
					</button>
					<div id="counter-value" class="mx-2 text-white">1</div>
					<button class="btn text-white" id="increment-btn">
						<i class="bi bi-plus"></i>
					</button>
				</div>-->
					<form class="d-flex align-items-center"
						action="${pageContext.request.contextPath}/addToCart/${car.id}"
						method="post">
						<input type="hidden" name="userId" value="${user.id}"> <input
							type="hidden" name="carId" value="${car.id}"> <input
							type="hidden" id="quantity" name="quantity" min="1" value="1">
						<c:choose>
							<c:when test="${car.carAvailability == 'INSTOCK' }">
								<button class="btn btn-grad px-3" id="addToCart">Add To
									Cart</button>
							</c:when>
							<c:otherwise>
								<button class="btn btn-grad px-3 text-white" id="addToCart"
									disabled>Add To Cart</button>
							</c:otherwise>
						</c:choose>
					</form>
				</div>
			</div>
			<div class="d-flex my-5 justify-content-evenly">
				<div class="col-3">
					<img
						src="${pageContext.request.contextPath}/assets/images/${car.carImage}"
						class="img-fluid" alt="" />
				</div>
				<div class="col-6">
					<div class="card p-4"
						style="background-color: #e2e8f0; border: none">
						<h5 class="card-title fw-bold mb-4 text-center">Car
							Specification</h5>
						<div class="row">
							<div class="col-6">
								<div class="row">
									<div class="col-5 ms-3 fw-bold">Type</div>
									<div class="col-5 text-end fw-bold">${car.carType}</div>
								</div>
								<div class="row my-4">
									<div class="col-5 ms-3 fw-bold">Cylinder</div>
									<div class="col-5 text-end fw-bold">${car.carCylinder}</div>
								</div>
								<div class="row my-4">
									<div class="col-5 ms-3 fw-bold">Price</div>
									<div class="col-5 text-end fw-bold">$${car.carPrice}</div>
								</div>
								<div class="row">
									<div class="col-5 ms-3 fw-bold">Color</div>
									<div class="col-5 text-end fw-bold">${car.carColor}</div>
								</div>
								<div class="row my-4">
									<div class="col-5 ms-3 fw-bold">Stock</div>
									<div class="col-5 text-end fw-bold">${car.carAvailability}</div>
								</div>
							</div>
							<div class="col-6">
								<div class="row">
									<div class="col-5 ms-3 fw-bold">Model</div>
									<div class="col-5 text-end fw-bold">${car.carModel}</div>
								</div>
								<div class="row my-4">
									<div class="col-5 ms-3 fw-bold">Year</div>
									<div class="col-5 text-end fw-bold">${car.carYear}</div>
								</div>
								<div class="row">
									<div class="col-5 ms-3 fw-bold">Transmission</div>
									<div class="col-5 text-end fw-bold">${car.carTransmission}</div>
								</div>
								<div class="row my-4">
									<div class="col-5 ms-3 fw-bold">Engine</div>
									<div class="col-5 text-end fw-bold">${car.carEngine}</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- <div class="col-4"></div> -->
			</div>
			<div class="">
				<h5 class="fw-bold">Description</h5>
				<p class="text-secondary lh-lg">${car.carDescription}</p>
			</div>
			<div class="my-2">
				<h6 class="fw-bold">Related Cars</h6>
				<div class="row pt-2">
					<c:forEach var="relatedCar" items="${relatedCars}">
						<div class="col-3">
							<div class="card" style="width: 300px; padding: 20px; background-color: #e2e8f0">
								<img
									src="${pageContext.request.contextPath}/assets/images/${relatedCar.carImage}"
									class="mx-auto" width="170px" alt="...">
								<div class="card-body">
									<p class="card-text">${relatedCar.carName}</p>
									<a
										href="${pageContext.request.contextPath}/viewproduct/${relatedCar.id}"
										class="btn btn-primary">View Product</a>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Product Details End -->
<script>
window.onload = function() {
	var createdSuccessfully = "${createdSuccessfully}";
	if (createdSuccessfully !== "") {
		alert(createdSuccessfully);
	}
}
</script>
<c:import url="footer.jsp"></c:import>