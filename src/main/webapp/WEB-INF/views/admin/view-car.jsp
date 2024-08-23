<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<c:import url="header.jsp">
	<c:param name="title" value="View Car" />
</c:import>
<div style="background-color: #f7f7f7; padding-top: 10px; padding-bottom: 50px;">
	<nav aria-label="breadcrumb" class="container mt-5">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a
				href="${pageContext.request.contextPath}/cars">Cars</a></li>
			<li class="breadcrumb-item active" aria-current="page">View Car</li>
		</ol>
	</nav>
	<!-- Main Content Start -->
	<div class="w-75 text-center mx-auto p-5">
		<img
			src="${pageContext.request.contextPath}/assets/images/${car.carImage}"
			class="w-50" alt="" />
		<div class="row">
			<div
				class="col-6 d-flex justify-content-between rounded align align-items-center border p-3">
				<h5 class="mb-0">Name</h5>
				<h5 class="mb-0">${car.carName}</h5>
			</div>			
			<div
				class="col-6 d-flex justify-content-between rounded align align-items-center border p-3">
				<h5 class="mb-0">Model</h5>
				<h5 class="mb-0">${car.carModel}</h5>
			</div>
		</div>
		<div class="row my-3">
			<div
				class="col-6 d-flex justify-content-between rounded align align-items-center border p-3">
				<h5 class="mb-0">Type</h5>
				<h5 class="mb-0">${car.carType}</h5>
			</div>
			
			<div
				class="col-6 d-flex justify-content-between rounded align align-items-center border p-3">
				<h5 class="mb-0">Year</h5>
				<h5 class="mb-0">${car.carYear}</h5>
			</div>
		</div>
		<div class="row">
			<div
				class="col-6 d-flex justify-content-between rounded align align-items-center border p-3">
				<h5 class="mb-0">Colour</h5>
				<h5 class="mb-0">${car.carColor}</h5>
			</div>
			<div
				class="col-6 d-flex justify-content-between rounded align align-items-center border p-3">
				<h5 class="mb-0">Cylinder</h5>
				<h5 class="mb-0">${car.carCylinder}</h5>
			</div>
		</div>
		<div class="row my-3">
			<div
				class="col-6 d-flex justify-content-between rounded align align-items-center border p-3">
				<h5 class="mb-0">Engine</h5>
				<h5 class="mb-0">${car.carEngine}</h5>
			</div>
			<div
				class="col-6 d-flex justify-content-between rounded align align-items-center border p-3">
				<h5 class="mb-0">Transmission</h5>
				<h5 class="mb-0">${car.carTransmission}</h5>
			</div>
		</div>
		<div class="row my-3">
			<div
				class="col-6 d-flex justify-content-between rounded align align-items-center border p-3">
				<h5 class="mb-0">Availability</h5>
				<h5 class="mb-0">${car.carAvailability}</h5>
			</div>
			<div
				class="col-6 d-flex justify-content-between rounded align align-items-center border p-3">
				<h5 class="mb-0">Price</h5>
				<h5 class="mb-0">$${car.carPrice}</h5>
			</div>
		</div>
		<div class="row my-3">
			<div
				class="col-12 d-flex justify-content-between rounded align align-items-center border p-3">
				<h5 class="mb-0">Current Inventory</h5>
				<h5 class="mb-0">${car.currentInventory}</h5>
			</div>
		</div>
		<div class="row my-3">
			<div class="col-12 rounded border p-3">
				<h5 class="mb-0 text-start">${car.carDescription}</h5>
			</div>
		</div>
	</div>
</div>
<!-- Main Content End -->
<c:import url="footer.jsp"></c:import>