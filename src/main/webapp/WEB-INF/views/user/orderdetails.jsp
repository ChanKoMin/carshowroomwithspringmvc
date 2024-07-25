<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<c:import url="header.jsp">
	<c:param name="title" value="Order Details" />
</c:import>
<div class="my-5">
	<div class="row m-auto" style="width: 90%">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a
					href="${pageContext.request.contextPath}/home">Home</a></li>
				<li class="breadcrumb-item active" aria-current="page">Order
					Details</li>
			</ol>
		</nav>
		<div class="col-6 mt-3">
			<ul class="list-group list-group-horizontal mb-2">
				<li class="list-group-item w-25"><img
					src="${pageContext.request.contextPath}/assets/images/car-1.png"
					width="100px" alt="" /></li>
				<li
					class="list-group-item w-25 d-flex align-items-center justify-content-center text-center fw-bold">
					<p>Toyota</p>
				</li>
				<li
					class="list-group-item w-25 d-flex align-items-center justify-content-center text-center fw-bold">
					<p>1</p>
				</li>
				<li
					class="list-group-item w-25 d-flex align-items-center justify-content-center text-center fw-bold">
					<p>$30000</p>
				</li>
			</ul>
			<ul class="list-group list-group-horizontal mb-2">
				<li class="list-group-item w-25"><img
					src="${pageContext.request.contextPath}/assets/images/car-1.png"
					width="100px" alt="" /></li>
				<li
					class="list-group-item w-25 d-flex align-items-center justify-content-center text-center fw-bold">
					<p>Toyota</p>
				</li>
				<li
					class="list-group-item w-25 d-flex align-items-center justify-content-center text-center fw-bold">
					<p>1</p>
				</li>
				<li
					class="list-group-item w-25 d-flex align-items-center justify-content-center text-center fw-bold">
					<p>$30000</p>
				</li>
			</ul>
		</div>
		<div class="col-1 mt-3"></div>
		<div class="col-2 mt-3 border p-5">
			<h4 class="mb-3 fw-bold">Summary</h4>
			<div class="d-flex justify-content-between p-3">
				<p class="fw-bold">Total:</p>
				<p class="">$10000</p>
			</div>
			<button class="btn btn-primary w-100">Complete Order</button>
		</div>
		<div class="col-3 mt-3"></div>
	</div>
</div>

<c:import url="footer.jsp" />
