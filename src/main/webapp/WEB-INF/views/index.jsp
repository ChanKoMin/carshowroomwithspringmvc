<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:import url="user/header.jsp">
	<c:param name="title" value="Home" />
</c:import>
<c:choose>
	<c:when test="${not empty sessionScope.user}">
		<!-- Carousel Start -->
		<div id="carouselExampleAutoplaying" class="carousel slide"
			data-bs-ride="carousel">
			<div class="carousel-inner position-relative">
				<div class="carousel-item active">
					<img src="${pageContext.request.contextPath}/assets/images/2.jpg"
						class="d-block vh-100 w-100" alt="Carousel-1" />
				</div>
				<div class="carousel-item">
					<img src="${pageContext.request.contextPath}/assets/images/3.jpg"
						class="d-block vh-100 w-100" alt="Carousel-2" />
				</div>
				<div class="carousel-item">
					<img src="${pageContext.request.contextPath}/assets/images/4.jpg"
						class="d-block vh-100 w-100" alt="Carousel-3" />
				</div>
				<p id="multipleStrings"
					class="position-absolute border p-5 hero-content fw-bolder text-wrap w-50 text-center">

				</p>
				<a href="#explore"
					class="btn btn-lg position-absolute btn-explore hvr-float-shadow">
					<i class="bi bi-search"></i> Explore More
				</a>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
		<!-- Carousel End -->

		<!-- Explore by Car Type Start -->
		<div class="bg-gradient-color">
			<div class="w-75 m-auto py-5">
				<h2 class="text-center fw-bolder">Explore By Car Type</h2>
				<div data-aos="fade-up" class="row my-5">
					<c:forEach var="car" items="${carTypes}">
						<div class="col-3">
							<div class="cards mb-4 p-3">
								<div class="layer"></div>
								<div class="content">
									<div class="mb-2">
										<img width="150px" height="150px"
											src="${pageContext.request.contextPath}/assets/images/couple.svg"
											alt="">
									</div>
									<div class="details">
										<a href="${pageContext.request.contextPath}/cartype/${car}"
											class="btn btn-grad">${car}</a>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<!-- Explore by Car Type End -->

		<!-- Products Start -->
		<div class="pb-3 product-bg">
			<div class="py-3" id="explore">
				<div class="d-flex justify-content-around align-items-center">
					<h2 class="text-center fw-bolder">Products</h2>
					<c:if test="${fn:length(cars) > 8}">
						<div class="d-flex justify-content-center align-items-center">
							<a class="hvr-forward btn btn-view text-center p-3"
								href="${pageContext.request.contextPath}/all-products"><span
								class="me-1">View All</span> <img width="15px" height="15px"
								alt="" class="mb-1"
								src="${pageContext.request.contextPath}/assets/images/top-right.png">
							</a>
						</div>
					</c:if>
				</div>
				<div class="d-flex w-25 m-auto my-2">
					<input type="text" id="carSearch"
						placeholder="Search cars..." onkeyup="filterCars()"
						class="form-control form-control-lg">
				</div>
			</div>
			<div id="noResults" class="text-center my-255" style="display: none">No
				cars found for this search.</div>
			<div data-aos="fade-up" class="row m-auto my-5" style="width: 90%">
				<c:forEach var="car" items="${cars}" varStatus="status">
					<c:if test="${status.index < 8}">
						<div class="col-3">
							<div class="card p-4 mb-4 hvr-grow"
								style="width: 350px; background-color: #dee7ed">
								<img
									src="${pageContext.request.contextPath}/assets/images/${car.carImage}"
									height="180px" class="card-img-top" alt="" />
								<div class="card-body">
									<h5 class="card-title fw-bolder">${car.carName}</h5>
									<p class="card-text text-black-50">
										${fn:substring(car.carDescription, 0, 80)}...</p>
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
					</c:if>
				</c:forEach>
			</div>
		</div>
		<!-- Products End -->

		<!-- Explore by Company Start -->
		<div class="company-bg">
			<div class="py-5 w-75 m-auto">
				<div class="d-flex justify-content-between align-items-center">
					<h2 class="text-center fw-bolder">Explore By Company</h2>
					<c:if test="${fn:length(brands) > 8}">
						<div class="d-flex justify-content-center align-items-center">
							<a class="hvr-forward btn btn-view text-center p-3"
								href="${pageContext.request.contextPath}/all-brands"><span
								class="me-1">View All</span> <img width="15px" height="15px"
								alt="" class="mb-1"
								src="${pageContext.request.contextPath}/assets/images/top-right.png">
							</a>
						</div>
					</c:if>
				</div>
				<div class="d-flex w-25 m-auto my-5">
					<input type="text" id="brandSearch" placeholder="Search brands..."
						onkeyup="filterBrands()" class="form-control form-control-lg">
				</div>
				<div id="noBrandResults" class="text-center my-255"
					style="display: none">No brands found for this search.</div>
				<div data-aos="fade-up" class="row my-5">
					<c:forEach var="brand" items="${brands}" varStatus="status">
						<c:if test="${status.index < 8}">
							<div class="col-3 brand-card">
								<div class="card p-3 bg-body-secondary mb-4"
									style="width: 250px; background-color: #dee7ed">
									<img height="200px"
										src="${pageContext.request.contextPath}/assets/images/${brand.img}"
										alt="" />
									<div class="card-body text-center my-3">
										<a id="brandName"
											href="${pageContext.request.contextPath}/car-company/${brand.id}"
											class="btn btn-grad">${brand.name}</a>
									</div>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</div>
		<!-- Explore by Company End -->

		<!-- Feedback Start -->
		<div
			style="background-image: linear-gradient(45deg, #93a5cf 0%, #e4efe9 100%);">
			<div class="py-5">
				<div class="card pt-5 px-5 w-50 m-auto"
					style="background-color: #dee7ed">
					<h3 class="card-title text-center">We'd Like Your Feedback To
						Improve Our Website!</h3>
					<div class="card-body">
						<form action="${pageContext.request.contextPath}/post-feedback"
							method="post">
							<div class="mb-3">
								<input name="user_id" value="${user.id}" type="hidden" /> <label
									for="email" class="form-label">Email</label> <input
									type="email" name="email" id="email" value="${user.email}"
									readonly class="form-control input-bg" />
							</div>
							<div class="mb-3">
								<label for="description" class="form-label">Message</label>
								<textarea name="description" id="description"
									class="form-control input-bg" cols="30" rows="10" required></textarea>
							</div>
							<div class="">
								<div class="d-flex justify-content-between mb-0">
									<p>How would you rate our site?</p>
									<p id="output" class="fw-bold">0/5</p>
								</div>
								<div class="mb-3">
									<span onclick="giveFeedback(1)" class="star"><i
										class="bi bi-star star-size"></i></span> <span
										onclick="giveFeedback(2)" class="star ml"><i
										class="bi bi-star star-size"></i></span> <span
										onclick="giveFeedback(3)" class="star"><i
										class="bi bi-star star-size"></i></span> <span
										onclick="giveFeedback(4)" class="star"><i
										class="bi bi-star star-size"></i></span> <span
										onclick="giveFeedback(5)" class="star"><i
										class="bi bi-star star-size"></i></span>
								</div>
								<!-- Hidden input to store the rating value -->
								<input name="rate" type="hidden" id="rating" value="0" />
							</div>
							<button class="btn btn-primary mb-1 w-100">Submit
								Feedback</button>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- Feedback End -->
	</c:when>
	<c:otherwise>
		<c:redirect url="/" />
	</c:otherwise>
