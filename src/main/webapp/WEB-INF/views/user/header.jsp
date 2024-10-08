<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/aos.css" />
</head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/hover-min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css" />
</head>
<body class="d-flex flex-column h-100">
	<div class="container-fluid position-relative">
		<nav
			class="navbar bg-body-tertiary position-sticky z-3 top-0 container-fluid">
			<div class="container-fluid">
				<a class="navbar-brand"
					href="${pageContext.request.contextPath}/home"> <img
					src="${pageContext.request.contextPath}/assets/images/logo.jpg"
					alt="Speedy Mortors" class="w-25" />
				</a>
				<div class="">
					<ul class="d-flex nav align-items-center">
						<li class="nav-item hvr-float-shadow"><a
							class="nav-link text-black active d-flex justify-content-center align-items-end"
							href="${pageContext.request.contextPath}/home"><img
								style="margin-bottom: 6px; margin-right: 4px" alt="home"
								src="${pageContext.request.contextPath}/assets/images/home.png"
								width="25px" height="25px">Home</a></li>
						<li class="nav-item hvr-float-shadow"><a
							class="nav-link text-black d-flex justify-content-center align-items-end"
							href="${pageContext.request.contextPath}/bookings"><img
								style="margin-bottom: 4px; margin-right: 3px" alt="booking"
								src="${pageContext.request.contextPath}/assets/images/booking.png"
								width="25px" height="25px">Bookings</a></li>
						<li class="nav-item hvr-float-shadow"><a
							class="nav-link text-black d-flex justify-content-center align-items-end"
							href="${pageContext.request.contextPath}/contact"><img
								style="margin-bottom: 4px;" alt="contact"
								src="${pageContext.request.contextPath}/assets/images/telephone.png"
								width="25px" height="25px">Contact</a></li>
						<li class="nav-item hvr-float-shadow"><a
							class="nav-link text-black position-relative d-flex justify-content-center align-items-end"
							id="cart-link" href="${pageContext.request.contextPath}/cart">
								<img style="margin-bottom: 4px; margin-right: 1px" alt="cart"
								src="${pageContext.request.contextPath}/assets/images/trolley.png"
								width="25px" height="25px"> Cart <!--<c:if
									test="${sessionScope.cartCount > 0}">
									<p
										class="badge bg-danger rounded-5 position-absolute top-0 start-0"
										id="cart-count">
										<c:out value="${sessionScope.cartCount}" />
									</p>
								</c:if>-->
						</a></li>
						<li class="nav-item hvr-float-shadow"><a
							href="${pageContext.request.contextPath}/profile"
							class="nav-link"> <c:set var="defaultImage"
									value="${pageContext.request.contextPath}/assets/images/profile.png" />
								<c:choose>
									<c:when test="${not empty user.image}">
										<img class="profile border-1" width="50px" height="50px"
											src="${pageContext.request.contextPath}/assets/images/${user.image}"
											alt="${user.name}'s image" />
									</c:when>
									<c:otherwise>
										<img class="profile border-1" width="50px" height="50px"
											src="${defaultImage}" alt="Default image" />
									</c:otherwise>
								</c:choose>
						</a></li>
					</ul>
				</div>
			</div>
		</nav>