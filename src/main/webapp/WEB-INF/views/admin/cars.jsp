<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<c:import url="header.jsp">
	<c:param name="title" value="Cars" />
</c:import>
<!-- Main Content Start -->
<div class="w-50 mx-auto">
	<div class="d-flex justify-content-between align-items-center my-4">
		<h3 class="fw-bold">Manage Cars</h3>
		<a href="${pageContext.request.contextPath}/add-car"
			class="btn btn-primary">Add Car</a>
	</div>
	<c:if test="${not empty createdSuccessfully}">
		<div class="alert alert-success alert-dismissible fade show"
			role="alert">
			<strong>${createdSuccessfully}</strong>
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
	</c:if>
	<c:if test="${not empty updatedSuccessfully}">
		<div class="alert alert-success alert-dismissible fade show"
			role="alert">
			<strong>${updatedSuccessfully}</strong>
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
	</c:if>
	<c:if test="${not empty deletedSuccessfully}">
		<div class="alert alert-danger alert-dismissible fade show"
			role="alert">
			<strong>${deletedSuccessfully}</strong>
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
	</c:if>
	<c:if test="${not empty message}">
		<div class="alert alert-danger alert-dismissible fade show"
			role="alert">
			<strong>${message}</strong>
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
	</c:if>

	<c:choose>
		<c:when test="${isEmpty}">
			<h2 class="text-center my-5">There is no Data here, Insert Now.</h2>
		</c:when>
		<c:otherwise>
			<div class="input-group mb-3">
				<input type="text" class="form-control" id="searchInput"
					onkeyup="filterTable()" placeholder="Search for Car.."> <i
					class="input-group-text bi bi-search"></i>
			</div>
			<table class="table table-hover my-5" id="brandTable">
				<thead>
					<tr>
						<th class="text-center">Image</th>
						<th class="text-center">Name</th>
						<th class="text-center">Model</th>
						<th class="text-center">Color</th>
						<th class="text-end">Price</th>
						<th class="text-center">Action</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="car" items="${cars}">
						<tr>
							<td class="text-center align-middle"><img
								src="${pageContext.request.contextPath}/assets/images/${car.carImage}"
								height="60px" alt="" /></td>
							<td class="text-center align-middle">${car.carName}</td>
							<td class="text-center align-middle">${car.carModel}</td>
							<td class="text-center align-middle">${car.carColor}</td>
							<td class="text-end align-middle">$${car.carPrice}</td>
							<td class="text-center align-middle">
								<div class="d-flex gap-2">
									<a href="${pageContext.request.contextPath}/view-car/${car.id}"
										class="btn btn-sm btn-outline-secondary">View</a> <a
										href="edit-car/${car.id}" class="btn btn-sm btn-primary">Edit</a>
									<a href="car-delete/${car.id}" onclick="return confirm('Are you sure you want to delete this car?');" class="btn btn-sm btn-danger">
										Delete</a>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<c:if test="${totalPages > 1}">
				<ul class="pagination justify-content-center">
					<c:if test="${currentPage > 1}">
						<li class="page-item"><a class="page-link"
							href="?page=${currentPage - 1}&size=${pageSize}">Previous</a></li>
					</c:if>
					<c:forEach var="i" begin="1" end="${totalPages}">
						<c:choose>
							<c:when test="${i == currentPage}">
								<li class="page-item"><a class="page-link">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link"
									href="?page=${i}&size=${pageSize}">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${currentPage < totalPages}">
						<li class="page-item"><a class="page-link"
							href="?page=${currentPage + 1}&size=${pageSize}">Next</a></li>
					</c:if>
				</ul>
			</c:if>
		</c:otherwise>
	</c:choose>
</div>
<!-- Main Content End -->
<script>
	function filterTable() {
		var input, filter, table, tr, td, i, txtValue;
		input = document.getElementById("searchInput");
		filter = input.value.toLowerCase();
		table = document.getElementById("brandTable");
		tr = table.getElementsByTagName("tr");

		for (i = 0; i < tr.length; i++) {
			td = tr[i].getElementsByTagName("td")[1];
			if (td) {
				txtValue = td.textContent || td.innerText;
				if (txtValue.toLowerCase().indexOf(filter) > -1) {
					tr[i].style.display = "";
				} else {
					tr[i].style.display = "none";
				}
			}
		}
	}
</script>
<c:import url="footer.jsp"></c:import>