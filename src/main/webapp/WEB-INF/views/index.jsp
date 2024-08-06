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
		<div id="carouselExampleIndicators" class="carousel slide">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="0" class="active" aria-current="true"
					aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>
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
				<p
					class="position-absolute border p-5 hero-content fw-bolder text-wrap w-50 text-center">
					"Revolutionize Your Car Shopping Experience.<br /> Explore Top
					Brands, Browse Extensive Inventory, and<br /> Drive Home Your
					Dream Car Today!"
				</p>
				<a href="#explore"
					class="btn btn-lg btn-primary position-absolute btn-explore"> <i
					class="bi bi-search"></i> Explore More
				</a>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
		<!-- Carousel End -->

		<!-- Explore by Car Type Start -->
		<div class="my-5 w-75 m-auto">
			<h2 class="text-center fw-bolder">Explore By Car Type</h2>
			<div class="row my-5">
				<c:forEach var="car" items="${carTypes}">
					<div class="col-3">
						<div class="card mb-4 p-3 bg-body-secondary" style="width: 250px">
							<img
								src="${pageContext.request.contextPath}/assets/images/couple.svg"
								alt="" />
							<div class="card-body text-center my-3">
								<a href="${pageContext.request.contextPath}/cartype/${car}"
									class="btn btn-outline-primary">${car}</a>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<!-- Explore by Car Type End -->

		<!-- Products Start -->
		<div class="my-5" id="explore">
			<h2 class="text-center fw-bolder">Products</h2>
			<form class="d-flex w-25 m-auto my-5" role="search">
				<input class="form-control form-control-lg me-2" type="search"
					placeholder="Search" aria-label="Search" />
				<button class="btn btn-lg btn-primary" type="submit">Search</button>
			</form>
			<div class="row m-auto my-5" style="width: 90%">
				<c:forEach var="car" items="${cars}" varStatus="status">
					<c:if test="${status.index < 8}">
						<div class="col-3">
							<div class="card p-4 mb-4" style="width: 350px">
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
										class="btn btn-outline-primary mt-1">View Product</a>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
				<c:if test="${fn:length(cars) > 8}">
					<div class="d-flex justify-content-center">
						<a class="cta"
							href="${pageContext.request.contextPath}/all-products"> <span>View
								More</span> <span><svg width="46px" height="25px"
									viewBox="0 0 66 43" version="1.1"
									xmlns="http://www.w3.org/2000/svg"
									xmlns:xlink="http://www.w3.org/1999/xlink">
        <g id="arrow" stroke="none" stroke-width="1" fill="none"
										fill-rule="evenodd">
          <path class="one"
										d="M40.1543933,3.89485454 L43.9763149,0.139296592 C44.1708311,-0.0518420739 44.4826329,-0.0518571125 44.6771675,0.139262789 L65.6916134,20.7848311 C66.0855801,21.1718824 66.0911863,21.8050225 65.704135,22.1989893 C65.7000188,22.2031791 65.6958657,22.2073326 65.6916762,22.2114492 L44.677098,42.8607841 C44.4825957,43.0519059 44.1708242,43.0519358 43.9762853,42.8608513 L40.1545186,39.1069479 C39.9575152,38.9134427 39.9546793,38.5968729 40.1481845,38.3998695 C40.1502893,38.3977268 40.1524132,38.395603 40.1545562,38.3934985 L56.9937789,21.8567812 C57.1908028,21.6632968 57.193672,21.3467273 57.0001876,21.1497035 C56.9980647,21.1475418 56.9959223,21.1453995 56.9937605,21.1432767 L40.1545208,4.60825197 C39.9574869,4.41477773 39.9546013,4.09820839 40.1480756,3.90117456 C40.1501626,3.89904911 40.1522686,3.89694235 40.1543933,3.89485454 Z"
										fill="#FFFFFF"></path>
          <path class="two"
										d="M20.1543933,3.89485454 L23.9763149,0.139296592 C24.1708311,-0.0518420739 24.4826329,-0.0518571125 24.6771675,0.139262789 L45.6916134,20.7848311 C46.0855801,21.1718824 46.0911863,21.8050225 45.704135,22.1989893 C45.7000188,22.2031791 45.6958657,22.2073326 45.6916762,22.2114492 L24.677098,42.8607841 C24.4825957,43.0519059 24.1708242,43.0519358 23.9762853,42.8608513 L20.1545186,39.1069479 C19.9575152,38.9134427 19.9546793,38.5968729 20.1481845,38.3998695 C20.1502893,38.3977268 20.1524132,38.395603 20.1545562,38.3934985 L36.9937789,21.8567812 C37.1908028,21.6632968 37.193672,21.3467273 37.0001876,21.1497035 C36.9980647,21.1475418 36.9959223,21.1453995 36.9937605,21.1432767 L20.1545208,4.60825197 C19.9574869,4.41477773 19.9546013,4.09820839 20.1480756,3.90117456 C20.1501626,3.89904911 20.1522686,3.89694235 20.1543933,3.89485454 Z"
										fill="#FFFFFF"></path>
          <path class="three"
										d="M0.154393339,3.89485454 L3.97631488,0.139296592 C4.17083111,-0.0518420739 4.48263286,-0.0518571125 4.67716753,0.139262789 L25.6916134,20.7848311 C26.0855801,21.1718824 26.0911863,21.8050225 25.704135,22.1989893 C25.7000188,22.2031791 25.6958657,22.2073326 25.6916762,22.2114492 L4.67709797,42.8607841 C4.48259567,43.0519059 4.17082418,43.0519358 3.97628526,42.8608513 L0.154518591,39.1069479 C-0.0424848215,38.9134427 -0.0453206733,38.5968729 0.148184538,38.3998695 C0.150289256,38.3977268 0.152413239,38.395603 0.154556228,38.3934985 L16.9937789,21.8567812 C17.1908028,21.6632968 17.193672,21.3467273 17.0001876,21.1497035 C16.9980647,21.1475418 16.9959223,21.1453995 16.9937605,21.1432767 L0.15452076,4.60825197 C-0.0425130651,4.41477773 -0.0453986756,4.09820839 0.148075568,3.90117456 C0.150162624,3.89904911 0.152268631,3.89694235 0.154393339,3.89485454 Z"
										fill="#FFFFFF"></path>
        </g>
      </svg> </span>
						</a>
					</div>
				</c:if>
			</div>
		</div>
		<!-- Products End -->

		<!-- Explore by Company Start -->
		<div class="my-5 w-75 m-auto">
			<h2 class="text-center fw-bolder">Explore By Company</h2>
			<div class="row my-5">
				<c:forEach var="brand" items="${brands}" varStatus="status">
					<c:if test="${status.index < 8}">
						<div class="col-3">
							<div class="card p-3 bg-body-secondary mb-4" style="width: 250px">
								<img height="200px"
									src="${pageContext.request.contextPath}/assets/images/${brand.img}"
									alt="" />
								<div class="card-body text-center my-3">
									<a
										href="${pageContext.request.contextPath}/car-company/${brand.id}"
										class="btn btn-primary">${brand.name}</a>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
				<c:if test="${fn:length(brands) > 8}">
					<div class="d-flex justify-content-center">
						<a class="cta"
							href="${pageContext.request.contextPath}/all-brands"> <span>View
								More</span> <span><svg width="46px" height="25px"
									viewBox="0 0 66 43" version="1.1"
									xmlns="http://www.w3.org/2000/svg"
									xmlns:xlink="http://www.w3.org/1999/xlink">
        <g id="arrow" stroke="none" stroke-width="1" fill="none"
										fill-rule="evenodd">
          <path class="one"
										d="M40.1543933,3.89485454 L43.9763149,0.139296592 C44.1708311,-0.0518420739 44.4826329,-0.0518571125 44.6771675,0.139262789 L65.6916134,20.7848311 C66.0855801,21.1718824 66.0911863,21.8050225 65.704135,22.1989893 C65.7000188,22.2031791 65.6958657,22.2073326 65.6916762,22.2114492 L44.677098,42.8607841 C44.4825957,43.0519059 44.1708242,43.0519358 43.9762853,42.8608513 L40.1545186,39.1069479 C39.9575152,38.9134427 39.9546793,38.5968729 40.1481845,38.3998695 C40.1502893,38.3977268 40.1524132,38.395603 40.1545562,38.3934985 L56.9937789,21.8567812 C57.1908028,21.6632968 57.193672,21.3467273 57.0001876,21.1497035 C56.9980647,21.1475418 56.9959223,21.1453995 56.9937605,21.1432767 L40.1545208,4.60825197 C39.9574869,4.41477773 39.9546013,4.09820839 40.1480756,3.90117456 C40.1501626,3.89904911 40.1522686,3.89694235 40.1543933,3.89485454 Z"
										fill="#FFFFFF"></path>
          <path class="two"
										d="M20.1543933,3.89485454 L23.9763149,0.139296592 C24.1708311,-0.0518420739 24.4826329,-0.0518571125 24.6771675,0.139262789 L45.6916134,20.7848311 C46.0855801,21.1718824 46.0911863,21.8050225 45.704135,22.1989893 C45.7000188,22.2031791 45.6958657,22.2073326 45.6916762,22.2114492 L24.677098,42.8607841 C24.4825957,43.0519059 24.1708242,43.0519358 23.9762853,42.8608513 L20.1545186,39.1069479 C19.9575152,38.9134427 19.9546793,38.5968729 20.1481845,38.3998695 C20.1502893,38.3977268 20.1524132,38.395603 20.1545562,38.3934985 L36.9937789,21.8567812 C37.1908028,21.6632968 37.193672,21.3467273 37.0001876,21.1497035 C36.9980647,21.1475418 36.9959223,21.1453995 36.9937605,21.1432767 L20.1545208,4.60825197 C19.9574869,4.41477773 19.9546013,4.09820839 20.1480756,3.90117456 C20.1501626,3.89904911 20.1522686,3.89694235 20.1543933,3.89485454 Z"
										fill="#FFFFFF"></path>
          <path class="three"
										d="M0.154393339,3.89485454 L3.97631488,0.139296592 C4.17083111,-0.0518420739 4.48263286,-0.0518571125 4.67716753,0.139262789 L25.6916134,20.7848311 C26.0855801,21.1718824 26.0911863,21.8050225 25.704135,22.1989893 C25.7000188,22.2031791 25.6958657,22.2073326 25.6916762,22.2114492 L4.67709797,42.8607841 C4.48259567,43.0519059 4.17082418,43.0519358 3.97628526,42.8608513 L0.154518591,39.1069479 C-0.0424848215,38.9134427 -0.0453206733,38.5968729 0.148184538,38.3998695 C0.150289256,38.3977268 0.152413239,38.395603 0.154556228,38.3934985 L16.9937789,21.8567812 C17.1908028,21.6632968 17.193672,21.3467273 17.0001876,21.1497035 C16.9980647,21.1475418 16.9959223,21.1453995 16.9937605,21.1432767 L0.15452076,4.60825197 C-0.0425130651,4.41477773 -0.0453986756,4.09820839 0.148075568,3.90117456 C0.150162624,3.89904911 0.152268631,3.89694235 0.154393339,3.89485454 Z"
										fill="#FFFFFF"></path>
        </g>
      </svg> </span>
						</a>
					</div>
				</c:if>
			</div>
		</div>
		<!-- Explore by Company End -->

		<!-- Feedback Start -->
		<div class="my-5">
			<div class="card pt-5 px-5 w-50 m-auto">
				<h3 class="card-title text-center">We'd Like Your Feedback To
					Improve Our Website!</h3>
				<div class="card-body">
					<form action="${pageContext.request.contextPath}/post-feedback"
						method="post">
						<div class="mb-3">
							<input name="user_id" value="${user.id}" type="hidden" /> <label for="email"
								class="form-label">Email</label> <input type="email"
								name="email" id="email" value="${user.email}" readonly class="form-control" />
						</div>
						<div class="mb-3">
							<label for="description" class="form-label">Message</label>
							<textarea name="description" id="description" class="form-control"
								cols="30" rows="10" required></textarea>
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
		<!-- Feedback End -->
	</c:when>
	<c:otherwise>
		<c:redirect url="/" />
	</c:otherwise>
</c:choose>
<script>
	let stars = document.getElementsByClassName("star");
	let output = document.getElementById("output");
	function giveFeedback(n) {
		// Reset all stars to default state
		for (let i = 0; i < stars.length; i++) {
			stars[i].className = "star ml";
		}

		// Set the selected stars to gold
		for (let i = 0; i < n; i++) {
			stars[i].className = "star text-warning ml";
		}

		// Update the rating text
		output.innerText = n + "/5";

		// Update the hidden input field with the rating value
		document.getElementById("rating").value = n;
	}
</script>
<c:import url="user/footer.jsp" />
