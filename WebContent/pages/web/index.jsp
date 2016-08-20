<%@page import="java.util.ArrayList"%>
<%@page import="io.github.parthoshuvo.dto.Movie"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Home</title>
<jsp:include page="/WEB-INF/templates/web/include_header_resources.jsp" />
<style type="text/css">
.header {
	background:
		url('${pageContext.request.contextPath}/resources/images/dark_knight.jpg')
		no-repeat 0px 0px;
	background-size: cover;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	-ms-background-size: cover;
	max-height: 750px;
}
</style>
</head>
<body>
	<div class="full">
		<jsp:include page="/WEB-INF/templates/web/menu.jsp" />
		<div class="main">
			<div class="header">
				<!-- includes header file here -->
				<jsp:include page="/WEB-INF/templates/web/header.jsp" />
				<div class="header-info">
					<h1>Dark Knight Rises</h1>
					<p class="age">
						<a href="#">All Age</a> Christian Bale, Heath Ledger
					</p>
					<p class="review">Rating
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: &nbsp;&nbsp; 8.5/10</p>
					<p class="review reviewgo">Genre
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;Action</p>
					<p class="review">Release &nbsp;&nbsp;&nbsp;&nbsp;:
						&nbsp;&nbsp; 7 November 2014</p>
					<p class="special">The special bond that develops between
						plus-sized inflatable robot Baymax, and prodigy Hiro Hamada, who
						team up with a group of friends to form a band of high-tech
						heroes.</p>
					<a class="video" href="#"><i class="video1"></i>WATCH TRAILER</a> <a
						class="book" href="#"><i class="book1"></i>BOOK TICKET</a>
				</div>
			</div>
			<jsp:include page="/WEB-INF/templates/web/slider1.jsp" />
			<div class="news">
				<div class="col-md-6 news-left-grid">
					<h3>Don’t be late,</h3>
					<h2>Book your ticket now!</h2>
					<h4>Easy, simple & fast.</h4>
					<a href="#"><i class="book"></i>BOOK TICKET</a>
					<p>
						Get Discount up to <strong>10%</strong> if you are a member!
					</p>
				</div>
				<div class="col-md-6 news-right-grid">
					<h3>News</h3>
					<div class="news-grid">
						<h5>Lorem Ipsum Dolor Sit Amet</h5>
						<label>Nov 11 2014</label>
						<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,
							sed do eiusmod tempor incididunt ut labore et dolore magna
							aliqua. Ut enim ad minim veniam, quis nostrud exercitation
							ullamco laboris nisi ut aliquip ex ea commodo.</p>
					</div>
					<div class="news-grid">
						<h5>Lorem Ipsum Dolor Sit Amet</h5>
						<label>Nov 11 2014</label>
						<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,
							sed do eiusmod tempor incididunt ut labore et dolore magna
							aliqua. Ut enim ad minim veniam, quis nostrud exercitation
							ullamco laboris nisi ut aliquip ex ea commodo.</p>
					</div>
					<a class="more" href="#">MORE</a>
				</div>
				<div class="clearfix"></div>
			</div>
			<jsp:include page="/WEB-INF/templates/web/slider2.jsp" />
			<jsp:include page="/WEB-INF/templates/web/footer.jsp" />
		</div>
	</div>
	<div class="clearfix"></div>
</body>
<script type="text/javascript">
	$(document).ready(function($) {
	});
	function sliderImageClick(url) {
		window.location.href = url;
	};
</script>
</html>