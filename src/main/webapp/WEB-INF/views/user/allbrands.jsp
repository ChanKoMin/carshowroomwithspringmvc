<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:import url="header.jsp">
	<c:param name="title" value="All Products" />
</c:import>
<!-- Car Type Start -->
<div class="my-5">
	<div class="row w-75 m-auto" style="width: 90%">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a
					href="${pageContext.request.contextPath}/home">Home</a></li>
				<li class="breadcrumb-item active" aria-current="page">Company</li>
			</ol>
		</nav>
		<c:forEach var="brand" items="${brands}" varStatus="status">
			<div class="col-3">
				<div class="card p-3 bg-body-secondary mb-4" style="width: 250px">
					<img height="200px"
						src="${pageContext.request.contextPath}/assets/images/${brand.img}"
						alt="" />
					<div class="card-body text-center my-3">
						<a
							href="${pageContext.request.contextPath}/car-company/${brand.id}"
							class="btn btn-primary">${brand.name}</a>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<!-- Car Type End -->
<c:import url="footer.jsp" />
