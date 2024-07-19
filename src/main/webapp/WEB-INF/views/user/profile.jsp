<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<c:import url="header.jsp">
	<c:param name="title" value="Profile" />
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
		<div class="w-75 mx-auto">
			<h5 class="text-center fw-bold mb-5">Edit Your Account Details</h5>
			<form action="${pageContext.request.contextPath}/logout" method="post" class="p-5">
				<div class="row">
					<div class="col-2"></div>
					<div class="col-5">
						<img
							src="${pageContext.request.contextPath}/assets/images/batman.jpg"
							class="profile w-50" alt="Profile" /> <input type="file"
							name="file" class="form-control mt-4 w-75" />
					</div>
					<div class="col-5">
						<div class="">
							<label for="name" class="form-label">Name</label> <input
								type="text" name="name" id="name" class="form-control"
								value="Bruce  Wayne" />
						</div>
						<div class="my-3">
							<label for="email" class="form-label">Email</label> <input
								type="email" name="email" id="email" class="form-control"
								value="batman@gmail.com" />
						</div>
						<div class="">
							<label for="password" class="form-label">Password</label> <input
								type="password" name="password" id="password"
								class="form-control" value="batman225" />
						</div>
						<div class="my-3">
							<label for="phonenumber" class="form-label">Phone Number</label>
							<input type="number" name="phonenumber" id="phonenumber"
								class="form-control" value="09792213808" />
						</div>
						<div class="">
							<label for="address" class="form-label">Address</label>
							<textarea name="address" class="form-control" id="address"
								cols="30" rows="5">
Yangon</textarea>
						</div>
						<div class="d-flex mt-3 justify-content-between">
							<button class="btn btn-primary">Save</button>
							<button class="btn btn-danger">Logout</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- Contact Start -->
<c:import url="footer.jsp"></c:import>