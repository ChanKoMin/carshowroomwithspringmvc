<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:import url="header.jsp">
	<c:param name="title" value="Feedbacks" />
</c:import>
<!-- Main Content Start -->
<div class="w-50 mx-auto">
	<div class="my-4">
		<h3 class="fw-bold">Feedbacks</h3>
	</div>
	<c:choose>
		<c:when test="${isEmpty}">
			<h2 class="text-center my-5">There is no Data here, Insert Now.</h2>
		</c:when>
		<c:otherwise>
			<div class="input-group mb-3">
				<input type="text" class="form-control" id="searchInput"
					onkeyup="filterTable()" placeholder="Search for Feedbacks">
				<i class="input-group-text bi bi-search"></i>
			</div>
			<table class="table table-hover my-5" id="brandTable">
				<thead>
					<tr class="bg-dark">
						<th class="text-start">Feedbacks</th>
						<th class="text-center">Rating</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="fb" items="${fbs}">
						<tr class="feedback-row" data-description="${fb.description}"
							data-rating="${fb.rate}">
							<td class="align-middle">${fn:substring(fb.description, 0, 80)}...</td>
							<td class="text-center align-middle"><c:choose>
									<c:when test="${fb.rate == 'FIVE' }">
										<i class="bi bi-star text-success" style="font-size: large"></i>
										<i class="bi bi-star text-success" style="font-size: large"></i>
										<i class="bi bi-star text-success" style="font-size: large"></i>
										<i class="bi bi-star text-success" style="font-size: large"></i>
										<i class="bi bi-star text-success" style="font-size: large"></i>
									</c:when>
									<c:when test="${fb.rate == 'FOUR' }">
										<i class="bi bi-star text-warning" style="font-size: large"></i>
										<i class="bi bi-star text-warning" style="font-size: large"></i>
										<i class="bi bi-star text-warning" style="font-size: large"></i>
										<i class="bi bi-star text-warning" style="font-size: large"></i>
									</c:when>
									<c:when test="${fb.rate == 'THREE' }">
										<i class="bi bi-star text-warning" style="font-size: large"></i>
										<i class="bi bi-star text-warning" style="font-size: large"></i>
										<i class="bi bi-star text-warning" style="font-size: large"></i>
									</c:when>
									<c:when test="${fb.rate == 'TWO' }">
										<i class="bi bi-star text-danger" style="font-size: large"></i>
										<i class="bi bi-star text-danger" style="font-size: large"></i>
									</c:when>
									<c:when test="${fb.rate == 'ONE' }">
										<i class="bi bi-star text-danger" style="font-size: large"></i>
									</c:when>
								</c:choose></td>
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
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="myModalLabel">Review</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="modalBody"></div>
			<div class="modal-footer d-flex justify-content-between">
				<div>
					Rating : <span id="rate"></span>
				</div>
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<script>
	function filterTable() {
		var input, filter, table, tr, td, i, txtValue;
		input = document.getElementById("searchInput");
		filter = input.value.toLowerCase();
		table = document.getElementById("brandTable");
		tr = table.getElementsByTagName("tr");

		for (i = 0; i < tr.length; i++) {
			td = tr[i].getElementsByTagName("td")[0];
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
	document
			.addEventListener(
					"DOMContentLoaded",
					function() {
						let modal = new bootstrap.Modal(document
								.getElementById('myModal'));
						let tableRows = document
								.getElementsByClassName('feedback-row');

						Array
								.from(tableRows)
								.forEach(
										function(row) {
											row
													.addEventListener(
															'click',
															function() {
																let description = this
																		.getAttribute('data-description');
																let rate = this
																		.getAttribute('data-rating');
																document
																		.getElementById('modalBody').textContent = description;
																let ratingHtml = '';
																switch (rate) {
																case 'FIVE':
																	ratingHtml = '<i class="bi bi-star text-success" style="font-size: large"></i>'
																			.repeat(5);
																	break;
																case 'FOUR':
																	ratingHtml = '<i class="bi bi-star text-warning" style="font-size: large"></i>'
																			.repeat(4);
																	break;
																case 'THREE':
																	ratingHtml = '<i class="bi bi-star text-warning" style="font-size: large"></i>'
																			.repeat(3);
																	break;
																case 'TWO':
																	ratingHtml = '<i class="bi bi-star text-danger" style="font-size: large"></i>'
																			.repeat(2);
																	break;
																default:
																	ratingHtml = '<i class="bi bi-star text-danger" style="font-size: large"></i>';
																	break;
																}
																document
																		.getElementById('rate').innerHTML = ratingHtml;
																modal.show();
															});
										});
					});
</script>
<c:import url="footer.jsp"></c:import>