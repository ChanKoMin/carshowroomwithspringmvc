<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<c:import url="header.jsp">
	<c:param name="title" value="Bookings" />
</c:import>
<!-- Bookings Start -->
<div class="my-5">
	<div class="row m-auto" style="width: 90%">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a
					href="${pageContext.request.contextPath}/">Home</a></li>
				<li class="breadcrumb-item active" aria-current="page">
					Bookings</li>
			</ol>
		</nav>
		<div class="">
			<table class="table table-hover w-75 mx-auto">
				<thead>
					<tr>
						<th class="bg-black text-white text-center">Name</th>
						<th class="bg-black text-white text-center">Date</th>
						<th class="bg-black text-white text-end">Total Price</th>
						<th class="bg-black text-white text-center">Status</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="text-center">Mercedes</td>
						<td class="text-center">April 8 2024</td>
						<td class="text-end">$90567</td>
						<td class="text-warning text-center"><i
							class="bi bi-hourglass-split"></i> Pending...</td>
					</tr>
					<tr>
						<td class="text-center">Ford</td>
						<td class="text-center">April 9 2024</td>
						<td class="text-end">$110667</td>
						<td class="text-success text-center"><i class="bi bi-check2"></i>
							Success...</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
<!-- Bookings End -->
<c:import url="footer.jsp"/>