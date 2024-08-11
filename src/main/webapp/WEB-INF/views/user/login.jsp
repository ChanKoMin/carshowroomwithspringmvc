<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Login</title>
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
<style>
.error {
	color: red;
}
</style>
</head>
<body class="position-relative bg-login">
	<div class="w-25 border p-5 position-absolute"
		style="left: 720px; top: 250px; background-color: #f1f5f9">
		<div>
			<img src="${pageContext.request.contextPath}/assets/images/logo.jpg"
				class="logo d-block mx-auto" alt="" />
			<h3 class="text-center fw-bold">Welcome!</h3>
			<form:form modelAttribute="admin"
				action="${pageContext.request.contextPath}/login" method="post">
				<div>
					<form:label path="email" for="email" class="form-label">Email</form:label>
					<form:input path="email" type="email" name="email" id="email"
						class="form-control" />
					<form:errors path="email" cssClass="error" />
				</div>
				<div class="my-3">
					<form:label path="password" for="password" class="form-label">Password</form:label>
					<form:input path="password" type="password" name="password"
						id="password" class="form-control" />
					<form:errors path="password" cssClass="error" />
				</div>
				<div class="d-flex justify-content-between align-items-center">
					<!-- <a href="index.html" class="btn btn-primary">Login</a> -->
					<button type="submit" class="btn btn-primary">Login</button>
					<a href="${pageContext.request.contextPath}/register"
						class="text-primary">Create An Account?</a>
				</div>
			</form:form>
		</div>
	</div>
</body>
</html>
