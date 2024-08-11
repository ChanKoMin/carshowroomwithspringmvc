<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:import url="header.jsp">
	<c:param name="title" value="Profile" />
</c:import>
<!-- Contact Start -->
<div style="background-image: linear-gradient(45deg, #93a5cf 0%, #e4efe9 100%);">
	<div class="py-5">
		<div class="row m-auto" style="width: 90%">
			<div class="w-75 mx-auto">
				<h5 class="text-center fw-bold mb-5">Your Account Information
					Details</h5>
				<c:if test="${not empty updatedSuccessfully}">
					<div class="alert alert-success alert-dismissible fade show"
						role="alert">
						<strong>${updatedSuccessfully}</strong>
						<button type="button" class="btn-close" data-bs-dismiss="alert"
							aria-label="Close"></button>
					</div>
				</c:if>
				<div class="row">
					<div class="col-1"></div>
					<div class="col-5">
						<c:set var="defaultImage"
							value="${pageContext.request.contextPath}/assets/images/profile.png" />
						<c:choose>
							<c:when test="${not empty user.image}">
								<img class="profile" width="350px" height="350px"
									style="border-radius: 50%"
									src="${pageContext.request.contextPath}/assets/images/${user.image}"
									alt="${user.name}'s image" />
							</c:when>
							<c:otherwise>
								<img class="profile" width="350px" height="350px"
									src="${defaultImage}" alt="Default image" />
							</c:otherwise>
						</c:choose>
					</div>
					<div class="col-5">
						<div class="row">
							<div
								class="d-flex justify-content-between rounded align align-items-center border p-3">
								<h5 class="mb-0">Name</h5>
								<h5 class="mb-0">${user.name}</h5>
							</div>
						</div>
						<div class="row my-3">
							<div
								class="d-flex justify-content-between rounded align align-items-center border p-3">
								<h5 class="mb-0">Email</h5>
								<h5 class="mb-0">${user.email}</h5>
							</div>
						</div>
						<div class="row">
							<div
								class="d-flex justify-content-between rounded align align-items-center border p-3">
								<h5 class="mb-0">Password</h5>
								<h5 class="mb-0">${user.password}</h5>
							</div>
						</div>
						<div class="row my-3">
							<div
								class="d-flex justify-content-between rounded align align-items-center border p-3">
								<h5 class="mb-0">Phone</h5>
								<h5 class="mb-0">${user.contact_number}</h5>
							</div>
						</div>
						<div class="row">
							<div
								class="d-flex justify-content-between rounded align align-items-center border p-3">
								<h5 class="mb-0">Address</h5>
								<h5 class="mb-0">${user.address}</h5>
							</div>
						</div>
						<div class="row mt-3">
							<div class="d-flex justify-content-between">
								<a class="btn btn-primary"
									href="${pageContext.request.contextPath}/user-edit/${user.id}">Edit</a>
								<a href="${pageContext.request.contextPath}/logout"
									class="btn btn-danger">Logout</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Contact Start -->
<c:import url="footer.jsp"></c:import>