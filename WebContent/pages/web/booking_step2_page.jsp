<%@page import="java.util.Set"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="io.github.parthoshuvo.dto.CinemaHall"%>
<%@page import="io.github.parthoshuvo.dto.CinemaHallSeat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Booking Step 2</title>
<jsp:include page="/WEB-INF/templates/web/include_header_resources.jsp" />
<jsp:include page="/WEB-INF/templates/web/include_header_resources2.jsp" />
</head>
<body>
	<%
		CinemaHall cinemaHall = (CinemaHall) request.getAttribute("cinemaHall");
		List<CinemaHallSeat> seatList = cinemaHall.getSeatList();
		Map<String, Double> bookedSeatList = (LinkedHashMap<String, Double>) request.getAttribute("bookedSeatList");
		int k = 0;
		String[] bookedSeats = null;
		boolean reservedSeatsFlag = false;
		double tickerPrice = (double) request.getAttribute("ticketPrice");
		if (bookedSeatList != null && !bookedSeatList.isEmpty()) {
			System.out.println(bookedSeatList.size());
			Set<String> keys = bookedSeatList.keySet();
			System.out.print(keys);
			bookedSeats = keys.toArray(new String[keys.size()]);
			System.out.print(bookedSeats.length);
			reservedSeatsFlag = true;
		}
	%>
	<div class="full">
		<jsp:include page="/WEB-INF/templates/web/menu.jsp" />
		<div class="main">
			<div class="single-content">
				<jsp:include page="/WEB-INF/templates/web/header.jsp" />
				<div class="reviews-section">
					<!-- Main content -->
					<section class="container">
						<div id="modal" class="modal fade">
							<!-- <div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title">Modal title</h4>
				</div>
				<div class="modal-body">
					<p>One fine body…</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div>
			/.modal-content
		</div>
		/.modal-dialog -->
						</div>
						<div class="order-container">
							<div class="order">
								<img class="order__images" alt=''
									src="${pageContext.request.contextPath}/resources/images/tickets.png" />
								<p class="order__title">
									Book a ticket <br> <span class="order__descript">and
										have fun movie time</span>
								</p>
								<div class="order__control">
									<a href="#" class="order__control-btn active">Purchase</a>
								</div>
							</div>
						</div>
						<div class="order-step-area">
							<div class="order-step first--step order-step--disable ">1.
								What &amp; Where &amp; When</div>
							<div class="order-step second--step">2. Choose a sit</div>
						</div>

						<div class="choose-sits">
							<div class="choose-sits__info choose-sits__info--first">
								<ul>
									<li class="sits-price marker--none"><strong>Seat
											Price</strong></li>
									<li class="sits-price sits-price--cheap">Lower &#2547;<%=tickerPrice%></li>
									<li class="sits-price sits-price--middle">Upper &#2547;<%=tickerPrice%></li>
									<!-- <li class="sits-price sits-price--expensive">$30</li> -->
								</ul>
							</div>

							<div class="choose-sits__info">
								<ul>
									<li class="sits-state sits-state--not">Not available</li>
									<li class="sits-state sits-state--your">Your choice</li>
								</ul>
							</div>

							<div class="col-sm-12 col-lg-10 col-lg-offset-1">
								<div class="sits-area hidden-xs">
									<div class="sits-anchor">screen</div>

									<div class="sits">
										<aside class="sits__line">
											<%
												for (CinemaHallSeat cinemaHallSeat : seatList) {
													if (!cinemaHallSeat.is_extended()) {
											%>
											<span class="sits__indecator"><%=cinemaHallSeat.getRow()%></span>

											<%
												} else {
											%>
											<span class="sits__indecator additional-margin"><%=cinemaHallSeat.getRow()%></span>
											<%
												}
												}
											%>
										</aside>
										<%
											int j = 0;
											for (CinemaHallSeat cinemaHallSeat : seatList) {
										%>
										<div <%if (!cinemaHallSeat.is_extended()) {%>
											class="sits__row" <%} else {%>
											class="sits__row additional-margin" <%}%>>
											<%
												for (int i = cinemaHallSeat.getStart_seat_no(); i <= cinemaHallSeat.getEnd_seat_no(); i++) {
											%>
											<span
												<%String className = null;
					if (cinemaHallSeat.getSeat_position().toLowerCase().equals("l")) {
						className = "sits__place sits-price--cheap";
					} else if (cinemaHallSeat.getSeat_position().toLowerCase().equals("u")) {
						className = "sits__place sits-price--middle";
					}
					if (reservedSeatsFlag && j < bookedSeats.length
							&& (bookedSeats[j].toLowerCase().startsWith("l")
									|| bookedSeats[j].toLowerCase().startsWith("u"))
							&& bookedSeats[j].substring(2).equals(cinemaHallSeat.getRow() + i)) {

						className += " " + "sits-state--not";
						j++;

					}%>
												class="<%=className%>"
												data-place='<%=cinemaHallSeat.getSeat_position()%><%=cinemaHallSeat.getRow()%><%=i%>'
												data-price='<%=tickerPrice%>'><%=cinemaHallSeat.getRow()%><%=i%></span>
											<%
												}
											%>
										</div>
										<%
											}
										%>


										<aside class="sits__checked">
											<div class="checked-place"></div>
											<div class="checked-result">$0</div>
										</aside>
										<footer class="sits__number">
											<%
												for (int i = 1; i <= cinemaHall.getNo_of_columns(); i++) {
											%>
											<span class="sits__indecator"><%=i%></span>
											<%
												}
											%>
										</footer>
									</div>
								</div>
							</div>

							<div class="col-sm-12 visible-xs">
								<div class="sits-area--mobile">
									<div class="sits-area--mobile-wrap">
										<div class="sits-select">
											<select name="sorting_item" class="sits__sort sit-row"
												tabindex="0">
												<%
													for (CinemaHallSeat cinemaHallSeat : seatList) {
												%>
												<option value="<%=cinemaHallSeat.getRow()%>"><%=cinemaHallSeat.getRow()%></option>
												<%
													}
												%>
											</select> <select name="sorting_item" class="sits__sort sit-number"
												tabindex="1">
												<%
													for (int i = 1; i <= cinemaHall.getNo_of_columns(); i++) {
												%>
												<option value="<%=i%>" selected='selected'><%=i%></option>
												<%
													}
												%>
											</select> <a href="#" class="btn btn-md btn--warning toogle-sits">Choose
												sit</a>
										</div>
									</div>

									<a href="#" class="watchlist add-sits-line">Add new sit</a>

									<aside class="sits__checked">
										<div class="checked-place">
											<span class="choosen-place"></span>
										</div>
										<div class="checked-result">&#2547;0</div>
									</aside>

									<img alt="" src="images/components/sits_mobile.png">
								</div>
							</div>

						</div>
					</section>
					<div class="clearfix"></div>
					<form id='film-and-time' class="booking-form" method='get'
						action='http://amovie.gozha.net/book3-buy.html'>

						<input type='text' id='choosen-number' name='choosen-number'
							class="choosen-number"> <input type='text'
							name='choosen-number--cheap' class="choosen-number--cheap">
						<input type='text' name='choosen-number--middle'
							class="choosen-number--middle"> <input type='text'
							name='choosen-number--expansive'
							class="choosen-number--expansive"> <input type='text'
							name='choosen-cost' class="choosen-cost"> <input
							type='text' name='choosen-sits' class="choosen-sits">


						<div class="booking-pagination booking-pagination--margin">
							<a href="book1.html" class="booking-pagination__prev"> <span
								class="arrow__text arrow--prev">prev step</span> <span
								class="arrow__info">what&amp;where&amp;when</span>
							</a> <a href="javascript:void(0);" class="booking-pagination__next"
								onclick="my_function()"> <span
								class="arrow__text arrow--next">next step</span> <span
								class="arrow__info">checkout</span>
							</a>
						</div>
					</form>
					<div class="clearfix"></div>
				</div>
			</div>
			<jsp:include page="/WEB-INF/templates/web/footer.jsp" />
		</div>
	</div>
	<!-- /.modal -->
	<div class="clearfix"></div>
	<jsp:include page="/WEB-INF/templates/web/include_body_resources.jsp" />
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							init_BookingTwo();
							$('.booking-pagination__next')
									.click(
											
											function() {
												
												if (typeof (Storage) !== "undefined") {
													var seatList = JSON
															.parse(localStorage
																	.getItem("seatList"));

													if (seatList == null || seatList.length == 0) {
														alert('please select your seats for acessin to further process');
													} else {
														console.log(seatList);
														var dup_seatList = [];
														for(var i = 0; i < seatList.length; i++){
															dup_seatList.push(seatList[i].charAt(0) + '#' + seatList[i].substring(1, seatList[i].length));
														}
														console.log(dup_seatList.toString());
														console.log('<%=request.getContextPath()%>');
														var url = '<%=request.getContextPath()%>' + '/' + 'submit_selected_seats';
														$.post(
																		url,
																		{
																			selected_seats : dup_seatList.toString(),
																			ticket_price : '<%=tickerPrice%>'

																		},
																		function(status) {
																			if(status == "success"){
																				window.location.href = '<%=request.getContextPath()%>'+ '/booking_step3'

																			}
																		});
													}
												} else {
													alert('please update your browser');
												}
											});
						});
	</script>
</body>
</html>