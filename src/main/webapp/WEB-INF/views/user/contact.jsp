<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:import url="header.jsp">
	<c:param name="title" value="Contact" />
</c:import>
<div
	style="background-image: linear-gradient(45deg, #93a5cf 0%, #e4efe9 100%);">
	<div class="py-5">
		<div class="row m-auto" style="width: 90%">
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a
						href="${pageContext.request.contextPath}/home">Home</a></li>
					<li class="breadcrumb-item active" aria-current="page">Contact</li>
				</ol>
			</nav>
			<div class="w-50 mx-auto border p-3" style="background-color: #dee7ed; border-radius: 10px;">
				<h5 class="text-center fw-bold my-2">Get In Touch With Admins</h5>
				<form action="${pageContext.request.contextPath}/contact" method="post" class="p-5">
					<div class="">
						<input type="hidden" name="userId" value="${user.id}"/>
						<label for="email" class="form-label">Email</label> <input
							type="email" name="email" id="email" class="form-control input-bg"
							value="${user.email}" readonly />
					</div>
					<div class="my-3">
						<label for="message" class="form-label">Your Message</label>
						<textarea name="message" id="message" class="form-control input-bg"
							cols="30" rows="10"></textarea>
					</div>
					<button class="btn btn-primary">
						<i class="bi bi-send"></i> Send Message
					</button>
				</form>
			</div>
		</div>
	</div>
</div>
<c:import url="footer.jsp" />

