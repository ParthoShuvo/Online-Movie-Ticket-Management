<%@page import="io.github.parthoshuvo.dto.ShowTime"%>
<%@page import="java.util.List"%>
<%@page import="io.github.parthoshuvo.dto.MovieShowTimeSchedule"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="io.github.parthoshuvo.dto.Movie"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link
	href="${pageContext.request.contextPath}/resources/css/showYtVideo.css"
	rel="stylesheet" />
</head>
<body>
	<%
		MovieShowTimeSchedule movieShowTimeSchedule = (MovieShowTimeSchedule) request.getAttribute("movie");
		Movie movie = movieShowTimeSchedule.getMovie();
		String encodedMovieName = movie.getMovieName().replace(" ", "^");
		String url = request.getContextPath() + "/movie?movie_name=" + encodedMovieName + "_1";
	%>
	<!-- Movie preview item -->
	<div class="movie movie--preview release">
		<div class="col-sm-5 col-md-3">
			<div class="movie__images">
				<img alt=''
					src="${pageContext.request.contextPath}/resources/images/movie_posters/<%= movie.getImage()%>">
			</div>
			<!-- <div class="movie__feature">
				<a href="#" class="movie__feature-item movie__feature--comment">123</a>
				<a href="#" class="movie__feature-item movie__feature--video">7</a>
				<a href="#" class="movie__feature-item movie__feature--photo">352</a>
			</div> -->
		</div>
		<div class="col-sm-7 col-md-9">
			<a href='<%=url%>' class="movie__title link--huge"><%=movie.getMovieName()%></a>

			<p class="movie__time"><%=movie.getDuration()%>
				min
			</p>

			<p class="movie__option">
				<strong>Country: </strong><a href="#">USA</a>
			</p>
			<p class="movie__option">
				<%
					/* 
					1- > Action
					2-> Comedy
					3-> Animation
					4-> Action
					5-> Drama
					6-> Romantic
					7-> Adventure
					8-> Sports
					9-> War */
					String genre = null;
					switch (movie.getGenre()) {
					case 1:
						genre = "Action";
						break;
					case 2:
						genre = "Comedy";
						break;
					case 3:
						genre = "Animation";
						break;
					case 4:
						genre = "Action";
						break;
					case 5:
						genre = "Drama";
						break;
					case 6:
						genre = "Romantic";
						break;
					case 7:
						genre = "Adventure";
						break;
					case 8:
						genre = "Sports";
						break;
					case 9:
						genre = "War";
						break;
					default:
						genre = "Horror";
						break;
					}
				%>
				<strong>Category: </strong><a href="#"><%=genre%></a>
			</p>
			<p class="movie__option">
				<strong>Release date: </strong>
				<%
					SimpleDateFormat ft = new SimpleDateFormat("MMMM dd, yyyy");
					String date = ft.format(movie.getReleaseDate());
				%>
				<!-- November 1, 2013 --><%=date%>
			</p>
			<p class="movie__option">
				<strong>Director: </strong><a href="#">Jon Turteltaub</a>
			</p>
			<p class="movie__option">
				<strong>Actors: </strong><a href="#">Robert De Niro</a>, <a href="#">Michael
					Douglas</a>, <a href="#">Morgan Freeman</a>, <a href="#">Kevin
					Kline</a>, <a href="#">Mary Steenburgen</a>, <a href="#">Jerry
					Ferrara</a>, <a href="#">Romany Malco</a> <a href="#">...</a>
			</p>
			<p class="movie__option">
				<strong>Maturity: </strong><a href="#"><%=movie.getMaturity()%></a>
			</p>

			<div class="movie__btns">
				<%-- <%
					if (movie.isNowShowingFlag()) {
				%>
				<a href="#" class="btn btn-md btn--warning">book a ticket for
					this movie</a>
				<%
					} else {
				%>
				<a href="#" class="btn btn-md btn--warning disabled">Coming Soon</a>
				<%
					}
				%> --%>
				<a href="javascript:void(0);" class="watchlist"
					onclick="showTrailer('<%=movie.getTrailer()%>')">Watch Trailer</a>
			</div>
			<div class="preview-footer">
				<div class="movie__rate" style="padding-bottom: 50px;">
					<!-- <div class="score"></div>
					<span class="movie__rate-number">170 votes</span> -->
					<span class="movie__rating">5.0</span>
				</div>
				<%
					List<ShowTime> showTime2d = movieShowTimeSchedule.getShowTime2D();
					List<ShowTime> showTime3d = movieShowTimeSchedule.getShowTime3D();
					if (showTime2d != null && !showTime2d.isEmpty() && showTime3d != null && !showTime3d.isEmpty()) {
				%>
				<a href="#" class="movie__show-btn movie__show-btn1">2D</a> <a
					href="#" class="movie__show-btn movie__show-btn2"
					style="margin-right: 40px;">3D</a>
				<%
					} else if (showTime2d != null && !showTime2d.isEmpty() && showTime3d == null) {
				%>
				<a href="#" class="movie__show-btn">2D</a>
				<%
					} else if (showTime3d != null && !showTime3d.isEmpty() && showTime2d == null) {
				%>
				<a href="#" class="movie__show-btn">2D</a>
				<%
					}
				%>
			</div>
		</div>
		<div class="clearfix"></div>
		<jsp:include page="/WEB-INF/templates/web/movie_time.jsp" />
	</div>
</body>
</html>