package io.github.parthoshuvo.service.internal.database_interaction.interfaces;

import java.util.List;
import java.util.Map;

public interface BookingTicketService extends DatabaseInteractionService {
	public boolean isHouseFull(String showDate, String showTime, int hallNo);

	public Map<String, Double> getBookedSeatsWithPrices(int hallNo, String showDate, String showTime, int movieFormat);

	public List<String> getBookedSeats(String movieName, int format, String showDate, String showTime);

	public boolean areSeatsAvailable(String showDate, String showTime, int hallNo, String seatNoList);

	public boolean isSeatAvailable(String showDate, String showTime, int hallNo, String seatNo);

	public int bookSeats(String customerData, String seatsToBook, String showDate, String showTime, int hallNo,
			String movieName, int movieFormat);

	public double getTicketPrice(int hallNo, int format);
}
