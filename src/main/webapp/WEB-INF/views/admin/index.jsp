<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<c:import url="header.jsp">
	<c:param name="title" value="Dashboard" />
</c:import>
<!-- Main Content Start -->
<div class="home-bg">
	<div class="container py-5">
		<c:set var="hourOfDay"
			value="<%=java.time.LocalTime.now().getHour()%>" />
		<c:choose>
			<c:when test="${hourOfDay ge 0 and hourOfDay lt 12}">
				<h4 class="my-5">Good Morning, ${admin.name}</h4>
			</c:when>
			<c:when test="${hourOfDay ge 12 and hourOfDay lt 16}">
				<h4 class="my-5">Good Afternoon, ${admin.name}</h4>
			</c:when>
			<c:when test="${hourOfDay ge 16 and hourOfDay lt 20}">
				<h4 class="my-5">Good Evening, ${admin.name}</h4>
			</c:when>
			<c:otherwise>
				<h4 class="my-5">Good Night, <span class="fw-bold">${admin.name}</span></h4>
			</c:otherwise>
		</c:choose>
		<div class="row">
			<div class="col-4 hvr-float">
				<a href="${pageContext.request.contextPath}/brands"
					class="card p-5 text-decoration-none card-bg-color"> <span
					class="card-title fw-bold">Total Brands</span> <span
					class="counter card-text fw-bold">${brand}</span>
				</a>
			</div>
			<div class="col-4 hvr-float">
				<a href="${pageContext.request.contextPath}/cars"
					class="card p-5 text-decoration-none card-bg-color"> <span
					class="card-title fw-bold">Total Cars</span> <span
					class="counter card-text fw-bold">${car}</span>
				</a>
			</div>
			<div class="col-4 hvr-float">
				<a href="${pageContext.request.contextPath}/orders"
					class="card p-5 text-decoration-none card-bg-color"> <span
					class="card-title fw-bold">Total Orders</span> <span
					class="counter card-text fw-bold">${order}</span>
				</a>
			</div>
		</div>
		<div class="row my-5">
			<div class="col-4 hvr-float">
				<a href="${pageContext.request.contextPath}/users"
					class="card p-5 text-decoration-none card-bg-color"> <span
					class="card-title fw-bold">Total Users</span> <span
					class="counter card-text fw-bold">${user}</span>
				</a>
			</div>
			<div class="col-4 hvr-float">
				<a href="${pageContext.request.contextPath}/feedbacks"
					class="card p-5 text-decoration-none card-bg-color"> <span
					class="card-title fw-bold">Feedback from customers</span> <span
					class="ml card-text fw-bold">${feedback} / 5</span>
				</a>
			</div>
		</div>
		<div class="my-5">
			<h5 class="mb-4 fw-bold">Top selling brands</h5>
			<div class="card p-5 card-bg-color">
				<div class="body">
					<h6 class="card-title">Top selling brands</h6>
					<div>
						<canvas id="myChart"></canvas>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Main Content End -->
<script>
fetch('${pageContext.request.contextPath}/api/top-selling-brands')
.then(response => response.json())
.then(data => {
  const labels = data.map(item => item.brandName);
  const sales = data.map(item => item.totalSales);
  const totalSales = sales.reduce((acc, curr) => acc + curr, 0);
  const ctx = document.getElementById("myChart");
  new Chart(ctx, {
    type: "bar",
    data: {
      labels: labels,
      datasets: [
        {
          label: "Total Sales",
          data: sales,
          borderWidth: 1,
        }
      ],
    },
    options: {
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });
});

</script>
<c:import url="footer.jsp" />

