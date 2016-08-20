package io.github.parthoshuvo.controllers.filters;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import io.github.parthoshuvo.database.DatabaseConnector;
import io.github.parthoshuvo.dto.PurchaseTicket;
import io.github.parthoshuvo.service.internal.database_interaction.DatabaseInteractionServiceFactory;
import io.github.parthoshuvo.service.internal.database_interaction.interfaces.BookingTicketService;

@WebFilter("/PurchaseTicketRequestFilter")
public class PurchaseTicketRequestFilter implements Filter {
	private BookingTicketService bookingTicketService = null;

	public void destroy() {
		bookingTicketService.closeService();
	}

	{

		bookingTicketService = (BookingTicketService) new DatabaseInteractionServiceFactory()
				.getService(DatabaseInteractionServiceFactory.SERVICE_BOOKING_TICKET);
		bookingTicketService.openService();
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletResponse httpServletResponse = (HttpServletResponse) response;
		String userName = request.getParameter("user-name");
		String userEmail = request.getParameter("user-email");
		String userPhone = request.getParameter("user-phone");
		HttpSession session = ((HttpServletRequest) request).getSession(false);
		PurchaseTicket purchaseTicket = (PurchaseTicket) session.getAttribute("purchaseTicket");
		String selectedSeats = (String) session.getAttribute("selectedSeats");
		if (((HttpServletRequest) request).getMethod().equals("POST") && session != null && purchaseTicket != null
				&& session.getAttribute("bookingStep").equals("3")) {
			if (bookingTicketService.areSeatsAvailable(purchaseTicket.getShowDate(), purchaseTicket.getShowTime(),
					purchaseTicket.getHallNo(), selectedSeats)) {
				chain.doFilter(request, response);
			} else {
				System.out.println("error");
				httpServletResponse.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
				httpServletResponse.sendError(404);
			}
			return;
		} else {
			System.out.println("error");
			httpServletResponse.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
			httpServletResponse.sendError(404);
			return;
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
