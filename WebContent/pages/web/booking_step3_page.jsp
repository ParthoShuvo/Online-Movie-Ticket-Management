<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Booking Step 3</title>
<jsp:include page="/WEB-INF/templates/web/include_header_resources.jsp" />
<jsp:include page="/WEB-INF/templates/web/include_header_resources2.jsp" />
</head>
<body>
	<%
		int totalTickets = 0;
		double ticketPrice = 0.0;
		double totalCost = 0.0;
		if (request.getAttribute("noOfTickets") != null && request.getAttribute("ticketPrice") != null) {
			totalTickets = (int) request.getAttribute("noOfTickets");
			ticketPrice = (double) request.getAttribute("ticketPrice");
			totalCost = totalTickets * ticketPrice;
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
									Book a ticket <br> <span class="order__descript">and
										have fun movie time</span>
								</p>
								<div class="order__control">
									<a href="#" class="order__control-btn active">Purchase</a>
									<!-- <a
									href="book3-reserve.html" class="order__control-btn">Reserve</a> -->
								</div>
							</div>
						</div>
						<div class="order-step-area">
							<div class="order-step first--step order-step--disable ">1.
								What &amp; Where &amp; When</div>
							<div class="order-step second--step order-step--disable">2.
								Choose a sit</div>
							<div class="order-step third--step">3. Check out</div>
						</div>

						<div class="col-sm-12"
							style="margin-top: 50px; margin-bottom: 50px;">
							<div class="checkout-wrapper">
								<h2 class="page-heading">price</h2>
								<ul class="book-result"
									style="margin-top: 20px; margin-bottom: 50px;">
									<li class="book-result__item">Tickets: <span
										class="book-result__count booking-ticket"><%=totalTickets%></span></li>
									<li class="book-result__item">One item price: <span
										class="book-result__count booking-price">&#2547;<%=ticketPrice%></span></li>
									<li class="book-result__item">Total: <span
										class="book-result__count booking-cost">&#2547;<%=totalCost%></span></li>
								</ul>

								<h2 class="page-heading">Choose payment method</h2>
								<div class="payment"
									style="margin-top: 20px; margin-bottom: 50px;">
									<a href="#" class="payment__item"> <img alt=''
										src="${pageContext.request.contextPath}/resources/images/payments/pay1.png">
									</a> <a href="#" class="payment__item"> <img alt=''
										src="${pageContext.request.contextPath}/resources/images/payments/pay2.png">
									</a> <a href="#" class="payment__item"> <img alt=''
										src="${pageContext.request.contextPath}/resources/images/payments/pay3.png">
									</a> <a href="#" class="payment__item"> <img alt=''
										src="${pageContext.request.contextPath}/resources/images/payments/pay4.png">
									</a> <a href="#" class="payment__item"> <img alt=''
										src="${pageContext.request.contextPath}/resources/images/payments/pay5.png">
									</a> <a href="#" class="payment__item"> <img alt=''
										src="${pageContext.request.contextPath}/resources/images/payments/pay6.png">
									</a> <a href="#" class="payment__item"> <img alt=''
										src="${pageContext.request.contextPath}/resources/images/payments/pay7.png">
									</a>
								</div>

								<h2 class="page-heading">Contact information</h2>

								<form id='contact-info'
									action="<%=request.getContextPath() + "/" + "purchase_ticket"%>"
									method="POST" class="form contact-info">
									<div class="contact-info__field contact-info__field-user">
										<input type="text" name='user-name' id="user-name"
											class="form__mail" placeholder='Your Name'
											pattern="(^[A-Z]+[a-zA-Z\\. ]*){6,30}$" required>
									</div>
									<div class="contact-info__field contact-info__field-mail">
										<input type='email' name='user-email' id="user-email"
											placeholder='Your email' required class="form__mail">
									</div>
									<div class="contact-info__field contact-info__field-tel">
										<input type='tel' name='user-phone' id="user-phn"
											placeholder='Phone number' class="form__mail">
									</div>
								</form>


							</div>

							<div class="order">
								<a href="javascript:void(0);" id="purchaseBtn"
									class="btn btn-md btn--warning btn--wide"
									onclick="formValidation()">purchase</a>
							</div>
						</div>

					</section>
					<div class="clearfix"></div>

					<div class="booking-pagination">
						<a href="book2.html" class="booking-pagination__prev">
							<p class="arrow__text arrow--prev">prev step</p> <span
							class="arrow__info">choose a sit</span>
						</a> <a href="#" class="booking-pagination__next hide--arrow">
							<p class="arrow__text arrow--next">next step</p> <span
							class="arrow__info"></span>
						</a>
					</div>
					<div class="clearfix"></div>

				</div>
			</div>
			<jsp:include page="/WEB-INF/templates/web/footer.jsp" />
		</div>
	</div>
	<div class="clearfix"></div>
	<jsp:include page="/WEB-INF/templates/web/include_body_resources.jsp" />
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							var userInfoForm = $('#contact-info');
							var userName = $('#user-name');
							var userEmail = $('#user-email');
							var userPhn = $('#user-phn');
							$('#purchaseBtn')
									.click(
											function() {
												/* alert("dd"); */
												var regExpUserName = "^\\b(?:[A-Z][a-zA-Z]+\\b(?:\\.?\\s*)?)";
												var regExpUserMail = "^\\w+([\\.-]?\w+)*@\\w+([\\.-]?\w+)*(\\.\\w{2,3})+$";
												var regExpUserPhn = "^(?:015|016|017|018|019)?(?:\\d{8})$";
												/* alert(userEmail.val()); */
												if ((new RegExp(regExpUserName)
														.test(userName.val()))
														&& (new RegExp(
																regExpUserPhn)
																.test(userPhn
																		.val()))
														&& (new RegExp(
																regExpUserMail)
																.test(userEmail
																		.val()))) {
													/* alert("jddj"); */
													userInfoForm.submit();
												} else {
													alert("Please input in correct order");
												}
											});
						});
	</script>
</body>
</html>