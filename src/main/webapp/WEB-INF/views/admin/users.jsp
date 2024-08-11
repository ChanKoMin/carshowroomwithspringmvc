<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<c:import url="header.jsp">
	<c:param name="title" value="Users" />
</c:import>
<!-- Main Content Start -->
<div style="background-color: #fafaf6; padding-top: 50px; padding-bottom: 380px;">
	<div class="w-50 mx-auto">
		<div class="my-4">
			<h3 class="fw-bold">Users</h3>
		</div>
		<c:choose>
			<c:when test="${isEmpty}">
				<h2 class="text-center my-5">There is no user.</h2>
			</c:when>
			<c:otherwise>
				<div class="input-group mb-3">
					<input type="text" class="form-control" id="searchInput"
						onkeyup="filterTable()" placeholder="Search Users"> <i
						class="input-group-text bi bi-search"></i>
				</div>
				<table class="table bg-light table-hover my-5" id="brandTable">
					<thead>
						<tr>
							<th class="py-3 text-center">Image</th>
							<th class="py-3 text-center">Name</th>
							<th class="py-3 text-center">Email</th>
							<th class="py-3 text-center">Phone</th>
							<th class="py-3 text-center">Address</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="user" items="${users}">
							<tr>
								<td class="text-center align-middle"><c:set
										var="defaultImage"
										value="${pageContext.request.contextPath}/assets/images/profile.png" />
									<c:choose>
										<c:when test="${not empty user.image}">
											<img style="border-radius: 50%" class="profile" width="50px"
												height="50px"
												src="${pageContext.request.contextPath}/assets/images/${user.image}"
												alt="${user.name}'s image" />
										</c:when>
										<c:otherwise>
											<img class="profile" width="50px" height="50px"
												src="${defaultImage}" alt="Default image" />
										</c:otherwise>
									</c:choose></td>
								<td class="text-center align-middle">${user.name}</td>
								<td class="text-center align-middle">${user.email}</td>
								<td class="text-center align-middle">${user.contact_number}</td>
								<td class="text-center align-middle">${user.address}</td>
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