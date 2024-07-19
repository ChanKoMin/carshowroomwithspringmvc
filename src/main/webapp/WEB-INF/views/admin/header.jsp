<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>${param.title}</title>
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
</head>
<body>
	<div class="container-fluid">
		<!-- Nav Start -->
		<nav
			class="navbar position-sticky top-0 z-3 bg-body-tertiary container-fluid">
			<div class="container-fluid">
				<a class="navbar-brand"
					href="${pageContext.request.contextPath}/dashboard"> <img
					src="${pageContext.request.contextPath}/assets/images/logo.jpg"
					alt="Speedy Mortors" class="w-25" />
				</a>
				<div class="">
					<ul class="d-flex nav align-items-center">
						<li class="nav-item"><a
							class="nav-link text-black active link-primary"
							href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
						</li>
						<li class="nav-item"><a
							class="nav-link text-black link-primary"
							href="${pageContext.request.contextPath}/brands">Brands</a></li>
						<li class="nav-item"><a
							class="nav-link text-black link-primary"
							href="${pageContext.request.contextPath}/cars">Cars</a></li>
						<li class="nav-item"><a
							class="nav-link text-black link-primary"
							href="${pageContext.request.contextPath}/orders">Orders</a></li>
						<li class="nav-item"><a
							class="nav-link text-black link-primary"
							href="${pageContext.request.contextPath}/users">Users</a></li>
						<li class="nav-item"><a
							class="nav-link text-black link-primary"
							href="${pageContext.request.contextPath}/feedbacks">Feedbacks</a>
						</li>
						<li class="nav-item">
							<div class="dropdown">
								<button class="nav-link btn dropdown-toggle" type="button"
									data-bs-toggle="dropdown" aria-expanded="false">${admin.name}</button>
								<ul class="dropdown-menu">
									<li><a class="dropdown-item"
										href="${pageContext.request.contextPath}/admin-profile">View
											Profile</a></li>
									<li><a class="dropdown-item"
										href="${pageContext.request.contextPath}/logout">Logout</a></li>
								</ul>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</nav>
		<!-- Nav End -->