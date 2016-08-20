<%@page import="java.util.Iterator"%>
<%@page import="io.github.parthoshuvo.dto.Movie"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<%
		List<Movie> upComingMovieList = (ArrayList) request.getAttribute("Up_Coming_Movie_List");
		if (upComingMovieList != null && !upComingMovieList.isEmpty()) {
	%>
	<aside class="col-sm-4 col-md-3">
		<div class="sitebar">
			<div
				class="category category--cooming category--count marginb-sm mobile-category rs-cat">
				<h3 class="category__title">
					coming soon<br> <span class="title-edition">movies</span>
				</h3>
				<ol>
					<%
						Iterator<Movie> iterator = upComingMovieList.iterator();
							while (iterator.hasNext()) {
								Movie movie = iterator.next();
								String encodedMovieName = movie.getMovieName().replace(" ", "^");
								String url = request.getContextPath() + "/movie?movie_name=" + encodedMovieName + "_2";
					%>
					<li><a href="<%=url%>" class="category__item"><%=movie.getMovieName()%></a></li>
					<%
						}
					%>
				</ol>
			</div>
		</div>
	</aside>
	<%
		}
	%>
</body>
</html>