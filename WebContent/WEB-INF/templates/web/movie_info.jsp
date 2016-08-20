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
		Movie movie = (Movie) request.getAttribute("movie");
		SimpleDateFormat ft = new SimpleDateFormat("MMMM dd, yyyy");
		String date = ft.format(movie.getReleaseDate());
	%>
	<h2 class="page-heading"><%=movie.getMovieName()%></h2>
	<div class="movie__info">
		<div class="col-sm-4 col-md-3 movie-mobile">
			<div class="movie__images">
				<span class="movie__rating">5.0</span> <img alt=''
					src="${pageContext.request.contextPath}/resources/images/movie_posters/<%=movie.getImage()%>">
			</div>
			<!-- <div class="movie__rate">Your vote: <div id='score' class="score"></div></div> -->
		</div>
		<div class="col-sm-8 col-md-9">
			<p class="movie__time"><%=movie.getDuration()%>
				min
			</p>

			<p class="movie__option">
				<strong>Country: </strong><a href="#">USA</a>
			</p>

			<p class="movie__option">
				<strong>Year: </strong><a href="#"><%=date.substring(date.length() - 5, date.length())%></a>
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
				<!-- November 1, 2013 --><%=date%>
			</p>
			<p class="movie__option">
				<strong>Director: </strong><a href="#">Peter Jackson</a>
			</p>
			<p class="movie__option">
				<strong>Actors: </strong><a href="#">Martin Freeman</a>, <a href="#">Ian
					McKellen</a>, <a href="#">Richard Armitage</a>, <a href="#">Ken
					Stott</a>, <a href="#">Graham McTavish</a>, <a href="#">Cate
					Blanchett</a>, <a href="#">Hugo Weaving</a>, <a href="#">Ian Holm</a>,
				<a href="#">Elijah Wood</a> <a href="#">...</a>
			</p>
			<p class="movie__option">
				<strong>Age restriction: </strong><a href="#"><%=movie.getMaturity()%></a>
			</p>
			<p class="movie__option">
				<strong>Box office: </strong><a href="#">$1 017 003 568</a>
			</p>
			<div class="movie__btns movie__btns--full">
				<%
					if (movie.isNowShowingFlag()) {
				%>
				<a href="#moveHere" class="btn btn-md btn--warning">book a ticket for
					this movie</a>
				<%
					} else {
				%>
				<a href="#" class="btn btn-md btn--warning disabled">Coming Soon</a>
				<%
					}
				%>
				<a href="javascript:void(0);" class="watchlist"
					onclick="showTrailer('<%=movie.getTrailer()%>')">Watch Trailer</a>
			</div>
			<!-- <div class="share">
										<span class="share__marker">Share: </span>
										<div class="addthis_toolbox addthis_default_style ">
											<a class="addthis_button_facebook_like"
												fb:like:layout="button_count"></a> <a
												class="addthis_button_tweet"></a> <a
												class="addthis_button_google_plusone"
												g:plusone:size="medium"></a>
										</div>
									</div> -->
		</div>
	</div>
</body>
</html>