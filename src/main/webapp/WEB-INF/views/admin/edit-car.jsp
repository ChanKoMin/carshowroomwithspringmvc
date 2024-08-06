<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:import url="header.jsp">
	<c:param name="title" value="Edit Car" />
</c:import>
<nav aria-label="breadcrumb" class="container mt-5">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a
			href="${pageContext.request.contextPath}/cars">Cars</a></li>
		<li class="breadcrumb-item active" aria-current="page">Edit Car</li>
	</ol>
</nav>
<!-- Main Content Start -->
<div class="w-50 mx-auto">
	<div class="card p-5">
		<div class="body">
			<h5 class="card-title mb-3">Edit Car</h5>
			<form:form action="${pageContext.request.contextPath}/car/update" enctype="multipart/form-data"
				modelAttribute="car" method="post">
				<div class="row">
					<div class="col">
						<form:input path="id" type="hidden" />
						<form:input path="brandId" type="hidden" />
						<form:input path="carName" type="text"
							class="form-control" />
						<form:errors path="carName" cssClass="error"/>
					</div>
					<div class="col">
						<form:input path="carModel" type="text"
							class="form-control" />
						<form:errors path="carModel" cssClass="error"/>
					</div>
				</div>
				<div class="row my-4">
					<div class="col">
						<form:input path="carType" type="text"
							class="form-control" />
						<form:errors path="carType" cssClass="error"/>
					</div>
					<div class="col">
						<form:input path="carYear" type="text"
							class="form-control" />
						<form:errors path="carYear" cssClass="error"/>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<form:input path="carColor" type="text"
							class="form-control" />
						<form:errors path="carColor" cssClass="error"/>
					</div>
					<div class="col">
						<form:input path="carCylinder" type="text"
							class="form-control" />
						<form:errors path="carCylinder" cssClass="error"/>
					</div>
				</div>
				<div class="row my-4">
					<div class="col">
						<form:input path="carEngine" type="text"
							class="form-control" />
						<form:errors path="carEngine" cssClass="error"/>
					</div>
					<div class="col">
						<form:select path="carTransmission" class="form-select">
							<form:options items="${carTransmissions}"/>
						</form:select>
					</div>
				</div>
				<div class="row my-4">
					<div class="col">
						<form:input path="carPrice" type="text"
							class="form-control" />
						<form:errors path="carPrice" cssClass="error"/>
					</div>
					<div class="col">
						<form:select path="carAvailability" class="form-select">
							<form:options items="${carAvailabilitys}"/>
						</form:select>
					</div>
				</div>
				<div class="row my-4">
					<div class="col">
						<form:textarea path="carDescription" class="form-control"
							cols="30" rows="5" />
						<form:errors path="carDescription" cssClass="error"/>
					</div>
				</div>
				<div class="row mb-4">
					<div class="col">
						<form:input path="carImage" type="file"
							class="form-control"/>
						<c:if test="${not empty message}">
							<span class="error">${message}</span>
						</c:if>
					</div>
				</div>
				<button class="btn btn-primary">Update</button>
			</form:form>
		</div>
	</div>
</div>
<!-- Main Content End -->
<c:import url="footer.jsp"></c:import>