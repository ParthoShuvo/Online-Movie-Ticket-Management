package io.github.parthoshuvo.controllers;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import io.github.parthoshuvo.SimpleServlet;
import io.github.parthoshuvo.dto.Customer;
import io.github.parthoshuvo.dto.PurchaseTicket;
import io.github.parthoshuvo.service.internal.database_interaction.DatabaseInteractionServiceFactory;
import io.github.parthoshuvo.service.internal.database_interaction.interfaces.BookingTicketService;

public class PurchaseTicketControllerServlet extends SimpleServlet {
	private static final long serialVersionUID = 1L;
	private BookingTicketService bookingTicketService;

	{
		bookingTicketService = (BookingTicketService) new DatabaseInteractionServiceFactory()
				.getService(DatabaseInteractionServiceFactory.SERVICE_BOOKING_TICKET);
		bookingTicketService.openService();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String userName = request.getParameter("user-name");
		String userEmail = request.getParameter("user-email");
		String userPhone = request.getParameter("user-phone");
		HttpSession session = request.getSession(false);
		if (session != null) {
			PurchaseTicket purchaseTicket = (PurchaseTicket) session.getAttribute("purchaseTicket");
			String selectedSeats = (String) session.getAttribute("selectedSeats");
			Customer customer = new Customer();
			customer.setCustomerName(userName);
			customer.setEmail(userEmail);
			customer.setPhone(userPhone);
			System.out.println("----Purchase Ticket--------");
			System.out.println(
					"Hall No:" + purchaseTicket.getHallNo() + ",Ticket Price:" + purchaseTicket.getEachTicketPrice()
							+ ",No. of Seats Reuest for booking:" + purchaseTicket.getNo_of_tickets());
			/*
			 * System.out.println("Customer:" + customer.getCustomerName() +
			 * ",Email:" + customer.getEmail() + "Phone:" +
			 * customer.getPhone());
			 */
			System.out.println("ShowDate:" + purchaseTicket.getShowDate() + ",Time:" + purchaseTicket.getShowTime());
			System.out.println("Seat" + selectedSeats);
			System.out.println("Movie Format:" + purchaseTicket.getMovieFormat() + "D");
			System.out.println(purchaseTicket.getMovie());
			System.out.println(customer.toString());
			/*
			 * int ticketId = dbConnector.bookSeats(customer.toString(),
			 * selectedSeats, purchaseTicket.getShowDate(),
			 * purchaseTicket.getShowTime(), purchaseTicket.getHallNo(),
			 * purchaseTicket.getMovie(), purchaseTicket.getMovieFormat());
			 */
			String showDate = null;
			try {
				showDate = new SimpleDateFormat("dd-MMM-yyyy")
						.format(new SimpleDateFormat("dd-MMM-yy").parse(purchaseTicket.getShowDate()));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int ticketId = bookingTicketService.bookSeats(customer.toString(), selectedSeats, showDate,
					purchaseTicket.getShowTime(), purchaseTicket.getHallNo(), purchaseTicket.getMovie(),
					purchaseTicket.getMovieFormat());
			/*
			 * int ticketId =
			 * dbConnector.bookSeats("Abc,abc@mail.com,01727412975",
			 * "U#F14,U#G12,U#G13,U#H13", "23-AUG-2016", "05: 00 PM", 2,
			 * "Independence Day: Resurgence", 2);
			 */
			if (ticketId > 0) {
				Date now = new Date();
				purchaseTicket.setPurchaseTicketId(String.valueOf(ticketId));
				purchaseTicket.setCustomer(customer);
				purchaseTicket.setTotalCost(purchaseTicket.getEachTicketPrice() * purchaseTicket.getNo_of_tickets());
				purchaseTicket.setPurchaseTime((new SimpleDateFormat("hh: mm a").format(now)).toUpperCase());
				purchaseTicket.setPurchaseDate((new SimpleDateFormat("dd-MMM-yy").format(now)).toUpperCase());
				session.setAttribute("bookingStep", String.valueOf(4));
				System.out.println("Ticket is sucessfully purchased");
				String userTicket = request.getContextPath() + "/" + "final_ticket";
				response.sendRedirect(userTicket);
				return;
			} else {
				System.out.println("Sry, purchased isn't occured");
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

	@Override
	public void destroy() {
		bookingTicketService.closeService();
		super.destroy();
	}
}
