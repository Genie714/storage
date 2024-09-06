<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
String cp = request.getContextPath();

String user_id = (String) request.getSession().getAttribute("user_id");
String admin = (String) request.getSession().getAttribute("admin");

if (user_id == null && admin == null) {
	response.sendRedirect("loginform.action");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>개인페이지</title>
<link href="assets/img/favicon.png" rel="icon">
<link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<link href="assets/vendor/boxicons/css/boxicons.min.css"
	rel="stylesheet">
<link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
<link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
<link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
<link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">
<link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

<!-- Main CSS File -->
<link href="assets/css/style.css" rel="stylesheet">
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4833730b76b007bdcf9d4907fd005673"></script>
<script>
      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth'
        , events: 
        	[
        		{
          	      title: '수료일', // a property!
          	      start: '2024-09-12', // a property!
          	      end: '2024-09-12' // a property! ** see important note below about 'end' **
          	    }
			]
        });
        calendar.render();
        
        container = document.getElementById("map");
        mapCenter = new kakao.maps.LatLng(37.5565389,126.9195136);
        options = 
		{
			center : mapCenter,
			level : 3,
		};
		map = new kakao.maps.Map(container, options);
        
        
      });
      

    </script>

</head>
<body>
	<!-- ======= Header ======= -->
	<header id="header" class="header fixed-top d-flex align-items-center">
		<div class="d-flex align-items-center justify-content-between">
			<a href="main.action" class="logo d-flex align-items-center"> <img
				src="assets/img/logo.png" alt=""> <span
				class="d-none d-lg-block">MOMENT</span>
			</a> <i class="bi bi-list toggle-sidebar-btn"></i>
		</div>
		<!-- End Logo -->
		<div class="search-bar">
			<form class="search-form d-flex align-items-center" method="POST"
				action="#">
				<input type="text" name="query" placeholder="Search"
					title="Enter search keyword">
				<button type="submit" title="Search">
					<i class="bi bi-search"></i>
				</button>
			</form>
		</div>
		<!-- End Search Bar -->
		<nav class="header-nav ms-auto">
			<ul class="d-flex align-items-center">
				<li class="nav-item d-block d-lg-none"><a
					class="nav-link nav-icon search-bar-toggle " href="#"> <i
						class="bi bi-search"></i>
				</a></li>
				<!-- End Search Icon-->
				<li class="nav-item dropdown"><a class="nav-link nav-icon"
					href="#" data-bs-toggle="dropdown"> <i class="bi bi-bell"></i>
						<span class="badge bg-primary badge-number">4</span>
				</a> <!-- End Notification Icon -->
					<ul
						class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications">
						<li class="dropdown-header">You have 4 new notifications <a
							href="#"><span class="badge rounded-pill bg-primary p-2 ms-2">View
									all</span></a>
						</li>
						<li>
							<hr class="dropdown-divider">
						</li>
						<li class="notification-item"><i
							class="bi bi-exclamation-circle text-warning"></i>
							<div>
								<h4>Lorem Ipsum</h4>
								<p>Quae dolorem earum veritatis oditseno</p>
								<p>30 min. ago</p>
							</div></li>

						<li>
							<hr class="dropdown-divider">
						</li>

						<li class="notification-item"><i
							class="bi bi-x-circle text-danger"></i>
							<div>
								<h4>Atque rerum nesciunt</h4>
								<p>Quae dolorem earum veritatis oditseno</p>
								<p>1 hr. ago</p>
							</div></li>

						<li>
							<hr class="dropdown-divider">
						</li>

						<li class="notification-item"><i
							class="bi bi-check-circle text-success"></i>
							<div>
								<h4>Sit rerum fuga</h4>
								<p>Quae dolorem earum veritatis oditseno</p>
								<p>2 hrs. ago</p>
							</div></li>

						<li>
							<hr class="dropdown-divider">
						</li>

						<li class="notification-item"><i
							class="bi bi-info-circle text-primary"></i>
							<div>
								<h4>Dicta reprehenderit</h4>
								<p>Quae dolorem earum veritatis oditseno</p>
								<p>4 hrs. ago</p>
							</div></li>

						<li>
							<hr class="dropdown-divider">
						</li>
						<li class="dropdown-footer"><a href="#">Show all
								notifications</a></li>

					</ul> <!-- End Notification Dropdown Items --></li>
				<!-- End Notification Nav -->
				<li class="nav-item dropdown pe-3"><a
					class="nav-link nav-profile d-flex align-items-center pe-0"
					href="#" data-bs-toggle="dropdown"> <img
						src="assets/img/profile-img.jpg" alt="Profile"
						class="rounded-circle"> <span
						class="d-none d-md-block dropdown-toggle ps-2"><%=user_id%></span>
				</a> <!-- End Profile Iamge Icon -->

					<ul
						class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
						<li class="dropdown-header">
							<h6><%=user_id%>n
							</h6>
						</li>
						<li>
							<hr class="dropdown-divider">
						</li>

						<li><a class="dropdown-item d-flex align-items-center"
							href="users-profile.html"> <i class="bi bi-person"></i> <span>My
									Profile</span>
						</a></li>
						<li>
							<hr class="dropdown-divider">
						</li>

						<li><a class="dropdown-item d-flex align-items-center"
							href="users-profile.html"> <i class="bi bi-gear"></i> <span>Account
									Settings</span>
						</a></li>
						<li>
							<hr class="dropdown-divider">
						</li>
						<li><a class="dropdown-item d-flex align-items-center"
							href="logout.action"> <i class="bi bi-box-arrow-right"></i> <span>Logout</span>
						</a></li>

					</ul> <!-- End Profile Dropdown Items --></li>
				<!-- End Profile Nav -->

			</ul>
		</nav>
		<!-- End Icons Navigation -->

	</header>
	<!-- End Header -->

	<!-- ======= Sidebar ======= -->
	<aside id="sidebar" class="sidebar">

		<ul class="sidebar-nav" id="sidebar-nav">

			<li class="nav-item"><a class="nav-link " href="personal.action">
					<i class="bi bi-grid"></i> <span>개인페이지</span>
			</a></li>
			<!-- End Personal Nav -->

			<li class="nav-item"><a class="nav-link collapsed"
				data-bs-target="#components-nav" data-bs-toggle="collapse" href="#">
					<i class="bi bi-menu-button-wide"></i><span>그룹리스트</span><i
					class="bi bi-chevron-down ms-auto"></i>
			</a>
				<ul id="components-nav" class="nav-content collapse "
					data-bs-parent="#sidebar-nav">
					<li><a href="components-alerts.html"> <i
							class="bi bi-circle"></i><span>SIST</span>
					</a></li>
					<li><a href="components-accordion.html"> <i
							class="bi bi-circle"></i><span>군대 모임</span>
					</a></li>
					<li><a href="components-badges.html"> <i
							class="bi bi-circle"></i><span>고등학교 동창회</span>
					</a></li>
					<li><a href="components-breadcrumbs.html"> <i
							class="bi bi-circle"></i><span>대학교 동기회</span>
					</a></li>
					<li><a href="components-buttons.html"> <i
							class="bi bi-circle"></i><span>Buttons</span>
					</a></li>
					<li><a href="components-cards.html"> <i
							class="bi bi-circle"></i><span>Cards</span>
					</a></li>
					<li><a href="components-carousel.html"> <i
							class="bi bi-circle"></i><span>Carousel</span>
					</a></li>
					<li><a href="components-list-group.html"> <i
							class="bi bi-circle"></i><span>List group</span>
					</a></li>
					<li><a href="components-modal.html"> <i
							class="bi bi-circle"></i><span>Modal</span>
					</a></li>
					<li><a href="components-tabs.html"> <i
							class="bi bi-circle"></i><span>Tabs</span>
					</a></li>
					<li><a href="components-pagination.html"> <i
							class="bi bi-circle"></i><span>Pagination</span>
					</a></li>
					<li><a href="components-progress.html"> <i
							class="bi bi-circle"></i><span>Progress</span>
					</a></li>
					<li><a href="components-spinners.html"> <i
							class="bi bi-circle"></i><span>Spinners</span>
					</a></li>
					<li><a href="components-tooltips.html"> <i
							class="bi bi-circle"></i><span>Tooltips</span>
					</a></li>
				</ul></li>
			<!-- End Components Nav -->

			<li class="nav-item"><a class="nav-link collapsed"
				data-bs-target="#forms-nav" data-bs-toggle="collapse" href="#">
					<i class="bi bi-journal-text"></i><span>Forms</span><i
					class="bi bi-chevron-down ms-auto"></i>
			</a>
				<ul id="forms-nav" class="nav-content collapse "
					data-bs-parent="#sidebar-nav">
					<li><a href="forms-elements.html"> <i class="bi bi-circle"></i><span>Form
								Elements</span>
					</a></li>
					<li><a href="forms-layouts.html"> <i class="bi bi-circle"></i><span>Form
								Layouts</span>
					</a></li>
					<li><a href="forms-editors.html"> <i class="bi bi-circle"></i><span>Form
								Editors</span>
					</a></li>
					<li><a href="forms-validation.html"> <i
							class="bi bi-circle"></i><span>Form Validation</span>
					</a></li>
				</ul></li>
			<!-- End Forms Nav -->

			<li class="nav-item"><a class="nav-link collapsed"
				data-bs-target="#tables-nav" data-bs-toggle="collapse" href="#">
					<i class="bi bi-layout-text-window-reverse"></i><span>Tables</span><i
					class="bi bi-chevron-down ms-auto"></i>
			</a>
				<ul id="tables-nav" class="nav-content collapse "
					data-bs-parent="#sidebar-nav">
					<li><a href="tables-general.html"> <i class="bi bi-circle"></i><span>General
								Tables</span>
					</a></li>
					<li><a href="tables-data.html"> <i class="bi bi-circle"></i><span>Data
								Tables</span>
					</a></li>
				</ul></li>
			<!-- End Tables Nav -->

			<li class="nav-item"><a class="nav-link collapsed"
				data-bs-target="#charts-nav" data-bs-toggle="collapse" href="#">
					<i class="bi bi-bar-chart"></i><span>Charts</span><i
					class="bi bi-chevron-down ms-auto"></i>
			</a>
				<ul id="charts-nav" class="nav-content collapse "
					data-bs-parent="#sidebar-nav">
					<li><a href="charts-chartjs.html"> <i class="bi bi-circle"></i><span>Chart.js</span>
					</a></li>
					<li><a href="charts-apexcharts.html"> <i
							class="bi bi-circle"></i><span>ApexCharts</span>
					</a></li>
					<li><a href="charts-echarts.html"> <i class="bi bi-circle"></i><span>ECharts</span>
					</a></li>
				</ul></li>
			<!-- End Charts Nav -->

			<li class="nav-item"><a class="nav-link collapsed"
				data-bs-target="#icons-nav" data-bs-toggle="collapse" href="#">
					<i class="bi bi-gem"></i><span>Icons</span><i
					class="bi bi-chevron-down ms-auto"></i>
			</a>
				<ul id="icons-nav" class="nav-content collapse "
					data-bs-parent="#sidebar-nav">
					<li><a href="icons-bootstrap.html"> <i
							class="bi bi-circle"></i><span>Bootstrap Icons</span>
					</a></li>
					<li><a href="icons-remix.html"> <i class="bi bi-circle"></i><span>Remix
								Icons</span>
					</a></li>
					<li><a href="icons-boxicons.html"> <i class="bi bi-circle"></i><span>Boxicons</span>
					</a></li>
				</ul></li>
			<!-- End Icons Nav -->

			<li class="nav-heading">Pages</li>

			<li class="nav-item"><a class="nav-link collapsed"
				href="users-profile.html"> <i class="bi bi-person"></i> <span>Profile</span>
			</a></li>
			<!-- End Profile Page Nav -->

			<li class="nav-item"><a class="nav-link collapsed"
				href="pages-faq.html"> <i class="bi bi-question-circle"></i> <span>F.A.Q</span>
			</a></li>
			<!-- End F.A.Q Page Nav -->

			<li class="nav-item"><a class="nav-link collapsed"
				href="pages-contact.html"> <i class="bi bi-envelope"></i> <span>Contact</span>
			</a></li>
			<!-- End Contact Page Nav -->

			<li class="nav-item"><a class="nav-link collapsed"
				href="pages-register.html"> <i class="bi bi-card-list"></i> <span>Register</span>
			</a></li>
			<!-- End Register Page Nav -->

			<li class="nav-item"><a class="nav-link collapsed"
				href="pages-login.html"> <i class="bi bi-box-arrow-in-right"></i>
					<span>Login</span>
			</a></li>
			<!-- End Login Page Nav -->

			<li class="nav-item"><a class="nav-link collapsed"
				href="pages-error-404.html"> <i class="bi bi-dash-circle"></i> <span>Error
						404</span>
			</a></li>
			<!-- End Error 404 Page Nav -->

			<li class="nav-item"><a class="nav-link collapsed"
				href="pages-blank.html"> <i class="bi bi-file-earmark"></i> <span>Blank</span>
			</a></li>
			<!-- End Blank Page Nav -->

		</ul>

	</aside>
	<!-- End Sidebar-->

	<main id="main" class="main">

		<div class="pagetitle">
			<h1>개인페이지</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="main.action">Main</a></li>
					<li class="breadcrumb-item active">개인페이지</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		<section class="section dashboard">
			<div class="row">

				<!-- Left side columns -->
				<div class="col-lg-8">
					<div class="row">

						<!-- Most Recent Card -->
						<div class="col-xxl-4 col-md-6">
							<div class="card info-card sales-card">
								<div class="card-body">
									<h5 class="card-title">
										Most Recent<span> | MOMENT</span>
									</h5>

									<div class="d-flex align-items-center">
										<div
											class="card-icon rounded-circle d-flex align-items-center justify-content-center">
											<i class="bi bi-cart"></i>
										</div>
										<div class="ps-3">
											<h6>
												<a href="#" style="color: black;">주말 프로젝트</a>
											</h6>
											<span class="text-success small pt-1 fw-bold">2024-08-31</span>
											<span class="text-muted small pt-2 ps-1">SIST_F_2</span>
										</div>
									</div>
								</div>

							</div>
						</div>
						<!-- End Most Recent Card -->

						<!-- Revenue Card -->
						<div class="col-xxl-4 col-md-6">
							<div class="card info-card revenue-card">
								<div class="card-body">
									<h5 class="card-title">
										Nearest Next <span>| MOMENT</span>
									</h5>

									<div class="d-flex align-items-center">
										<div
											class="card-icon rounded-circle d-flex align-items-center justify-content-center">
											<i class="bi bi-currency-dollar"></i>
										</div>
										<div class="ps-3">
											<h6>
												<a href="" style="color: black;">수료회식</a>
											</h6>
											<span class="text-success small pt-1 fw-bold">2024-09-12</span>
											<span class="text-muted small pt-2 ps-1">SIST_F</span>

										</div>
									</div>
								</div>

							</div>
						</div>
						<!-- End Revenue Card -->

						<!-- Customers Card -->
						<div class="col-xxl-4 col-xl-12">

							<div class="card info-card customers-card">
								<div class="card-body">
									<h5 class="card-title">
										BuildUp <span>| MOMENT</span>
									</h5>

									<div class="swiper init-swiper">
										<script type="application/json" class="swiper-config">
            {
              "loop": false,
              "speed": 600,
              "autoplay": {
                "delay": 3000
              },
              "slidesPerView": "auto",
              "pagination": {
                "el": ".swiper-pagination",
                "type": "bullets",
                "clickable": true
              },
              "breakpoints": {
                "320": {
                  "slidesPerView": 1,
                  "spaceBetween": 40
                },
                "480": {
                  "slidesPerView": 1,
                  "spaceBetween": 60
                },
                "640": {
                  "slidesPerView": 1,
                  "spaceBetween": 80
                },
                "992": {
                  "slidesPerView": 1,
                  "spaceBetween": 120
                },
                "1200": {
                  "slidesPerView": 1,
                  "spaceBetween": 120
                }
              }
            }
          </script>
										<div class="swiper-wrapper align-items-center">
											<div class="swiper-slide">
												<div class="d-flex align-items-center">
													<div
														class="card-icon rounded-circle d-flex align-items-center justify-content-center">
														<i class="bi bi-people"></i>
													</div>
													<div class="ps-3">
														<h6>겨울 해외여행</h6>
														<span class="text-success small pt-1 fw-bold">2025-11-31</span>
														<span class="text-muted small pt-2 ps-1">SIST_F_2</span>
													</div>
												</div>
											</div>
											<div class="swiper-slide">
												<div class="d-flex align-items-center">
													<div
														class="card-icon rounded-circle d-flex align-items-center justify-content-center">
														<i class="bi bi-people"></i>
													</div>
													<div class="ps-3">
														<h6>크리스마스</h6>
														<span class="text-success small pt-1 fw-bold">2024-12</span>
														<span class="text-muted small pt-2 ps-1">대학동기</span>

													</div>
												</div>
											</div>
											<div class="swiper-slide">
												<div class="d-flex align-items-center">
													<div
														class="card-icon rounded-circle d-flex align-items-center justify-content-center">
														<i class="bi bi-people"></i>
													</div>
													<div class="ps-3">
														<h6>설날 모임</h6>
														<span class="text-success small pt-1 fw-bold">2024-9-15</span>
														<span class="text-muted small pt-2 ps-1">바보들</span>

													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 
									<div class="d-flex align-items-center">
										<div
											class="card-icon rounded-circle d-flex align-items-center justify-content-center">
											<i class="bi bi-people"></i>
										</div>
										<div class="ps-3">
											<h6>1244</h6>
											<span class="text-danger small pt-1 fw-bold">12%</span> <span
												class="text-muted small pt-2 ps-1">decrease</span>

										</div>
									</div>
									 -->
								</div>
								<!-- end cardbody -->
							</div>

						</div>
						<!-- End Customers Card -->

						<!-- Callendar -->
						<div class="col-12">
							<div class="card">
								<div class="card-body">
									<h5 class="card-title">
										Callendar <span>/Today</span>
									</h5>

									<!-- Line Chart -->
									<div id="calendar"></div>
									<!-- End Line Chart -->

								</div>

							</div>
						</div>
						<!-- End Reports -->

						<!-- Group List -->
						<div class="col-12">
							<div class="card recent-sales overflow-auto">
								<div class="card-body">
									<h5 class="card-title">
										Group List <span>| My Group</span>
									</h5>

									<table class="table table-sm">
										<thead>
											<tr>
												<th scope="col">Num</th>
												<th scope="col">GroupName</th>
												<th scope="col">MemberCount</th>
												<th scope="col">Since</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th scope="row">1</th>
												<td><a href="#" class="text-primary">독서모임</a></td>
												<td>57명</td>
												<td>2024-01-01</td>
											</tr>
											<tr>
												<th scope="row">2</th>
												<td><a href="#" class="text-primary">SIST</a></td>
												<td>5명</td>
												<td>2024-01-01</td>
											</tr>
											<tr>
												<th scope="row">3</th>
												<td><a href="#" class="text-primary">군대동기</a></td>
												<td>20명</td>
												<td>2024-01-01</td>
											</tr>
											<tr>
												<th scope="row">4</th>
												<td><a href="#" class="text-primary">대학동기</a></td>
												<td>27명</td>
												<td>2024-01-01</td>

											</tr>
											<tr>
												<th scope="row">5</th>
												<td><a href="#" class="text-primar">바보들</a></td>
												<td>8명</td>
												<td>2024-01-01</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<!-- End GroupList -->

						<!-- Moment List -->
						<div class="col-12">
						<div class="col-12">
							<div class="card recent-sales overflow-auto">
								<div class="card-body">
									<h5 class="card-title">
										MOMENT List <span>| My MOMENT</span>
									</h5>
									<table class="table table-sm">
										<thead>
											<tr>
												<th scope="col">Num</th>
												<th scope="col">MOMENTName</th>
												<th scope="col">PLACE</th>
												<th scope="col">DATE</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th scope="row">1</th>
												<td><a href="#" class="text-primary">여름여행</a></td>
												<td>충주 거기</td>
												<td>2024-01-01</td>
											</tr>
											<tr>
												<th scope="row">2</th>
												<td><a href="#" class="text-primary">겨울여행</a></td>
												<td>광주</td>
												<td>2024-01-01</td>
											</tr>
											<tr>
												<th scope="row">3</th>
												<td><a href="#" class="text-primary">추석여행</a></td>
												<td>서울</td>
												<td>2024-01-01</td>
											</tr>
											<tr>
												<th scope="row">4</th>
												<td><a href="#" class="text-primary">저녁식사</a></td>
												<td>홍대</td>
												<td>2024-01-01</td>

											</tr>
											<tr>
												<th scope="row">5</th>
												<td><a href="#" class="text-primar">점심식사</a></td>
												<td>노원구</td>
												<td>2024-01-01</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
													
						</div>
						<!-- End Moment List -->

					</div>
				</div>
				<!-- End Left side columns -->

				<!-- Right side columns -->
				<div class="col-lg-4">

					<!-- Next MOMENT -->
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">
								Next MOMENT <span>| Summary</span>
							</h5>
							<div class="activity">
								<div class="activity-item d-flex">
									<div class="activite-label">32 min</div>
									<i
										class='bi bi-circle-fill activity-badge text-success align-self-start'></i>
									<div class="activity-content">
										Quia quae rerum <a href="#" class="fw-bold text-dark">explicabo
											officiis</a> beatae
									</div>
								</div>
								<!-- End activity item-->

								<div class="activity-item d-flex">
									<div class="activite-label">56 min</div>
									<i
										class='bi bi-circle-fill activity-badge text-danger align-self-start'></i>
									<div class="activity-content">Voluptatem blanditiis
										blanditiis eveniet</div>
								</div>
								<!-- End activity item-->

								<div class="activity-item d-flex">
									<div class="activite-label">2 hrs</div>
									<i
										class='bi bi-circle-fill activity-badge text-primary align-self-start'></i>
									<div class="activity-content">Voluptates corrupti
										molestias voluptatem</div>
								</div>
								<!-- End activity item-->

								<div class="activity-item d-flex">
									<div class="activite-label">1 day</div>
									<i
										class='bi bi-circle-fill activity-badge text-info align-self-start'></i>
									<div class="activity-content">
										Tempore autem saepe <a href="#" class="fw-bold text-dark">occaecati
											voluptatem</a> tempore
									</div>
								</div>
								<!-- End activity item-->

								<div class="activity-item d-flex">
									<div class="activite-label">2 days</div>
									<i
										class='bi bi-circle-fill activity-badge text-warning align-self-start'></i>
									<div class="activity-content">Est sit eum reiciendis
										exercitationem</div>
								</div>
								<!-- End activity item-->

								<div class="activity-item d-flex">
									<div class="activite-label">4 weeks</div>
									<i
										class='bi bi-circle-fill activity-badge text-muted align-self-start'></i>
									<div class="activity-content">Dicta dolorem harum nulla
										eius. Ut quidem quidem sit quas</div>
								</div>
								<!-- End activity item-->

							</div>

						</div>
					</div>
					<!-- End Recent Activity -->

					<!-- Maps -->
					<div class="card">
						<div class="card-body pb-0">
							<h5 class="card-title">
								Favorite Place <span>| Map</span>
							</h5>
							<div id="map" style="min-height: 400px;" class="map"></div>
						</div>
					</div>
					<!-- End Maps -->

					<!-- Gallery -->
					<div class="card">
						<div class="card-body pb-0">
							<h5 class="card-title">
								Favorite Picture <span>| Gallery</span>
							</h5>
							<div class="swiper init-swiper">
										<script type="application/json" class="swiper-config">
            {
              "loop": false,
              "speed": 600,
              "autoplay": {
                "delay": 3000
              },
              "slidesPerView": "auto",
              "pagination": {
                "el": ".swiper-pagination",
                "type": "bullets",
                "clickable": true
              },
              "breakpoints": {
                "320": {
                  "slidesPerView": 1,
                  "spaceBetween": 40
                },
                "480": {
                  "slidesPerView": 1,
                  "spaceBetween": 60
                },
                "640": {
                  "slidesPerView": 1,
                  "spaceBetween": 80
                },
                "992": {
                  "slidesPerView": 1,
                  "spaceBetween": 120
                },
                "1200": {
                  "slidesPerView": 1,
                  "spaceBetween": 120
                }
              }
            }
          </script>
										<div class="swiper-wrapper align-items-center">
											<div class="swiper-slide">
												<img src="<%=cp%>/images/sampleimage/sample1.jpg" alt="" class="img-fluid"/>
											</div>
											<div class="swiper-slide">
												<img src="<%=cp%>/images/sampleimage/sample2.jpg" alt="" class="img-fluid"/>
											</div>
											<div class="swiper-slide">
												<img src="<%=cp%>/images/sampleimage/sample3.jpg" alt="" class="img-fluid"/>
											</div>
											<div class="swiper-slide">
												<img src="<%=cp%>/images/sampleimage/sample4.jpg" alt="" class="img-fluid"/>
											</div>
											<div class="swiper-slide">
												<img src="<%=cp%>/images/sampleimage/sample5.jpg" alt="" class="img-fluid"/>
											</div>
											<div class="swiper-slide">
												<img src="<%=cp%>/images/sampleimage/sample6.jpg" alt="" class="img-fluid"/>
											</div>
										</div>
									</div>
						</div>
					</div>
					<!-- End Favorite Ficture -->
				</div>
				<!-- End Right side columns -->
			</div>
		</section>

	</main>
	<!-- End #main -->

	<!-- ======= Footer ======= -->
	<footer id="footer" class="footer">
		<div class="copyright">
			&copy; Copyright <strong><span>NiceAdmin</span></strong>. All Rights
			Reserved
		</div>
		<div class="credits">
			<!-- All the links in the footer should remain intact. -->
			<!-- You can delete the links only if you purchased the pro version. -->
			<!-- Licensing information: https://bootstrapmade.com/license/ -->
			<!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
			Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
		</div>
	</footer>
	<!-- End Footer -->

	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

	<!-- Vendor JS Files -->
	<script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
	<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="assets/vendor/chart.js/chart.umd.js"></script>
	<script src="assets/vendor/echarts/echarts.min.js"></script>
	<script src="assets/vendor/quill/quill.js"></script>
	<script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
	<script src="assets/vendor/tinymce/tinymce.min.js"></script>
	<script src="assets/vendor/php-email-form/validate.js"></script>
	<script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
	<!-- Template Main JS File -->
	<script src="assets/js/main.js"></script>

</body>
</html>