<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Booking Step1</title>
<jsp:include page="/WEB-INF/templates/web/include_header_resources.jsp" />
<jsp:include page="/WEB-INF/templates/web/include_header_resources2.jsp" />
</head>
<body>
	<div class="full">
		<jsp:include page="/WEB-INF/templates/web/menu.jsp" />
		<div class="main">
			<div class="single-content">
				<jsp:include page="/WEB-INF/templates/web/header.jsp" />
			</div>
			<div class="review-slider">
				<ul id="flexiselDemo1">
					<li><img
						src="${pageContext.request.contextPath}/resources/images/movie_posters/r2.jpg"
						alt="" /></li>
					<li><img
						src="${pageContext.request.contextPath}/resources/images/movie_posters/r3.jpg"
						alt="" /></li>
					<li><img
						src="${pageContext.request.contextPath}/resources/images/movie_posters/r4.jpg"
						alt="" /></li>
					<li><img
						src="${pageContext.request.contextPath}/resources/images/movie_posters/r5.jpg"
						alt="" /></li>
					<li><img
						src="${pageContext.request.contextPath}/resources/images/movie_posters/r6.jpg"
						alt="" /></li>
				</ul>
				<script type="text/javascript">
					$(window).load(function() {

						$("#flexiselDemo1").flexisel({
							visibleItems : 6,
							animationSpeed : 1000,
							autoPlay : true,
							autoPlaySpeed : 3000,
							pauseOnHover : false,
							enableResponsiveBreakpoints : true,
							responsiveBreakpoints : {
								portrait : {
									changePoint : 480,
									visibleItems : 2
								},
								landscape : {
									changePoint : 640,
									visibleItems : 3
								},
								tablet : {
									changePoint : 768,
									visibleItems : 4
								}
							}
						});
						/* function myFunction(){
							alert("sds");
						} */
					});
				</script>
			</div>
			<jsp:include page="/WEB-INF/templates/web/footer.jsp" />
		</div>
	</div>
	<div class="clearfix"></div>
	<jsp:include page="/WEB-INF/templates/web/include_body_resources.jsp" />
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/jquery.flexisel.js"></script>
	<script type="text/javascript">
		$(document).ready(function($) {
		});
		function sliderImageClick(url) {
			window.location.href = url;
		};
	</script>
</body>
</html>