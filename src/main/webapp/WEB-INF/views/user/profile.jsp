<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:import url="header.jsp">
	<c:param name="title" value="Profile" />
</c:import>
<c:choose>
	<c:when test="${not empty sessionScope.user}">
		<!-- Contact Start -->
		<div
			style="background-image: linear-gradient(45deg, #93a5cf 0%, #e4efe9 100%);">
			<div class="py-5">
				<div class="row m-auto" style="width: 90%">
					<nav aria-label="breadcrumb">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a
								href="${pageContext.request.contextPath}/home">Home</a></li>
							<li class="breadcrumb-item active" aria-current="page">Contact</li>
						</ol>
					</nav>
					<div class="w-75 mx-auto">
						<h5 class="text-center fw-bold mb-5">Edit Your Account
							Information</h5>
						<form action="${pageContext.request.contextPath}/update-profile"
							method="post" class="p-5">
							<div class="row">
								<div class="col-2"></div>
								<div class="col-5">
									<c:set var="defaultImage"
										value="${pageContext.request.contextPath}/assets/images/profile.png" />
									<c:choose>
										<c:when test="${not empty user.image}">
											<img class="profile w-50"
												src="${pageContext.request.contextPath}/assets/images/${user.image}"
												alt="${user.name}'s image" />
										</c:when>
										<c:otherwise>
											<img class="profile w-50" src="${defaultImage}"
												alt="Default image" />
										</c:otherwise>
									</c:choose>
									<input type="file" name="image" class="form-control mt-4 w-75 input-bg" />
								</div>
								<div class="col-5">
									<div class="">
										<input type="hidden" value="${user.id}" /> <label for="name"
											class="form-label">Name</label> <input type="text"
											name="name" id="name" value="${user.name}"
											class="form-control input-bg" />
									</div>
									<div class="my-3">
										<label for="email" class="form-label">Email</label> <input
											type="email" name="email" id="email" value="${user.email}"
											class="form-control input-bg" />
									</div>
									<div class="">
										<label for="password" class="form-label">Password</label> <input
											type="password" name="password" value="${user.password}"
											id="password" class="form-control input-bg" />
									</div>
									<div class="my-3">
										<label for="contact_number" class="form-label">Phone
											Number</label> <input type="number" value="${user.contact_number}"
											name="contact_number" id="contact_number"
											class="form-control input-bg" />
									</div>
									<div class="">
										<label for="address" class="form-label">Address</label>
										<textarea name="address" class="form-control input-bg" id="address"
											cols="30" rows="5" />${user.address}</textarea>
									</div>
									<div class="d-flex mt-3 justify-content-between">
										<button class="btn btn-primary">Save</button>
										<a href="${pageContext.request.contextPath}/logout"
											class="btn btn-danger">Logout</a>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- Contact Start -->
	</c:when>
	<c:otherwise>
		<c:redirect url="/login" />
	</c:otherwise>
</c:choose>
<c:import url="footer.jsp"></c:import>