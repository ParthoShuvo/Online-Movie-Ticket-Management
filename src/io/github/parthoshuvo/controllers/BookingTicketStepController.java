package io.github.parthoshuvo.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import io.github.parthoshuvo.SimpleServlet;
import io.github.parthoshuvo.dto.CinemaHall;
import io.github.parthoshuvo.dto.CinemaHallSeat;
import io.github.parthoshuvo.dto.PurchaseTicket;
import io.github.parthoshuvo.service.internal.database_interaction.DatabaseInteractionServiceFactory;
import io.github.parthoshuvo.service.internal.database_interaction.interfaces.BookingTicketService;

public class BookingTicketStepController extends SimpleServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher requestDispatcher = null;
	private BookingTicketService bookingTicketService = null;

	{
		bookingTicketService = (BookingTicketService) new DatabaseInteractionServiceFactory()
				.getService(DatabaseInteractionServiceFactory.SERVICE_BOOKING_TICKET);
		bookingTicketService.openService();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = ((HttpServletRequest) request).getRequestURI();
		switch (url) {
		case "/OnlineMovieTicketManagement/booking_step1":
			respondWithBookinStep1View(request, response);
			break;
		case "/OnlineMovieTicketManagement/booking_step2":
			respondWithBookingStep2View(request, response);
			break;
		case "/OnlineMovieTicketManagement/booking_step3":
			respondWithBookinStep3View(request, response);
			break;
		default:
			break;
		}
	}

	private void respondWithBookinStep3View(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session != null) {
			PurchaseTicket purchaseTicket = (PurchaseTicket) session.getAttribute("purchaseTicket");
			purchaseTicket.setSeats((String) session.getAttribute("selectedSeats"));
			request.setAttribute("noOfTickets", purchaseTicket.getNo_of_tickets());
			request.setAttribute("ticketPrice", purchaseTicket.getEachTicketPrice());
			session.setAttribute("bookingStep", String.valueOf(3));
			session.setAttribute("purchaseTicket", purchaseTicket);
			requestDispatcher = request.getRequestDispatcher("booking_step3_page");
			requestDispatcher.forward(request, response);
		} else {

		}
	}

	private void respondWithBookingStep2View(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		HttpSession session = request.getSession();
		int format = (int) request.getAttribute("format");
		String movieName = (String) request.getAttribute("movieName");
		int hallNo = (int) request.getAttribute("hall");
		int category = (int) request.getAttribute("category");
		String date = (String) request.getAttribute("showDate");
		String time = (String) request.getAttribute("showTime");
		System.out.println("Format" + format + ",MovieName" + movieName + "hallNo" + hallNo + "category" + category
				+ "date" + date + "time" + time);
		String showDateTime = date + " " + time + ":00";
		Map<String, Double> seatPriceMap = bookingTicketService.getBookedSeatsWithPrices(hallNo, date, time, format);
		System.out.println("Booked Seats" + seatPriceMap);
		PurchaseTicket purchaseTicket = new PurchaseTicket();
		purchaseTicket.setHallNo(hallNo);
		purchaseTicket.setMovie(movieName);
		purchaseTicket.setShowDate(date);
		purchaseTicket.setShowTime(time);
		purchaseTicket.setMovieFormat(format);
		purchaseTicket.setEachTicketPrice(bookingTicketService.getTicketPrice(hallNo, format));
		session.setAttribute("purchaseTicket", purchaseTicket);
		session.setAttribute("bookingStep", String.valueOf(2));
		session.setAttribute("bookingStep2Url", request.getAttribute("bookingStep2Url"));
		CinemaHall cinemaHall = getCinemaHall(hallNo, purchaseTicket.getMovieFormat(), category, 100);
		request.setAttribute("cinemaHall", cinemaHall);
		request.setAttribute("bookedSeatList", seatPriceMap);
		request.setAttribute("ticketPrice", purchaseTicket.getEachTicketPrice());
		request.setAttribute("validEntry", true);
		requestDispatcher = request.getRequestDispatcher("booking_step2_page");
		requestDispatcher.forward(request, response);
	}

	private void respondWithBookinStep1View(HttpServletRequest request, HttpServletResponse response) {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = request.getRequestURI();
		switch (url) {
		case "/OnlineMovieTicketManagement/submit_selected_seats":
			String selectedSeats = (String) request.getAttribute("selectedSeats");
			double ticketPrice = (double) request.getAttribute("ticketPrice");
			HttpSession httpSession = request.getSession(false);
			if (httpSession == null) {
				response.getWriter().write("error");
			} else {
				PurchaseTicket purchaseTicket = (PurchaseTicket) httpSession.getAttribute("purchaseTicket");
				purchaseTicket.setEachTicketPrice(ticketPrice);
				httpSession.setAttribute("selectedSeats", selectedSeats);
				httpSession.setAttribute("purchaseTicket", purchaseTicket);
				response.getWriter().write("success");
			}
			break;
		default:
			break;
		}
	}

	private CinemaHall getCinemaHall(int hallNo, int format, int category, double ticketPrice) {
		CinemaHall cinemaHall = new CinemaHall();
		List<CinemaHallSeat> seats = new ArrayList<>();
		cinemaHall.setHallNo(hallNo);
		cinemaHall.setFormat(format);
		cinemaHall.setCategory(category);
		cinemaHall.setNo_of_columns(18);
		cinemaHall.setNo_of_lower_seats(94);
		cinemaHall.setNo_of_upper_seats(82);
		cinemaHall.setTicket_price(ticketPrice);
		CinemaHallSeat cinemaHallSeat = new CinemaHallSeat();
		cinemaHallSeat.setRow("A");
		cinemaHallSeat.setSeat_position("L");
		cinemaHallSeat.setStart_seat_no(2);
		cinemaHallSeat.setEnd_seat_no(17);
		cinemaHallSeat.setTotal_columns(cinemaHall.getNo_of_columns());
		cinemaHallSeat.setIs_extended(false);
		seats.add(cinemaHallSeat);
		cinemaHallSeat = new CinemaHallSeat();
		cinemaHallSeat.setRow("B");
		cinemaHallSeat.setSeat_position("L");
		cinemaHallSeat.setStart_seat_no(1);
		cinemaHallSeat.setEnd_seat_no(18);
		cinemaHallSeat.setTotal_columns(cinemaHall.getNo_of_columns());
		cinemaHallSeat.setIs_extended(false);
		seats.add(cinemaHallSeat);
		cinemaHallSeat = new CinemaHallSeat();
		cinemaHallSeat.setRow("C");
		cinemaHallSeat.setSeat_position("L");
		cinemaHallSeat.setStart_seat_no(1);
		cinemaHallSeat.setEnd_seat_no(18);
		cinemaHallSeat.setTotal_columns(cinemaHall.getNo_of_columns());
		cinemaHallSeat.setIs_extended(false);
		seats.add(cinemaHallSeat);
		cinemaHallSeat = new CinemaHallSeat();
		cinemaHallSeat.setRow("D");
		cinemaHallSeat.setSeat_position("L");
		cinemaHallSeat.setStart_seat_no(1);
		cinemaHallSeat.setEnd_seat_no(18);
		cinemaHallSeat.setTotal_columns(cinemaHall.getNo_of_columns());
		cinemaHallSeat.setIs_extended(false);
		seats.add(cinemaHallSeat);
		cinemaHallSeat = new CinemaHallSeat();
		cinemaHallSeat.setRow("E");
		cinemaHallSeat.setSeat_position("L");
		cinemaHallSeat.setStart_seat_no(1);
		cinemaHallSeat.setEnd_seat_no(18);
		cinemaHallSeat.setTotal_columns(cinemaHall.getNo_of_columns());
		cinemaHallSeat.setIs_extended(false);
		seats.add(cinemaHallSeat);
		cinemaHallSeat = new CinemaHallSeat();
		cinemaHallSeat = new CinemaHallSeat();
		cinemaHallSeat.setRow("F");
		cinemaHallSeat.setSeat_position("U");
		cinemaHallSeat.setStart_seat_no(1);
		cinemaHallSeat.setEnd_seat_no(18);
		cinemaHallSeat.setTotal_columns(cinemaHall.getNo_of_columns());
		cinemaHallSeat.setIs_extended(false);
		seats.add(cinemaHallSeat);
		cinemaHallSeat = new CinemaHallSeat();
		cinemaHallSeat.setRow("G");
		cinemaHallSeat.setSeat_position("U");
		cinemaHallSeat.setStart_seat_no(3);
		cinemaHallSeat.setEnd_seat_no(16);
		cinemaHallSeat.setTotal_columns(cinemaHall.getNo_of_columns());
		cinemaHallSeat.setIs_extended(false);
		seats.add(cinemaHallSeat);
		cinemaHallSeat = new CinemaHallSeat();
		cinemaHallSeat.setRow("H");
		cinemaHallSeat.setSeat_position("U");
		cinemaHallSeat.setStart_seat_no(4);
		cinemaHallSeat.setEnd_seat_no(15);
		cinemaHallSeat.setTotal_columns(cinemaHall.getNo_of_columns());
		cinemaHallSeat.setIs_extended(true);
		seats.add(cinemaHallSeat);
		cinemaHallSeat = new CinemaHallSeat();
		cinemaHallSeat.setRow("I");
		cinemaHallSeat.setSeat_position("U");
		cinemaHallSeat.setStart_seat_no(5);
		cinemaHallSeat.setEnd_seat_no(14);
		cinemaHallSeat.setTotal_columns(cinemaHall.getNo_of_columns());
		cinemaHallSeat.setIs_extended(false);
		seats.add(cinemaHallSeat);
		cinemaHallSeat = new CinemaHallSeat();
		cinemaHallSeat.setRow("J");
		cinemaHallSeat.setSeat_position("U");
		cinemaHallSeat.setStart_seat_no(6);
		cinemaHallSeat.setEnd_seat_no(13);
		cinemaHallSeat.setTotal_columns(cinemaHall.getNo_of_columns());
		cinemaHallSeat.setIs_extended(false);
		seats.add(cinemaHallSeat);
		cinemaHall.setSeatList(seats);
		return cinemaHall;
	}
	
	@Override
	public void destroy() {
		bookingTicketService.closeService();
		super.destroy();
	}

}
