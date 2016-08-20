package io.github.parthoshuvo.service.internal.database_interaction.utility;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import io.github.parthoshuvo.database.DatabaseConnector;
import io.github.parthoshuvo.service.internal.database_interaction.interfaces.BookingTicketService;
import oracle.jdbc.internal.OracleTypes;

public class BookingTicketServiceUtility extends DatabaseServiceUtility implements BookingTicketService {

	public BookingTicketServiceUtility(DatabaseConnector dbConnector) {
		super(dbConnector);
	}

	@Override
	public boolean isHouseFull(String showDate, String showTime, int hallNo) {
		String statement = "{ call seat_booking.is_hall_full( '" + showDate + "', '" + showTime + "', " + hallNo
				+ ", ?)}";
		boolean isHouseFull = false;
		try {
			getDbConnector().createCallableStatement(statement);
			CallableStatement callableStatement = getDbConnector().getCallableStatement();
			callableStatement.registerOutParameter(1, OracleTypes.NUMBER);
			callableStatement.execute();
			int result = callableStatement.getInt(1);
			isHouseFull = result == 1 ? true : false;
			getDbConnector().closeCallableStatement();
		} catch (SQLException e) {
			e.printStackTrace();
			isHouseFull = false;
		}
		return isHouseFull;
	}

	@Override
	public Map<String, Double> getBookedSeatsWithPrices(int hallNo, String showDate, String showTime, int movieFormat) {
		String statement = "{ call seat_booking.get_booked_seats_with_prices( " + hallNo + ", '" + showDate + "', '"
				+ showTime + "', " + movieFormat + ", ?)}";
		Map<String, Double> seatPriceMap = null;
		try {
			getDbConnector().createCallableStatement(statement);
			CallableStatement callableStatement = getDbConnector().getCallableStatement();
			callableStatement.registerOutParameter(1, OracleTypes.CURSOR);
			callableStatement.execute();
			ResultSet rs = (ResultSet) callableStatement.getObject(1);
			if (rs != null) {
				seatPriceMap = new LinkedHashMap<>();
				while (rs.next()) {
					/*
					 * System.out.println("\t\t#Seat: " + rs.getString("SEATNO")
					 * + " | Price: " + rs.getString("PRICE"));
					 */
					seatPriceMap.put(rs.getString("SEATNO"), rs.getDouble("PRICE"));
				}
			}
			rs.close();
			callableStatement.close();
		} catch (SQLException e) {
			e.printStackTrace();
			seatPriceMap = null;
		}
		return seatPriceMap;
	}

	@Override
	public List<String> getBookedSeats(String movieName, int format, String showDate, String showTime) {
		String statement = "{ call seat_booking.get_booked_seats( '" + movieName + "', " + format + ", '" + showDate
				+ "', '" + showTime + "', ?)}";
		List<String> seatList = null;
		try {
			getDbConnector().createCallableStatement(statement);
			CallableStatement callableStatement = getDbConnector().getCallableStatement();
			callableStatement.registerOutParameter(1, OracleTypes.CURSOR);
			callableStatement.execute();
			ResultSet rs = (ResultSet) callableStatement.getObject(1);
			if (rs != null) {
				seatList = new ArrayList<>();
				while (rs.next()) {
					seatList.add(rs.getString("SEATNO"));
				}
			}
			rs.close();
			callableStatement.close();
		} catch (SQLException e) {
			e.printStackTrace();
			seatList = null;
		}
		return seatList;
	}

	@Override
	public boolean areSeatsAvailable(String showDate, String showTime, int hallNo, String seatNoList) {
		String statement = "{ call seat_booking.are_seats_available( '" + showDate + "', '" + showTime + "', " + hallNo
				+ ", '" + seatNoList + "', ?, ?)}";
		boolean areAvailable = false;
		try {
			getDbConnector().createCallableStatement(statement);
			CallableStatement callableStatement = getDbConnector().getCallableStatement();
			callableStatement.registerOutParameter(1, OracleTypes.NUMBER);
			callableStatement.registerOutParameter(2, OracleTypes.VARCHAR);
			callableStatement.execute();
			/*
			 * System.out.println("The seats you queried for:\n" + seatNoList);
			 * System.out.println((call.getInt(1) == 1) ? "<<Available>>" :
			 * "<<Not available>>\nSeats that were already booked:\n" +
			 * call.getString(2));
			 */
			areAvailable = callableStatement.getInt(1) == 1 ? true : false;
			callableStatement.close();
		} catch (SQLException e) {
			e.printStackTrace();
			areAvailable = false;
		}
		/*
		 * System.out.println(areAvailable);
		 */ return areAvailable;
	}

