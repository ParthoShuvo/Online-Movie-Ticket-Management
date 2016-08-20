<%@page import="java.util.ArrayList"%>
<%@page import="io.github.parthoshuvo.dto.Movie"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<div class="review-slider">
		<ul id="flexiselDemo1">
			<%
				List<Movie> nowShowingMovieList = (ArrayList<Movie>) request.getAttribute("Now_Showing_Movie_List");

				for (Movie movie : nowShowingMovieList) {
					String encodedMovieName = movie.getMovieName().replace(" ", "^");
					String url = request.getContextPath() + "/movie?movie_name=" + encodedMovieName + "_1";
			%>
			<li><img
				src="${pageContext.request.contextPath}/resources/images/movie_posters/<%= movie.getImage() %>"
				onclick="sliderImageClick('<%=url%>')" /></li>
			<%
				}
			%>
			<%-- <li><img
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
				alt="" /></li> --%>
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
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/js/jquery.flexisel.js"></script>
	</div>
</body>
</html>