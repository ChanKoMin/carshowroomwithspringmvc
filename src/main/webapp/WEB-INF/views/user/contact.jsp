<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<c:import url="header.jsp">
	<c:param name="title" value="Contact" />
</c:import>

<!-- Contact Start -->
<div class="my-5">
	<div class="row m-auto" style="width: 90%">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a
					href="${pageContext.request.contextPath}/">Home</a></li>
				<li class="breadcrumb-item active" aria-current="page">Contact</li>
			</ol>
		</nav>
		<div class="w-50 mx-auto">
			<h5 class="text-center fw-bold my-2">Get In Touch With Admins</h5>
			<form action="" method="post" class="p-5">
				<div class="">
					<label for="email" class="form-label">Email</label> <input
						type="email" name="email" id="email" class="form-control"
						value="batman@gmail.com" readonly />
				</div>
				<div class="my-3">
					<label for="message" class="form-label">Your Message</label>
					<textarea name="message" id="message" class="form-control"
						cols="30" rows="10"></textarea>
				</div>
				<button class="btn btn-primary">
					<i class="bi bi-send"></i> Send Message
				</button>
			</form>
		</div>
	</div>
</div>
<!-- Contact Start -->
<c:import url="footer.jsp" />
