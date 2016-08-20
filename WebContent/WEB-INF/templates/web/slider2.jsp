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
	<%
		List<Movie> upComingMovieList = (ArrayList<Movie>) request.getAttribute("Up_Coming_Movie_List");
		if (upComingMovieList != null && !upComingMovieList.isEmpty()) {
	%>
	<div class="more-reviews">

		<ul id="flexiselDemo2">
			<%
				for (Movie movie : upComingMovieList) {
						String encodedMovieName = movie.getMovieName().replace(" ", "^");
						String url = request.getContextPath() + "/movie?movie_name=" + encodedMovieName + "_2";
			%>
			<li><img
				src="${pageContext.request.contextPath}/resources/images/movie_posters/<%= movie.getImage()%>"
				onclick="sliderImageClick('<%=url%>')" /></li>

			<%
				}
			%>
			<%-- <li><img
				src="${pageContext.request.contextPath}/resources/images/movie_posters/m2.jpg" /></li>
			<li><img
				src="${pageContext.request.contextPath}/resources/images/movie_posters/m3.jpg" /></li>
			<li><img
				src="${pageContext.request.contextPath}/resources/images/movie_posters/m4.jpg" /></li> --%>
		</ul>
		<script type="text/javascript">
			$(window).load(function() {

				$("#flexiselDemo2").flexisel({
					visibleItems : 4,
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
							visibleItems : 3
						}
					}
				});
			});
		</script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/js/jquery.flexisel.js"></script>
	</div>
	<%
		}
	%>
</body>
</html>