	@Override
	public boolean isSeatAvailable(String showDate, String showTime, int hallNo, String seatNo) {
		String statement = "{ call seat_booking.are_seats_available( '" + showDate + "', '" + showTime + "', " + hallNo
				+ ", '" + seatNo + "', ?, ?)}";
		boolean isAvailable = false;
		try {
			getDbConnector().createCallableStatement(statement);
			CallableStatement callableStatement = getDbConnector().getCallableStatement();
			callableStatement.registerOutParameter(1, OracleTypes.NUMBER);
			callableStatement.registerOutParameter(2, OracleTypes.VARCHAR);
			callableStatement.execute();
			/*
			 * System.out.println((call.getInt(1) == 1) ? "Available." :
			 * "Not availabe.");
			 */
			isAvailable = callableStatement.getInt(1) == 1 ? true : false;
			callableStatement.close();
		} catch (SQLException e) {
			e.printStackTrace();
			isAvailable = false;
		}
		return isAvailable;
	}

	@Override
	public int bookSeats(String customerData, String seatsToBook, String showDate, String showTime, int hallNo,
			String movieName, int movieFormat) {
		System.out.println("Customer Data" + customerData);
		System.out.println("Resuested Seats" + seatsToBook);
		System.out.println("Show Date" + showDate);
		System.out.println("Show Time" + showTime);
		System.out.println("Hall" + hallNo);
		System.out.println("movie name" + movieName);
		System.out.println("format" + movieFormat);
		int purchaseId = 0;
		String statement = "{ call seat_booking.book_seats( '" + customerData + "'," + " '" + seatsToBook + "'," + " '"
				+ showDate + "'," + " '" + showTime + "'," + " " + hallNo + "," + " '" + movieName + "'," + " "
				+ movieFormat + "," + " ?)}";
		try {
			getDbConnector().createCallableStatement(statement);
			CallableStatement callableStatement = getDbConnector().getCallableStatement();
			/*
			 * seat_booking.book_seats(cust_data =>
			 * 'auzchowdhury,auzchowdhury@Gmail.com,02557446802', seats_list =>
			 * 'LE36,UB15,LA51', show_date => '31-JUL-2016', show_time => '05:
			 * 00 PM', hall_no => 5, movie_id => 6, movie_format => 3,
			 * p_new_purchase_id => l_id);
			 */

			callableStatement.registerOutParameter(1, OracleTypes.INTEGER);
			callableStatement.execute();
			purchaseId = callableStatement.getInt(1);
			System.out.println("New PurchaseID: " + callableStatement.getInt(1));
			callableStatement.close();
		} catch (SQLException e) {
			purchaseId = 0;
			System.out.println(e.getLocalizedMessage());
		}
		return purchaseId;
	}

	@Override
	public double getTicketPrice(int hallNo, int format) {
		String statement = "{ call seat_booking.get_ticket_price( " + hallNo + ", " + format + ", ?)}";
		double ticketPrice = 0.0;
		try {
			getDbConnector().createCallableStatement(statement);
			CallableStatement callableStatement = getDbConnector().getCallableStatement();
			callableStatement.registerOutParameter(1, OracleTypes.NUMBER);
			callableStatement.execute();
			ticketPrice = callableStatement.getDouble(1);
			System.out.println("Price:\t" + ticketPrice);
		} catch (SQLException e) {
			printSQLERRM(e);
			ticketPrice = 0.0;
		} catch (Exception e) {
			System.out.println(e.getLocalizedMessage());
			ticketPrice = 0.0;
		}
		return ticketPrice;
	}

	@Override
	public boolean openService() {
		getDbConnector().createConnection();
		return false;
	}

	@Override
	public boolean closeService() {
		getDbConnector().closeConnection();
		return false;
	}

}
