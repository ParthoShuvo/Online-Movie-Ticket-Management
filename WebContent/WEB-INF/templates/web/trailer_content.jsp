<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<div class="content-grid">
		<a class="play-icon popup-with-zoom-anim"
			href="#small-dialog-${param.movieTrailer}"><img
			src="${pageContext.request.contextPath }/resources/images/movie_posters/${param.movieImage}"
			title="${param.movieName}" /></a>
		<h3>${param.movieName}</h3>
		<!-- <ul>
			<li><a href="#"><img src="images/likes.png"
					title="image-name" /></a></li>
			<li><a href="#"><img src="images/views.png"
					title="image-name" /></a></li>
			<li><a href="#"><img src="images/link.png"
					title="image-name" /></a></li>
		</ul> -->
		<a class="button play-icon popup-with-zoom-anim"
			href="#small-dialog-${param.movieTrailer}">Watch now</a>
	</div>
	<div id="small-dialog-${param.movieTrailer}" class="mfp-hide"
		style="background: #FFF; padding: 20px; text-align: left; max-width: 700px; margin: 40px auto; position: relative; text-align: center;">
		<iframe width="560" height="315"
			src="https://www.youtube.com/embed/${param.movieTrailer}"
			frameborder="0" allowfullscreen></iframe>
	</div>
</body>
</html>