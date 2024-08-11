<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:import url="header.jsp">
	<c:param name="title" value="All Products" />
</c:import>
<!-- Car Type Start -->
<div class="product-bg">
	<div class="py-5">
		<div class="row m-auto" style="width: 90%">
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a
						href="${pageContext.request.contextPath}/home">Home</a></li>
					<li class="breadcrumb-item active" aria-current="page">Cars</li>
				</ol>
			</nav>
			<div class="row d-flex justify-content-center align-items-center my-4">
				<div class="col-3 d-flex justify-content-start">
					<form action="${pageContext.request.contextPath}/all-products" method="get">
						<select class="form-select" name="filter"
							onchange="this.form.submit()">
							<option value="" ${empty param.filter ? 'selected' : ''}>Filter Cars</option>
							<option value="All" ${"All".equals(param.filter) ? 'selected' : ''}>All</option>
							<option value="INSTOCK" ${"INSTOCK".equals(param.filter) ? 'selected' : ''}>In Stock</option>
							<option value="New Cars" ${"New Cars".equals(param.filter) ? 'selected' : ''}>New Cars</option>
						</select>
					</form>
				</div>
				<div class="col-3"></div>
				<div class="col-3"></div>
				<div class="col-3 d-flex">
					<input style="margin-right: 25px" type="text" id="carSearch"
						placeholder="Search cars..." onkeyup="filterCars()"
						class="form-control form-control-lg">
				</div>
			</div>
			<div id="noResults" class="text-center my-255" style="display: none">No
				cars found for this search.</div>
			<c:forEach var="car" items="${cars}">
				<div class="col-3">
					<div class="card mb-4 p-4"
						style="width: 350px; background-color: #dee7ed">
						<img
							src="${pageContext.request.contextPath}/assets/images/${car.carImage}"
							height="180px" class="card-img-top" alt="" />
						<div class="card-body">
							<h5 class="card-title fw-bolder">${car.carName}</h5>
							<p class="card-text text-black-50">${fn:substring(car.carDescription, 0, 80)}...</p>
							<div class="d-flex card-text justify-content-between">
								<p class="d-flex align-items-center gap-1">
									<img
										src="${pageContext.request.contextPath}/assets/images/calendar.png"
										width="20px" alt="" /> ${car.carYear}
								</p>
								<p class="d-flex align-items-center gap-1">
									<img
										src="${pageContext.request.contextPath}/assets/images/dollar.png"
										width="20px" alt="" /> $${car.carPrice }
								</p>
							</div>
							<a
								href="${pageContext.request.contextPath}/viewproduct/${car.id}"
								class="btn btn-grade mt-1">View Product</a>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
<!-- Car Type End -->
<script>
//Car Filter with input
function filterCars() {
    const searchQuery = document.getElementById('carSearch').value.toLowerCase();
    const carCards = document.querySelectorAll('.card');
    let noResult = document.getElementById("noResults");
    let found = false;

    carCards.forEach(card => {
        const carName = card.querySelector('.card-title').innerText.toLowerCase();
        const carDescription = card.querySelector('.card-text').innerText.toLowerCase();

        if (carName.includes(searchQuery) || carDescription.includes(searchQuery)) {
            card.parentElement.style.display = 'block'; // Show the card 
            found = true;
        } else {
            card.parentElement.style.display = 'none'; // Hide the card
        }
        noResult.style.display = found ? 'none' : 'block';
    });       
}
</script>
<c:import url="footer.jsp" />
