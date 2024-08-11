<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:import url="header.jsp">
	<c:param name="title" value="Profile" />
</c:import>
<!-- Contact Start -->
<div
	style="background-image: linear-gradient(45deg, #93a5cf 0%, #e4efe9 100%);">
	<div class="py-5">
		<div class="row m-auto" style="width: 90%">
			<div class="w-75 mx-auto">
				<h5 class="text-center fw-bold mb-5">Edit Your Account Details</h5>
				<form:form
					action="${pageContext.request.contextPath}/user-profile/update"
					enctype="multipart/form-data" modelAttribute="user" method="post"
					class="p-5">
					<div class="row">
						<div class="col-2"></div>
						<div class="col-5">
							<c:set var="defaultImage"
								value="${pageContext.request.contextPath}/assets/images/profile.png" />
							<c:choose>
								<c:when test="${not empty user.image}">
									<img class="profile" width="200px" height="200px"
										style="border-radius: 50%"
										src="${pageContext.request.contextPath}/assets/images/${user.image}"
										alt="${user.name}'s image" />
								</c:when>
								<c:otherwise>
									<img class="profile" width="200px" height="200px"
										src="${defaultImage}" alt="Default image" />
								</c:otherwise>
							</c:choose>
							<form:input path="image" type="file" name="image"
								class="form-control mt-4 w-75 input-bg" />
							<c:if test="${not empty message}">
								<span class="error">${message}</span>
							</c:if>
						</div>
						<div class="col-5">
							<div class="">
								<form:input path="id" type="hidden" />
								<form:label path="name" for="name" class="form-label">Name</form:label>
								<form:input path="name" type="text" name="name" id="name"
									class="form-control input-bg" />
								<form:errors path="name" cssClass="error" />
							</div>
							<div class="my-3">
								<form:label path="email" for="email" class="form-label">Email</form:label>
								<form:input path="email" type="email" name="email" id="email"
									class="form-control input-bg" />
								<form:errors path="email" cssClass="error" />
							</div>
							<div class="">
								<form:label path="password" for="password" class="form-label">Password</form:label>
								<form:input path="password" type="password" name="password"
									id="password" class="form-control input-bg" />
								<form:errors path="password" cssClass="error" />
							</div>
							<div class="my-3">
								<form:label path="contact_number" for="phonenumber"
									class="form-label">Phone Number</form:label>
								<form:input path="contact_number" type="number"
									name="phonenumber" id="phonenumber" class="form-control input-bg" />
								<form:errors path="contact_number" cssClass="error" />
							</div>
							<div class="">
								<form:label path="address" for="address" class="form-label">Address</form:label>
								<form:textarea path="address" name="address"
									class="form-control input-bg" id="address" cols="30" rows="5" />
								<form:input path="role" type="hidden" />
								<form:errors path="address" cssClass="error" />
							</div>
							<div class="d-flex mt-3 justify-content-between">
								<a href="${pageContext.request.contextPath}/profile"
									class="btn btn-danger">Cancel</a>
								<button class="btn btn-primary">Save</button>
							</div>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
</div>
<!-- Contact Start -->
<c:import url="footer.jsp"></c:import>