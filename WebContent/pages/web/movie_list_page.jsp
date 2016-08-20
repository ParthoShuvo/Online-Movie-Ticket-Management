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
					<div class="col-sm-8 col-md-9">
						<h2 class="page-heading" style="margin-top: -50px;">Movies</h2>
						<jsp:include
							page="/WEB-INF/templates/web/movie_category_selection.jsp" />
						<!-- <div class="tags-area">
							<div class="tags tags--unmarked">
								<span class="tags__label">Sorted by:</span>
								<ul>
									<li class="item-wrap"><a href="#"
										class="tags__item item-active" data-filter='all'>all</a></li>
									<li class="item-wrap"><a href="#" class="tags__item"
										data-filter='release'>release date</a></li>
									<li class="item-wrap"><a href="#" class="tags__item"
										data-filter='popularity'>popularity</a></li>
									<li class="item-wrap"><a href="#" class="tags__item"
										data-filter='comments'>comments</a></li>
									<li class="item-wrap"><a href="#" class="tags__item"
										data-filter='ending'>ending soon</a></li>
								</ul>
							</div>
						</div> -->
						<%
							List<MovieShowTimeSchedule> nowShowingMovieList = (ArrayList<MovieShowTimeSchedule>) request.getAttribute("Now_Showing_Movie_List");
							if (nowShowingMovieList != null && !nowShowingMovieList.isEmpty()) {
								Iterator<MovieShowTimeSchedule> iterator = nowShowingMovieList.iterator();
								while (iterator.hasNext()) {
									MovieShowTimeSchedule movieShowTimeSchedule = iterator.next();
									request.setAttribute("movie", movieShowTimeSchedule);
						%>
						<jsp:include page="/WEB-INF/templates/web/movie_preview_item.jsp" />
						<%
							}
						%>
						<div class="coloum-wrapper">
							<div class="pagination paginatioon--full">
								<a href='#' class="pagination__prev">prev</a> <a href='#'
									class="pagination__next">next</a>
							</div>
						</div>
						<%
							}
						%>
					</div>
					<jsp:include page="/WEB-INF/templates/web/side_bar.jsp" />
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
												window.location.href = '<%=request.getContextPath()%>/movielist?release-date='
														+ pickedDate;
											});
						});
		function showTrailer(trailer) {
			jQuery.showYtVideo({
				videoId : trailer
			});
		};
	</script>
</body>
</html>