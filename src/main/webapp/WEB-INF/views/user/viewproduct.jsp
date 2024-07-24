<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<c:import url="header.jsp">
	<c:param name="title" value="View Product" />
</c:import>
<!-- Product Details Start -->
<div class="my-5">
	<div class="row m-auto" style="width: 90%">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a
					href="${pageContext.request.contextPath}/home">Home</a></li>
				<li class="breadcrumb-item active" aria-current="page">Details
				</li>
			</ol>
		</nav>
		<div
			class="d-flex justify-content-between align-items-center shadow p-3 my-3">
			<h4 class="fw-bold">${car.carName }</h4>
			<div class="d-flex gap-2">
				<div
					class="border bg-primary rounded-5 px-4 text-center d-flex align-items-center">
					<button class="btn text-white" id="decrement-btn">
						<i class="bi bi-dash"></i>
					</button>
					<div id="counter-value" class="mx-2 text-white">1</div>
					<button class="btn text-white" id="increment-btn">
						<i class="bi bi-plus"></i>
					</button>
				</div>
				<button class="btn btn-primary" id="addToCart" onclick="addItemToDB(${car.id})">Add To Cart</button>
			</div>
		</div>
		<div class="d-flex my-5 justify-content-evenly">
			<div class="col-3">
				<img
					src="${pageContext.request.contextPath}/assets/images/${car.carImage}"
					class="img-fluid" alt="" />
			</div>
			<div class="col-5">
				<div class="card p-4">
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
	</div>
</div>
<!-- Product Details End -->
<script>

</script>
<c:import url="footer.jsp"></c:import>