<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
String cp = request.getContextPath();
String user_id = (String) session.getAttribute("user_id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" constent="width=device-width, initial-scale=1">
<title>Main</title>
<!-- Favicons -->
<link href="<%=cp%>/images/img/favicon.png" rel="icon">
<link href="<%=cp%>/images/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Fonts -->
<link href="https://fonts.googleapis.com" rel="preconnect">
<link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;1,300;1,400;1,500;1,600;1,700;1,800&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Jost:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="<%=cp%>/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="<%=cp%>/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<link href="<%=cp%>/vendor/aos/aos.css" rel="stylesheet">
<link href="<%=cp%>/vendor/glightbox/css/glightbox.min.css"
	rel="stylesheet">
<link href="<%=cp%>/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

<!-- Main CSS File -->

<link href="<%=cp%>/css/main.css" rel="stylesheet">
</head>
<body class="index-page">
	<header id="header" class="header d-flex align-items-center fixed-top">
		<div
			class="container-fluid container-xl position-relative d-flex align-items-center">

			<a href="main.action" class="logo d-flex align-items-center me-auto">
				<!-- Uncomment the line below if you also wish to use an image logo -->
				<!-- <img src="/images/img/logo.png" alt=""> -->
				<h1 class="sitename">MOMENT</h1>
			</a>

			<nav id="navmenu" class="navmenu">
				<ul>
					<li><a href="#hero" class="active">Home</a></li>
					<li><a href="#about">About</a></li>
					<li><a href="#services">Services</a></li>
					<li><a href="#team">Team</a></li>
					<li class="dropdown"><a href="#"><span>Dropdown</span> <i
							class="bi bi-chevron-down toggle-dropdown"></i></a>
						<ul>
							<li><a href="#">Dropdown 1</a></li>
							<li class="dropdown"><a href="#"><span>Deep
										Dropdown</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
								<ul>
									<li><a href="#">Deep Dropdown 1</a></li>
									<li><a href="#">Deep Dropdown 2</a></li>
									<li><a href="#">Deep Dropdown 3</a></li>
									<li><a href="#">Deep Dropdown 4</a></li>
									<li><a href="#">Deep Dropdown 5</a></li>
								</ul></li>
							<li><a href="#">Dropdown 2</a></li>
							<li><a href="#">Dropdown 3</a></li>
							<li><a href="#">Dropdown 4</a></li>
						</ul></li>
					<li><a href="#contact">Contact</a></li>
				</ul>
				<i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
			</nav>
			<c:if test="<%=user_id == null%>">
				<button type="button" id="loginBtn" class="btn-getstarted"
					onclick="location.href='loginform.action'">Login</button>
			</c:if>
			<c:if test="<%=user_id != null%>">
				<button type="button" id="logoutBtn" class="btn-getstarted"
					onclick="location.href='logout.action'">Logout</button>
			</c:if>
		</div>
	</header>
	<main class="main">
		<section id="hero" class="hero section dark-background">
			<div class="container">
				<div class="row gy-4">
					<div
						class="col-lg-6 order-2 order-lg-1 d-flex flex-column justify-content-center"
						data-aos="zoom-out">
						<h1>우리들의 모든 순간</h1>
						<h1>모먼트</h1>
						<p>여러분의 모든 순간을 계획하고 기록해보세요</p>
						<div class="d-flex">
							<a href="#about" class="btn-get-started">Sign Up</a>
							<!-- <i class="bi bi-play-circle"></i><span>Watch Video</span></a> -->
						</div>
					</div>
					<div class="col-lg-6 order-1 order-lg-2 hero-img"
						data-aos="zoom-out" data-aos-delay="0">
						<!-- 이미지 찾아봐야함 -->
						<img src="<%=cp%>/images/img/hero-img.png" class="img-fluid animated"
							alt="">
					</div>
				</div>
			</div>
		</section>
		<!-- /Hero Section -->

		<!-- Skills Section -->
		<section id="skills" class="skills section light-background">
			<div class="container" data-aos="zoom-in">
				<h2>SKILLS</h2>
				<div class="swiper init-swiper">
					<!-- 위로 올릴지 생각해봐야할듯 -->
					<script type="application/json" class="swiper-config">
            {
              "loop": true,
              "speed": 600,
              "autoplay": {
                "delay": 5000
              },
              "slidesPerView": "auto",
              "pagination": {
                "el": ".swiper-pagination",
                "type": "bullets",
                "clickable": true
              },
              "breakpoints": {
                "320": {
                  "slidesPerView": 2,
                  "spaceBetween": 40
                },
                "480": {
                  "slidesPerView": 3,
                  "spaceBetween": 60
                },
                "640": {
                  "slidesPerView": 4,
                  "spaceBetween": 80
                },
                "992": {
                  "slidesPerView": 5,
                  "spaceBetween": 120
                },
                "1200": {
                  "slidesPerView": 6,
                  "spaceBetween": 120
                }
              }
            }
          </script>
					<div class="swiper-wrapper align-items-center">
						<div class="swiper-slide">
							<img src="<%=cp%>/images/skillsimage/html.png" class="img-fluid"
								alt="">
						</div>
						<div class="swiper-slide">
							<img src="<%=cp%>/images/skillsimage/bootstrap.png"
								class="img-fluid" alt="">
						</div>
						<div class="swiper-slide">
							<img src="<%=cp%>/images/skillsimage/java.png" class="img-fluid"
								alt="">
						</div>
						<div class="swiper-slide">
							<img src="<%=cp%>/images/skillsimage/jQuery.png"
								class="img-fluid" alt="">
						</div>
						<div class="swiper-slide">
							<img src="<%=cp%>/images/skillsimage/spring.png" class="img-fluid"
								alt="">
						</div>
						<div class="swiper-slide">
							<img src="<%=cp%>/images/skillsimage/js.png" class="img-fluid"
								alt="">
						</div>
						<div class="swiper-slide">
							<img src="<%=cp%>/images/skillsimage/jsp.png" class="img-fluid"
								alt="">
						</div>
						<div class="swiper-slide">
							<img src="<%=cp%>/images/img/clients/client-8.png" class="img-fluid"
								alt="">
						</div>
					</div>
				</div>

			</div>

		</section>
		<!-- /Skills Section -->
		<!-- About Section -->
		<section id="about" class="about section">
			<!-- Section Title -->
			<div class="container section-title" data-aos="fade-up">
				<h2>About Us</h2>
			</div>
			<!-- End Section Title -->

			<div class="container">
				<div class="row gy-4">
					<div class="col-lg-6 content" data-aos="fade-up"
						data-aos-delay="0">
						<p>기존에는 그룹 내에서 이벤트를 계획할 때, 카카오톡 단체 톡방과 같은 메시징 애플리케이션을 통해 계획을
							공지하고 의견을 수렴하는 방식이 일반적이었다. 그러나 이 방법은 이벤트의 상세 계획을 명확하게 전달하는 데 불편함과
							한계가 있었다. 예를 들어, 이벤트의 세부 사항을 일일이 설명해야 하고, 정보가 분산되어 있어 놓치는 경우가 발생할
							수 있었다. 이러한 문제를 해결하기 위해, 이벤트에 대한 문서를 작성하여 그룹원들에게 공유하는 방식을 도입하면 이러한
							불편함이 크게 개선될 것이라 기대하였다.</p>
						<ul>
							<li><i class="bi bi-check2-circle"></i> <span>편리한 이벤트
									생성 : 그룹원 개인의 일정, 의견, 선호 등을 반영하여 이벤트를 생성한다.</span></li>
							<li><i class="bi bi-check2-circle"></i> <span>그룹 별
									이벤트 조회 및 확인의 용이 : 생성된 이벤트에 대한 정보를 그룹원에게 명확히 전달한다.</span></li>
							<!-- <li><i class="bi bi-check2-circle"></i> <span>Ullamco
									laboris nisi ut aliquip ex ea commodo</span></li> -->
						</ul>
					</div>

					<div class="col-lg-6" data-aos="fade-up" data-aos-delay="0">
						<p>1. 그룹을 생성하고 자신이 속한 그룹을 조회 및 관리(수정, 삭제)할 수 있다. 2. 그룹원 누구나
							자유롭게 이벤트를 발의할 수 있으며, 이벤트 참여자 개인의 특성을 반영하는 맞춤형 이벤트 생성 기능을 지원한다. 3.
							이벤트에서 사용된 경비를 입력하고 개인에 따라 금액을 달리하여 정산 금액을 산정할 수 있다. 4. 이벤트에서 촬영한
							사진을 갤러리에 올리고 이를 조회 및 관리(수정, 삭제)할 수 있다.</p>
					</div>
				</div>
			</div>
		</section>
		<!-- /About Section -->
		<!-- Why Us Section -->
		<section id="why-us" class="section why-us light-background"
			data-builder="section">

			<div class="container-fluid">

				<div class="row gy-4">

					<div
						class="col-lg-7 d-flex flex-column justify-content-center order-2 order-lg-1">

						<div class="content px-xl-5" data-aos="fade-up"
							data-aos-delay="0">
							<h3>
								<span>그룹에서 발생하는 약속 중심의</span><br>
								<strong>협업형 소셜네트워크시스템 웹어플리케이션</strong>
							</h3>
							<p>거창해보여도 열심히 만들었습니다. 어쩌고 저쩌고</p>
						</div>

						<div class="faq-container px-xl-5" data-aos="fade-up"
							data-aos-delay="0">

							<div class="faq-item faq-active">

								<h3>
									<span>01</span> 어떤 웹어플리케이션인가요?
								</h3>
								<div class="faq-content">
									<p>Feugiat pretium nibh ipsum consequat. Tempus iaculis
										urna id volutpat lacus laoreet non curabitur gravida.
										Venenatis lectus magna fringilla urna porttitor rhoncus dolor
										purus non.</p>
								</div>
								<i class="faq-toggle bi bi-chevron-right"></i>
							</div>
							<!-- End Faq item-->

							<div class="faq-item">
								<h3>
									<span>02</span> 주제를 선정한 이유는 무엇인가요?
								</h3>
								<div class="faq-content">
									<p>Dolor sit amet consectetur adipiscing elit pellentesque
										habitant morbi. Id interdum velit laoreet id donec ultrices.
										Fringilla phasellus faucibus scelerisque eleifend donec
										pretium. Est pellentesque elit ullamcorper dignissim. Mauris
										ultrices eros in cursus turpis massa tincidunt dui.</p>
								</div>
								<i class="faq-toggle bi bi-chevron-right"></i>
							</div>
							<!-- End Faq item-->

							<div class="faq-item">
								<h3>
									<span>03</span> 어려운 점은 없었나요?
								</h3>
								<div class="faq-content">
									<p>Eleifend mi in nulla posuere sollicitudin aliquam
										ultrices sagittis orci. Faucibus pulvinar elementum integer
										enim. Sem nulla pharetra diam 김세연 때문에 sit amet nisl suscipit. Rutrum
										tellus pellentesque eu tincidunt. Lectus urna duis convallis
										convallis tellus. Urna molestie at elementum eu facilisis sed
										odio morbi quis</p>
								</div>
								<i class="faq-toggle bi bi-chevron-right"></i>
							</div>
							<!-- End Faq item-->

						</div>

					</div>

					<div class="col-lg-5 order-1 order-lg-2 why-us-img">
						<img src="<%=cp%>/images/img/why-us.png" class="img-fluid" alt=""
							data-aos="zoom-in" data-aos-delay="0">
					</div>
				</div>

			</div>

		</section>
		<!-- /Why Us Section -->
		<!-- Skills Section -->
		<section id="skills" class="skills section">
			<div class="container" data-aos="fade-up" data-aos-delay="0">
				<div class="row">
					<div class="col-lg-6 d-flex align-items-center">
						<img src="<%=cp%>/images/img/skills.png" class="img-fluid" alt="">
					</div>
					<div class="col-lg-6 pt-4 pt-lg-0 content">
						<h3>Using Skills</h3>
						<p class="fst-italic">웹어플리케이션을 개발하면서 아래와 같은 기술들을 사용하였습니다.</p>
						<div class="skills-content skills-animation">
							<div class="progress">
								<span class="skill"><span>HTML</span> <i class="val">100%</i></span>
								<div class="progress-bar-wrap">
									<div class="progress-bar" role="progressbar"
										aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
								</div>
							</div>
							<!-- End Skills Item -->
							<div class="progress">
								<span class="skill"><span>CSS</span> <i class="val">90%</i></span>
								<div class="progress-bar-wrap">
									<div class="progress-bar" role="progressbar" aria-valuenow="90"
										aria-valuemin="0" aria-valuemax="100"></div>
								</div>
							</div>
							<!-- End Skills Item -->
							<div class="progress">
								<span class="skill"><span>JavaScript</span> <i
									class="val">75%</i></span>
								<div class="progress-bar-wrap">
									<div class="progress-bar" role="progressbar" aria-valuenow="75"
										aria-valuemin="0" aria-valuemax="100"></div>
								</div>
							</div>
							<!-- End Skills Item -->
							<div class="progress">
								<span class="skill"><span>JAVA</span> <i class="val">55%</i></span>
								<div class="progress-bar-wrap">
									<div class="progress-bar" role="progressbar" aria-valuenow="55"
										aria-valuemin="0" aria-valuemax="100"></div>
								</div>
							</div>
							<!-- End Skills Item -->
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- /Skills Section -->
		<!-- Services Section -->
		<section id="services" class="services section light-background">
			<!-- Section Title -->
			<div class="container section-title" data-aos="fade-up">
				<h2>Services</h2>
				<p>모먼트 웹어플리케이션에서 제공하는 기능들 입니다.</p>
			</div>
			<!-- End Section Title -->
			<div class="container">
				<div class="row gy-4">
					<div class="col-xl-3 col-md-6 d-flex" data-aos="fade-up"
						data-aos-delay="0">
						<div class="service-item position-relative">
							<div class="icon">
								<i class="bi bi-activity icon"></i>
							</div>
							<h4>
								<a href="" class="stretched-link">모먼트 생성 및 구체화</a>
							</h4>
							<p>모든 순간을 계획적으로 관리해보세요</p>
						</div>
					</div>
					<!-- End Service Item -->
					<div class="col-xl-3 col-md-6 d-flex" data-aos="fade-up"
						data-aos-delay="0">
						<div class="service-item position-relative">
							<div class="icon">
								<i class="bi bi-bounding-box-circles icon"></i>
							</div>
							<h4>
								<a href="" class="stretched-link">그룹 생성 및 관리</a>
							</h4>
							<p>그룹을 생성하고 사람들과의 인연을 이어나가세요</p>
						</div>
					</div>
					<!-- End Service Item -->
					<div class="col-xl-3 col-md-6 d-flex" data-aos="fade-up"
						data-aos-delay="0">
						<div class="service-item position-relative">
							<div class="icon">
								<i class="bi bi-calendar4-week icon"></i>
							</div>
							<h4>
								<a href="" class="stretched-link">정산 및 갤러리</a>
							</h4>
							<p>모먼트 별로 지출 내역과 사진을 관리해보세요</p>
						</div>
					</div>
					<!-- End Service Item -->
					<div class="col-xl-3 col-md-6 d-flex" data-aos="fade-up"
						data-aos-delay="0">
						<div class="service-item position-relative">
							<div class="icon">
								<i class="bi bi-broadcast icon"></i>
							</div>
							<h4>
								<a href="" class="stretched-link">알림</a>
							</h4>
							<p>웹어플리케이션에서 벌어지는 이벤트를 알림을 통해 더욱 편하게 접근하세요</p>
						</div>
					</div>
					<!-- End Service Item -->
				</div>
			</div>
		</section>
		<!-- /Services Section -->
		<!-- Team Section -->
		<section id="team" class="team section">

			<!-- Section Title -->
			<div class="container section-title" data-aos="fade-up">
				<h2>Team</h2>
				<p>쌍용강북교육센터 (스마트웹&콘텐츠개발) 코틀린을 활용한 스마트웹&앱 자바 (Java) Full-Stack
					개발자 양성과정(C) 과정 2팀</p>
			</div>
			<!-- End Section Title -->
			<div class="container">
				<div class="row gy-4">
					<div class="col-lg-6" data-aos="fade-up" data-aos-delay="0">
						<div class="team-member d-flex align-items-start">
							<div class="pic">
								<img src="<%=cp%>/images/teammeber/daejin.jpg" class="img-fluid" alt="">
							</div>
							<div class="member-info">
								<h4>문대진</h4>
								<span>팀장</span>
								<p>이거 저거 잡일담당 어쩌고 그긴거</p>
							</div>
						</div>
					</div>
					<!-- End Team Member -->

					<div class="col-lg-6" data-aos="fade-up" data-aos-delay="0">
						<div class="team-member d-flex align-items-start">
							<div class="pic">
								<img src="<%=cp%>/images/teammeber/minho.jpg" class="img-fluid" alt="">
							</div>
							<div class="member-info">
								<h4>강민호</h4>
								<span>비주얼담당</span>
								<p>그룹 매니저 로직 관련 어쩌고</p>
							</div>
						</div>
					</div>
					<!-- End Team Member -->

					<div class="col-lg-6" data-aos="fade-up" data-aos-delay="0">
						<div class="team-member d-flex align-items-start">
							<div class="pic">
								<img src="<%=cp%>/images/img/team/team-2.jpg" class="img-fluid" alt="">
							</div>
							<div class="member-info">
								<h4>김세연</h4>
								<span>말썽쟁이</span>
								<p>에효</p>								
							</div>
						</div>
					</div>
					<!-- End Team Member -->

					<div class="col-lg-6" data-aos="fade-up" data-aos-delay="0">
						<div class="team-member d-flex align-items-start">
							<div class="pic">
								<img src="<%=cp%>/images/img/team/team-4.jpg" class="img-fluid" alt="">
							</div>
							<div class="member-info">
								<h4>문예원</h4>
								<span>그저 신</span>
								<p>황새 따라 가던 뱁새 어쩌고에서 황새</p>
							</div>
						</div>
					</div>
					<!-- End Team Member -->
				</div>
			</div>
		</section>
		<!-- /Team Section -->
	</main>
	<footer id="footer" class="footer">

		<div class="footer-newsletter">
			<div class="container">
				<div class="row justify-content-center text-center">
					<div class="col-lg-6">
						<!-- <h4>Join Our Newsletter</h4>
						<p>Subscribe to our newsletter and receive the latest news
							about our products and services!</p>
						<form action="forms/newsletter.php" method="post"
							class="php-email-form">
							<div class="newsletter-form">
								<input type="email" name="email"><input type="submit"
									value="Subscribe">
							</div>
							<div class="loading">Loading</div>
							<div class="error-message"></div>
							<div class="sent-message">Your subscription request has
								been sent. Thank you!</div> -->
						</form>
					</div>
				</div>
			</div>
		</div>

		<div class="container footer-top">
			<div class="row gy-4">
				<div class="col-lg-4 col-md-6 footer-about">
					<a href="index.html" class="d-flex align-items-center"> <span
						class="sitename">MOMENT</span>
					</a>
					<div class="footer-contact pt-3">
						<p>A108 Adam Street</p>
						<p>New York, NY 535022</p>
						<p class="mt-3">
							<strong>Phone:</strong> <span>+1 5589 55488 55</span>
						</p>
						<p>
							<strong>Email:</strong> <span>info@example.com</span>
						</p>
					</div>
				</div>

				<div class="col-lg-2 col-md-3 footer-links">
					<h4>Useful Links</h4>
					<ul>
						<li><i class="bi bi-chevron-right"></i> <a href="#">Home</a></li>
						<li><i class="bi bi-chevron-right"></i> <a href="#">About
								us</a></li>
						<li><i class="bi bi-chevron-right"></i> <a href="#">Services</a></li>
						<li><i class="bi bi-chevron-right"></i> <a href="#">Terms
								of service</a></li>
					</ul>
				</div>

				<div class="col-lg-2 col-md-3 footer-links">
					<h4>Our Services</h4>
					<ul>
						<li><i class="bi bi-chevron-right"></i> <a href="#">Web
								Design</a></li>
						<li><i class="bi bi-chevron-right"></i> <a href="#">Web
								Development</a></li>
						<li><i class="bi bi-chevron-right"></i> <a href="#">Product
								Management</a></li>
						<li><i class="bi bi-chevron-right"></i> <a href="#">Marketing</a></li>
					</ul>
				</div>

				<div class="col-lg-4 col-md-12">
					<h4>Follow Us</h4>
					<p>Cras fermentum odio eu feugiat lide par naso tierra videa
						magna derita valies</p>
					<div class="social-links d-flex">
						<a href=""><i class="bi bi-twitter-x"></i></a> <a href=""><i
							class="bi bi-facebook"></i></a> <a href=""><i
							class="bi bi-instagram"></i></a> <a href=""><i
							class="bi bi-linkedin"></i></a>
					</div>
				</div>

			</div>
		</div>
	</footer>



	<!-- Scroll Top -->
	<a href="#" id="scroll-top"
		class="scroll-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

	<!-- Preloader -->
	<div id="preloader"></div>

	<!-- Vendor JS Files -->
	<script src="<%=cp%>/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="<%=cp%>/vendor/php-email-form/validate.js"></script>
	<script src="<%=cp%>/vendor/aos/aos.js"></script>
	<script src="<%=cp%>/vendor/glightbox/js/glightbox.min.js"></script>
	<script src="<%=cp%>/vendor/swiper/swiper-bundle.min.js"></script>
	<script src="<%=cp%>/vendor/waypoints/noframework.waypoints.js"></script>
	<script src="<%=cp%>/vendor/imagesloaded/imagesloaded.pkgd.min.js"></script>
	<script src="<%=cp%>/vendor/isotope-layout/isotope.pkgd.min.js"></script>

	<!-- Main JS File -->
	<script src="<%=cp%>/js/index.js"></script>

</body>
</html>