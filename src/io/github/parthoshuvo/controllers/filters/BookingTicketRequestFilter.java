package io.github.parthoshuvo.controllers.filters;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import io.github.parthoshuvo.database.DatabaseConnector;
import io.github.parthoshuvo.dto.PurchaseTicket;
import io.github.parthoshuvo.service.internal.database_interaction.DatabaseInteractionServiceFactory;
import io.github.parthoshuvo.service.internal.database_interaction.interfaces.BookingTicketService;
import io.github.parthoshuvo.service.internal.database_interaction.interfaces.MovieScheduleService;

public class BookingTicketRequestFilter implements Filter {
	private BookingTicketService bookingTicketService = null;
	private MovieScheduleService movieScheduleService = null;

	public void destroy() {
		bookingTicketService.closeService();
		movieScheduleService.closeService();
	}

	{
		DatabaseInteractionServiceFactory databaseInteractionServiceFactory = new DatabaseInteractionServiceFactory();
		bookingTicketService = (BookingTicketService) databaseInteractionServiceFactory
				.getService(DatabaseInteractionServiceFactory.SERVICE_BOOKING_TICKET);
		bookingTicketService.openService();
		movieScheduleService = (MovieScheduleService) databaseInteractionServiceFactory
				.getService(DatabaseInteractionServiceFactory.SERVICE_MOVIE_SCHEDULE);
		movieScheduleService.openService();
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		String url = ((HttpServletRequest) request).getRequestURI();
		switch (url) {
		case "/OnlineMovieTicketManagement/booking_step1":
			filterBookinStep1(request, response, chain);
			break;
		case "/OnlineMovieTicketManagement/booking_step2":
			try {
				filterBookinStep2((HttpServletRequest) request, (HttpServletResponse) response, chain);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
		case "/OnlineMovieTicketManagement/booking_step3":
			filterBookingStep3((HttpServletRequest) request, (HttpServletResponse) response, chain);
			break;
		case "/OnlineMovieTicketManagement/submit_selected_seats":
			System.out.print("submitted");
			String selectedSeats = request.getParameter("selected_seats");
			String ticketPrice = request.getParameter("ticket_price");
			if ((selectedSeats == null || selectedSeats == "") && (ticketPrice == null || ticketPrice == "")
					&& ((HttpServletRequest) request).getSession(false) == null) {
				response.getWriter().write("error");
				return;
			} else {
				request.setAttribute("selectedSeats", selectedSeats);
				request.setAttribute("ticketPrice", Double.parseDouble(ticketPrice));
				chain.doFilter(request, response);
			}
		default:
			break;
		}
	}

	private void filterBookinStep2(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
			throws IOException, ServletException, ParseException {
		Enumeration<String> parameters = request.getParameterNames();
		if (parameters != null && parameters.hasMoreElements()) {
			int i = 1;
			boolean errorFlag = true;
			Pattern pattern = Pattern.compile("(0[0-9]|1[012]):[0-5][0-9](_)(am|pm|AM|PM)");
			while (parameters.hasMoreElements()) {
				String parameter = parameters.nextElement();
				if (i <= 5) {
					if (i == 1 && parameter.equals("movie_name") && request.getParameter(parameter) != null
							&& !request.getParameter(parameter).contains(" ")
							&& (request.getParameter(parameter).endsWith("_1")
									|| request.getParameter(parameter).endsWith("_2"))) {
						errorFlag = false;
						System.out.println("1");
						// is_movie_playin check() here
					} else if (i == 2 && parameter.equals("date") && request.getParameter(parameter) != null
							&& request.getParameter(parameter).matches("\\d{2}/\\d{2}/\\d{4}")) {
						errorFlag = false;
						System.out.println("2");
					} else if (i == 3 && parameter.equals("time") && request.getParameter(parameter) != null
							&& pattern.matcher(request.getParameter(parameter)).matches()) {
						errorFlag = false;
						System.out.println("3");
					} else if (i == 4 && parameter.equals("hall") && request.getParameter(parameter) != null
							&& request.getParameter(parameter).matches("\\d+")) {
						errorFlag = false;
						System.out.println("4");
					} else if (i == 5 && parameter.equals("category") && request.getParameter(parameter) != null
							&& request.getParameter(parameter).matches("\\d+")) {
						errorFlag = false;
						System.out.println("5");
					}
					if (errorFlag) {
						System.out.println("error param pattrn problem");
						response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
						response.sendError(404);
						return;
					} else {
						errorFlag = true;
						i++;
					}

				} else {
					System.out.println("error extra param");
					response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
					response.sendError(404);
					return;
				}
			}
			String booking_step_2_url = request.getRequestURI() + "?" + "movie_name="
					+ request.getParameter("movie_name") + "&" + "date=" + request.getParameter("date") + "&" + "time="
					+ request.getParameter("time") + "&" + "hall=" + request.getParameter("hall") + "&" + "category="
					+ request.getParameter("category");
			int format = (Integer.parseInt(request.getParameter("movie_name").substring(
					request.getParameter("movie_name").length() - 1, request.getParameter("movie_name").length()))) == 1
							? 2 : 3;
			String movieName = request.getParameter("movie_name").replace("^", " ").substring(0,
					request.getParameter("movie_name").length() - 2);
			String date = (new SimpleDateFormat("dd-MMM-yy")
					.format(new SimpleDateFormat("MM/dd/yyyy").parse(request.getParameter("date")))).toUpperCase();
			String time = (new SimpleDateFormat("hh: mm a")
					.format(new SimpleDateFormat("hh:mm_a").parse(request.getParameter("time"))));
			Date showTime = new SimpleDateFormat("dd-MMM-yy hh: mm a").parse(date + " " + time);
			int hallNo = Integer.parseInt(request.getParameter("hall"));
			int category = Integer.parseInt(request.getParameter("category"));
			System.out.println(movieName);
			System.out.println(date);
			System.out.println(time);
			System.out.println(hallNo);
			System.out.println(category);
			System.out.println(showTime);
			if (showTime.compareTo(new Date()) >= 1
					&& movieScheduleService.isMoviePlaying(movieName, date, time, format, hallNo, category)
					&& !bookingTicketService.isHouseFull(date, time, hallNo)) {
				request.setAttribute("movieName", movieName);
				request.setAttribute("showDate", date);
				request.setAttribute("showTime", time);
				request.setAttribute("hall", hallNo);
				request.setAttribute("category", category);
				request.setAttribute("format", format);
				request.setAttribute("bookingStep2Url", booking_step_2_url);
				chain.doFilter(request, response);
			} else {
				System.out.println("error");
				response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
				response.sendError(404);
				return;
			}
		} else {
			System.out.println("error");
			response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
			response.sendError(404);
			return;
		}
	}

	private void filterBookinStep1(ServletRequest request, ServletResponse response, FilterChain chain) {

	}

	private void filterBookingStep3(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpSession session = request.getSession(false);
		String selectedSeats = (String) session.getAttribute("selectedSeats");
		String currentStep = (String) session.getAttribute("bookingStep");
		PurchaseTicket purchaseTicket = (PurchaseTicket) session.getAttribute("purchaseTicket");
		if (session != null && (selectedSeats != null && !selectedSeats.equals(""))
				&& (currentStep.equals("2") || currentStep.equals("3")) && purchaseTicket != null) {
			if (bookingTicketService.areSeatsAvailable(purchaseTicket.getShowDate(), purchaseTicket.getShowTime(),
					purchaseTicket.getHallNo(), selectedSeats)) {
				chain.doFilter(request, response);
			} else {
				System.out.println("error");
				response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
				response.sendError(404);
				return;
			}

		} else {
			System.out.println("error");
			response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
			response.sendError(404);
			return;
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
