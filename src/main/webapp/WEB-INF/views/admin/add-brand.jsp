<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:import url="header.jsp">
	<c:param name="title" value="Add New Brand" />
</c:import>
<!-- Main Content Start -->
<nav aria-label="breadcrumb" class="container mt-5">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a
			href="${pageContext.request.contextPath}/brands">Brands</a></li>
		<li class="breadcrumb-item active" aria-current="page">Add New
			Brand</li>
	</ol>
</nav>
<div class="w-50 mx-auto mt-5">
	<div class="card p-5">
		<div class="body">
			<h5 class="card-title mb-3">Add New Brand</h5>
			<c:if test="${not empty message}">
				<div class="alert alert-danger">
					<strong>${message}</strong>
				</div>
			</c:if>

			<form:form action="${pageContext.request.contextPath}/brand/save"
				enctype="multipart/form-data" method="post" modelAttribute="brand">
				<form:input path="name" type="text" class="form-control"
					placeholder="Brand Name"/>
				<form:errors path="name" cssClass="error" />
				<form:input path="img" type="file" class="form-control mt-4" />
				<c:if test="${not empty imageError}">
					<span class="error">${imageError}</span>
				</c:if>
				<div class="mt-3">
					<!-- <button class="btn btn-primary mb-0">Add</button> -->
					<input type="submit" value="Add" class="btn btn-primary" />
				</div>
			</form:form>
		</div>
	</div>
</div>
<!-- Main Content End -->
<c:import url="footer.jsp"></c:import>