</c:choose>
<script src="${pageContext.request.contextPath}/assets/js/aos.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/index.umd.js"></script>
<script>

	// Animate On Scroll
	AOS.init();
	
	// Text Animation with typeit.js
	new TypeIt("#multipleStrings", {
		strings : [ "Revolutionize Your Car Shopping Experience.",
				"Explore Top Brands, Browse Extensive Inventory, and",
				"Drive Home Your Dream Car Today!" ],
		speed : 50,
		waitUntilVisible : true,
	}).go();
	
	// Feedback Form
	let stars = document.getElementsByClassName("star");
	let output = document.getElementById("output");
	function giveFeedback(n) {
		for (let i = 0; i < stars.length; i++) {
			stars[i].className = "star ml";
		}
		for (let i = 0; i < n; i++) {
			stars[i].className = "star text-warning ml";
		}
		output.innerText = n + "/5";
		document.getElementById("rating").value = n;
	}
	
	// Car Filter with input
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
	
	// Brand Filter with input
	function filterBrands() {
        const input = document.getElementById('brandSearch');
        const filter = input.value.toUpperCase();
        const cards = document.querySelectorAll('.brand-card');
        const noResults = document.getElementById('noBrandResults');
        let hasVisibleBrands = false;
        cards.forEach(card => {
            const brandNameElement = card.querySelector('.card-body a#brandName');
            const brandName = brandNameElement.textContent || brandNameElement.innerText;
            if (brandName.toUpperCase().indexOf(filter) > -1) {
                card.style.display = ''; 
                hasVisibleBrands = true;
            } else {
                card.style.display = 'none';
            }
            noResults.style.display = hasVisibleBrands ? 'none' : 'block';
        });      
    }
</script>
<c:import url="user/footer.jsp" />
