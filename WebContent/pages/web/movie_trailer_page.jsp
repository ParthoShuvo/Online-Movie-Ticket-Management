<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="io.github.parthoshuvo.dto.Movie"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%
	Object object = request.getAttribute("validEntry");
	if (object == null) {
		response.sendRedirect("error");
	}
%>
<title>Trailer</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<jsp:include page="/WEB-INF/templates/web/include_header_resources.jsp" />
<link
	href="${pageContext.request.contextPath}/resources/css/popuo-box.css"
	rel="stylesheet" type="text/css" media="all" />
<script
	src="${pageContext.request.contextPath}/resources/js//jquery.magnific-popup.js"
	type="text/javascript"></script>
</head>
<body>
	<div class="full">
		<jsp:include page="/WEB-INF/templates/web/menu.jsp" />
		<div class="main">
			<div class="video-content">
				<jsp:include page="/WEB-INF/templates/web/header.jsp" />
				<div class="right-content">
					<div class="right-content-heading">
						<div class="right-content-heading-left">
							<h3 class="head">Latest Collection of videos</h3>
						</div>
					</div>
					<!-- pop-up-box -->
					<script>
						$(document).ready(function() {
							$('.popup-with-zoom-anim').magnificPopup({
								type : 'inline',
								fixedContentPos : false,
								fixedBgPos : true,
								overflowY : 'auto',
								closeBtnInside : true,
								preloader : false,
								midClick : true,
								removalDelay : 300,
								mainClass : 'my-mfp-zoom-in'
							});
						});
					</script>

					<%
						List<Movie> movieTrailerList = (ArrayList<Movie>) request.getAttribute("Movie_Trailer_List");
						if (movieTrailerList != null && !movieTrailerList.isEmpty()) {
							int count = 0;
					%>
					<!--//pop-up-box -->
					<div class="content-grids">
						<%
							for (Movie movieTrailer : movieTrailerList) {
									count++;
									if (count % 4 == 0) {
						%>
						<div class="content-grid last-grid">
							<a class="play-icon popup-with-zoom-anim"
								href="#small-dialog-<%=movieTrailer.getTrailer()%>"><img
								src="${pageContext.request.contextPath}/resources/images/movie_posters/<%= movieTrailer.getImage() %>"
								title="<%= movieTrailer.getMovieName() %>" /></a>
							<h3><%=movieTrailer.getMovieName()%></h3>
							<a class="button play-icon popup-with-zoom-anim"
								href="#small-dialog-<%=movieTrailer.getTrailer()%>">Watch
								now</a>
						</div>
						<div id="small-dialog-<%=movieTrailer.getTrailer()%>"
							class="mfp-hide"
							style="background: #FFF; padding: 20px; text-align: left; max-width: 700px; margin: 40px auto; position: relative; text-align: center;">
							<iframe width="560" height="315"
								src="https://www.youtube.com/embed/<%=movieTrailer.getTrailer()%>"
								frameborder="0" allowfullscreen></iframe>
						</div>
						<%
							continue;
									}
						%>

						<jsp:include page="/WEB-INF/templates/web/trailer_content.jsp">
							<jsp:param value="<%=movieTrailer.getMovieName()%>"
								name="movieName" />
							<jsp:param value="<%=movieTrailer.getImage()%>" name="movieImage" />
							<jsp:param value="<%=movieTrailer.getTrailer()%>"
								name="movieTrailer" />
						</jsp:include>

						<%
							}
						%>
					</div>
					<%
						}
					%>
					<div class="clearfix"></div>
				</div>
				<div class="clearfix"></div>
			</div>
			<div class="clearfix"></div>
			<jsp:include page="/WEB-INF/templates/web/footer.jsp" />
		</div>
	</div>
	<div class="clearfix"></div>
</body>
</html>