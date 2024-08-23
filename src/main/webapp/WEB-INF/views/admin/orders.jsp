<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<c:import url="header.jsp">
	<c:param name="title" value="Orders" />
</c:import>
<!-- Main Content Start -->
<div style="background-color: #fafaf6; padding-top: 50px; padding-bottom: 380px;">
	<div class="w-50 mx-auto">
		<div class="my-4 d-flex justify-content-between">
			<h3 class="fw-bold">Orders</h3>
		</div>
		<c:choose>
			<c:when test="${isEmpty}">
				<div class="d-flex flex-column align-items-center justify-content-center" style="height: 615px;">
					<img alt="" width="170px"
						src="${pageContext.request.contextPath}/assets/images/received.png">
					<h2 class="text-center my-5">There
						is no Order here.</h2>
				</div>
			</c:when>
			<c:otherwise>
				<div class="input-group mb-3">
					<input type="text" class="form-control" id="searchInput"
						onkeyup="filterTable()" placeholder="Search for Car.."> <i
						class="input-group-text bi bi-search"></i>
				</div>
				<div class="my-5">
					<table class="table bg-light table-striped table-bordered"
						id="brandTable">
						<thead>
							<tr>
								<th class="text-center align-middle">Image</th>
								<th class="text-center align-middle">Name</th>
								<th class="text-center align-middle">Customer's Email</th>
								<th class="text-center align-middle">Quantity</th>
								<th class="text-end align-middle">Price</th>
								<th class="text-center align-middle">Status</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="order" items="${orderDetailsList}">
								<tr>
									<td class="text-center"><img
										src="${pageContext.request.contextPath}/assets/images/${order.carImage}"
										width="150px" alt="" /></td>
									<td class="text-center align-middle">${order.carName}</td>
									<td class="text-center align-middle">${order.userEmail}</td>
									<td class="text-center align-middle">${order.quantity}</td>
									<td class="text-end align-middle">$${order.totalPricePerItem}</td>
									<td class="text-center align-middle">
										<form
											action="${pageContext.request.contextPath}/update-order-status"
											method="post">
											<input type="hidden" name="orderId" value="${order.orderId}" />
											<select name="status" class="btn btn-primary"
												onchange="this.form.submit()">
												<option value="PENDING"
													<c:if test="${order.status == 'PENDING'}">selected</c:if>>Pending</option>
												<option value="COMPLETE"
													<c:if test="${order.status == 'COMPLETE'}">selected</c:if>>Confirm</option>
											</select>
										</form>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
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
<c:import url="footer.jsp" />