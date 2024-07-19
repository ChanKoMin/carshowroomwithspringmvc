<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:import url="header.jsp">
	<c:param name="title" value="Add Car" />
</c:import>
<nav aria-label="breadcrumb" class="container mt-5">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a
			href="${pageContext.request.contextPath}/cars">Cars</a></li>
		<li class="breadcrumb-item active" aria-current="page">Add Car</li>
	</ol>
</nav>
<!-- Main Content Start -->
<div class="w-50 mx-auto">
	<div class="card p-5">
		<div class="body">
			<form:form action="${pageContext.request.contextPath}/add-car/save"
				modelAttribute="car" method="post">
				<div class="row d-flex justify-content-between">
					<div class="col">
						<h5 class="card-title mb-3">Add New Car</h5>
						<form:select path="brandId" name="name" class="form-select">
							<option value="">Brand Name</option>
							<c:forEach var="brand" items="${brands}">
								<option value="${brand.id}">${brand.name}</option>
							</c:forEach>
						</form:select>
					</div>
				</div>
				<div class="row my-4">
					<div class="col">
						<form:input path="carName" type="text" name="name"
							class="form-control" placeholder="Name" />
						<form:errors path="carName" />
					</div>
					<div class="col">
						<form:input path="carModel" type="text" name="model"
							class="form-control" placeholder="Model" />
						<form:errors path="carModel" />
					</div>
				</div>
				<div class="row my-4">
					<div class="col">
						<form:input path="carType" type="text" name="type"
							class="form-control" placeholder="Type" />
						<form:errors path="carType" />
					</div>
					<div class="col">
						<form:input path="carYear" type="text" name="year"
							class="form-control" placeholder="Year" />
						<form:errors path="carYear" />
					</div>
				</div>
				<div class="row">
					<div class="col">
						<form:input path="carColor" type="text" name="colour"
							class="form-control" placeholder="Colour" />
						<form:errors path="carColor" />
					</div>
					<div class="col">
						<form:input path="carCylinder" type="text" name="cylinder"
							class="form-control" placeholder="Cylinder" />
						<form:errors path="carCylinder" />
					</div>
				</div>
				<div class="row my-4">
					<div class="col">
						<form:input path="carEngine" type="text" name="engine"
							class="form-control" placeholder="Engine" />
						<form:errors path="carEngine" />
					</div>
					<div class="col">
						<form:select path="carTransmission" name="transmission"
							class="form-select">
							<option value="">Transmission</option>
							<option value="AUTOMATIC">Automatic</option>
							<option value="MANUAL">Manual</option>
						</form:select>
					</div>
				</div>
				<div class="row my-4">
					<div class="col">
						<form:input path="carPrice" type="text" name="engine"
							class="form-control" placeholder="Price" />
						<form:errors path="carPrice" />
					</div>
					<div class="col">
						<form:select path="carAvailability" name="availability"
							class="form-select">
							<option value="">Availability</option>
							<option value="INSTOCK">In Stock</option>
							<option value="UNAVAILABLE">Out of Stock</option>
						</form:select>
					</div>
				</div>
				<div class="row my-4">
					<div class="col">
						<form:textarea path="carDescription" name="description"
							class="form-control" cols="30" rows="5" placeholder="Description"></form:textarea>
						<form:errors path="carDescription" />
					</div>
				</div>
				<div class="row mb-4">
					<div class="col">
						<form:input path="carImage" type="file" name="file"
							class="form-control" />
						<form:errors path="carImage" />
					</div>
				</div>
				<button class="btn btn-primary">Add</button>
			</form:form>
		</div>
	</div>
</div>
<!-- Main Content End -->
<c:import url="footer.jsp"></c:import>