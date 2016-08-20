<%@page import="io.github.parthoshuvo.dto.PurchaseTicket"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Final Ticket</title>
<jsp:include page="/WEB-INF/templates/web/include_header_resources.jsp" />
<jsp:include page="/WEB-INF/templates/web/include_header_resources2.jsp" />
</head>
<body>
	<%
		PurchaseTicket purchaseTicket = null;
		String selectedSeats = null;
		HttpSession httpSession = request.getSession(false);
		if (httpSession == null) {

		} else {
			purchaseTicket = (PurchaseTicket) httpSession.getAttribute("purchaseTicket");
			selectedSeats = (String) httpSession.getAttribute("selectedSeats");
			if (!(httpSession.getAttribute("bookingStep") != null
					&& httpSession.getAttribute("bookingStep").equals("4") && purchaseTicket != null
					&& selectedSeats != null && !selectedSeats.equals(""))) {

			}
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
						<div class="order-container">
							<div class="order">
								<img class="order__images" alt=''
									src="${pageContext.request.contextPath}/resources/images/tickets.png">
								<p class="order__title">
									Thank you <br> <span class="order__descript">you
										have successfully purchased tickets</span>
								</p>
							</div>

							<div class="ticket">
								<div class="ticket-position">
									<div class="ticket__indecator indecator--pre">
										<div class="indecator-text pre--text">online ticket</div>
									</div>
									<div class="ticket__inner">

										<div class="ticket-secondary">
											<span class="ticket__item">Ticket number <strong
												class="ticket__number"><%=purchaseTicket.getPurchaseTicketId()%></strong></span>
											<span class="ticket__item ticket__date"><%=purchaseTicket.getPurchaseDate()%></span>
											<span class="ticket__item ticket__time"><%=purchaseTicket.getPurchaseTime()%></span>
											<span class="ticket__item">Cinema: <span
												class="ticket__cinema"><%="Cinema XXII"%></span></span> <span
												class="ticket__item">Hall: <span class="ticket__hall"><%=purchaseTicket.getHallNo()%></span></span>
											<span class="ticket__item ticket__price">price: <strong
												class="ticket__cost">&#2547;<%=purchaseTicket.getTotalCost()%></strong></span>
										</div>

										<div class="ticket-primery">
											<span class="ticket__item ticket__item--primery ticket__film">Film<br>
												<strong class="ticket__movie"><%=purchaseTicket.getMovie()%></strong></span>
											<span class="ticket__item ticket__item--primery">Sits:
												<span class="ticket__place"><%=selectedSeats%></span>
											</span>
										</div>


									</div>
									<div class="ticket__indecator indecator--post">
										<div class="indecator-text post--text">online ticket</div>
									</div>
								</div>
							</div>

							<div class="ticket-control">
								<a href="javascript:void(0);" class="watchlist list--download" onclick="downloadTicket()">Download</a> <a
									href="javascript:void(0);" class="watchlist list--print" onclick="printTicket()">Print</a>
							</div>

						</div>
					</section>
				</div>
			</div>
			<jsp:include page="/WEB-INF/templates/web/footer.jsp" />
		</div>
	</div>
	<div class="clearfix"></div>
	<jsp:include page="/WEB-INF/templates/web/include_body_resources.jsp" />
	<script type="text/javascript">
	$(document).ready(function() {
	
	});
	function downloadTicket(){
		window.print();
	};
	function printTicket(){
		window.print();
	};
	</script>
</body>
</html>