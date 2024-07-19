<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Register</title>
<link rel="icon"
	href="${pageContext.request.contextPath}/assets/images/logo.jpg" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap"
	rel="stylesheet" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/node_modules/bootstrap/dist/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/node_modules/bootstrap-icons/font/bootstrap-icons.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css" />
</head>
<body class="position-relative">
	<div class="w-25 border p-5 position-absolute"
		style="left: 720px; top: 50px">
		<div>
			<img src="${pageContext.request.contextPath}/assets/images/logo.jpg"
				class="logo d-block mx-auto" alt="" />
			<form:form modelAttribute="user"
				action="${pageContext.request.contextPath}/register" method="post">
				<div>
					<form:label path="name" for="name" class="form-label">Name</form:label>
					<form:input path="name" type="text" name="name" id="name"
						class="form-control" />
				</div>
				<div class="my-3">
					<form:label path="email" for="email" class="form-label">Email</form:label>
					<form:input path="email" type="email" name="email" id="email"
						class="form-control" />
				</div>
				<div class="my-3">
					<form:label path="password" for="password" class="form-label">Password</form:label>
					<form:input path="password" type="password" name="password"
						id="password" class="form-control" />
				</div>
				<div>
					<form:label path="contact_number" for="phone" class="form-label">Phone Number</form:label>
					<form:input path="contact_number" type="number" name="phone"
						id="phone" class="form-control" />
				</div>
				<div class="my-3">
					<form:label path="address" for="address" class="form-label">Address</form:label>
					<form:textarea path="address" name="address" id="address"
						class="form-control" cols="30" rows="5"></form:textarea>
				</div>
				<div class="my-3 d-none">
					<form:select class="form-select" path="role">
						<form:options items="${roles}" />
					</form:select>
				</div>
				<button type="submit"
					class="btn btn-primary my-3 text-uppercase w-100">
					Register</button>
				<div class="d-flex justify-content-between align-items-center">
					<a href="${pageContext.request.contextPath}/login"
						class="text-primary">Already have account?</a> <a
						href="${pageContext.request.contextPath}/"
						class="text-danger">Sign in</a>
				</div>
			</form:form>
		</div>
	</div>
</body>
</html>
