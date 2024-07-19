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
	href="${pageContext.request.contextPath}/assets/css/style.css" />
</head>
<body>
	<div class="container-fluid position-relative">
		<!-- Nav Start -->
    <nav class="navbar bg-body-tertiary position-fixed z-3 container-fluid">
      <div class="container-fluid">
        <a class="navbar-brand" href="">
          <img src="${pageContext.request.contextPath}/assets/images/logo.jpg" alt="Speedy Mortors" class="w-25" />
        </a>
        <div class="">
          <ul class="d-flex nav align-items-center">
            <li class="nav-item">
              <a class="nav-link text-black active" href="">Home</a>
            </li>
            <li class="nav-item">
              <a class="nav-link text-black" href="${pageContext.request.contextPath}/contact">Contact</a>
            </li>
            <li class="nav-item">
              <a class="btn btn-primary me-2" href="${pageContext.request.contextPath}/login"> Login </a>
            </li>
            <li class="nav-item">
              <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/register">
                Register
              </a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
    <!-- Nav End -->