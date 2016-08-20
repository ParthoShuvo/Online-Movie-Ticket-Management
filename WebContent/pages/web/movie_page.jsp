<%@page import="io.github.parthoshuvo.dto.ShowTime"%>
<%@page import="io.github.parthoshuvo.dto.MovieShowTimeSchedule"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="io.github.parthoshuvo.dto.Movie"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Movie</title>
<jsp:include page="/WEB-INF/templates/web/include_header_resources.jsp" />
<jsp:include page="/WEB-INF/templates/web/include_header_resources2.jsp" />
</head>
<body>
	<div class="full">
		<jsp:include page="/WEB-INF/templates/web/menu.jsp" />
		<div class="main">
			<div class="single-content">
				<jsp:include page="/WEB-INF/templates/web/header.jsp" />
				<div class="reviews-section"></div>
				<!-- Main content -->
				<section class="container">
					<div class="col-sm-12">
						<div class="movie" style="margin-top: -50px;">
							<%
								MovieShowTimeSchedule movieShowTimeSchedule = (MovieShowTimeSchedule) request.getAttribute("movie_info");
								request.setAttribute("movie", movieShowTimeSchedule.getMovie());
								String movieName = movieShowTimeSchedule.getMovie().getMovieName();
								Date showDate = movieShowTimeSchedule.getShowDate();
								System.out.print(showDate);
								String encodedMovieName = movieName.replaceAll(" ", "^") + "_"
										+ (movieShowTimeSchedule.getMovie().isNowShowingFlag() == true ? 1 : 2);
								String url = request.getContextPath() + "/movie?" + "movie_name=" + encodedMovieName + "&date=";
							%>
							<jsp:include page="/WEB-INF/templates/web/movie_info.jsp" />
							<div class="clearfix"></div>
							<h2 class="page-heading" style="margin-top: 20px;">The plot</h2>

							<p class="movie__describe"><%=movieShowTimeSchedule.getMovie().getSummary()%></p>
						</div>
						<div id="moveHere"></div>
						<%
							List<ShowTime> showTime2d = movieShowTimeSchedule.getShowTime2D();
							List<ShowTime> showTime3d = movieShowTimeSchedule.getShowTime3D();
							request.setAttribute("encodedMovieName", encodedMovieName);
							request.setAttribute("showdate", showDate);
						%>
						<%
							if (showTime2d != null && !showTime2d.isEmpty()) {
								System.out.println(showTime2d);
								request.setAttribute("format", 2);
								request.setAttribute("schedule", showTime2d);
						%>
						<!-- <div class="movie__rate"
							style="padding-bottom: 50px;">
							<span class="movie__rating">2D</span>
						</div> -->
						<jsp:include page="/WEB-INF/templates/web/movie_time_schedule.jsp" />
						<%
							}
						%>
						<%
							if (showTime3d != null && !showTime3d.isEmpty()) {
								request.setAttribute("format", 3);
								request.setAttribute("schedule", showTime3d);
						%>
						<jsp:include page="/WEB-INF/templates/web/movie_time_schedule.jsp" />
						<%
							}
						%>
						<%
							if (movieShowTimeSchedule.getMovie().isNowShowingFlag() && showTime3d == null && showTime2d == null) {
								String datePickerDate = new SimpleDateFormat("MM/dd/yyyy").format(showDate);
						%>
						<h2 class="page-heading">showtime &amp; tickets</h2>
						<div class="choose-container">

							<div class="datepicker">
								<span class="datepicker__marker"><i
									class="fa fa-calendar"></i>Date</span> <input type="text"
									id="datepicker" value='<%=datePickerDate%>'
									class="datepicker__input">

							</div>
						</div>
						<%
							}
						%>
					</div>
				</section>
			</div>
			<jsp:include page="/WEB-INF/templates/web/footer.jsp" />
		</div>
	</div>
	<div class="clearfix"></div>
	<jsp:include page="/WEB-INF/templates/web/include_body_resources.jsp" />
	<script
		src="${pageContext.request.contextPath }/resources/js/jquery.showYtVideo.js"></script>
	<script type="text/javascript">
		$(document)
				.ready(
						function($) {
							init_MovieList();
							var rootURL = location.origin;
							$("#datepicker")
									.change(
											function() {
												var pickedDate = $(this).val();
												window.location.href = '<%=url%>' + pickedDate;
			});
		});
		function showTrailer(trailer) {
			jQuery.showYtVideo({
				videoId : trailer
			});
		};
		function bookSeat(url) {
			console.log(url);
			if (url != 'null') {
				window.location.href = url;
			}
		};
	</script>
</body>
</html>