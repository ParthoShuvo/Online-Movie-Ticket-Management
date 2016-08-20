package io.github.parthoshuvo.database;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import io.github.parthoshuvo.dto.Movie;
import io.github.parthoshuvo.dto.MovieShowTimeSchedule;
import io.github.parthoshuvo.dto.ShowTime;
import oracle.jdbc.internal.OracleTypes;

public class DatabaseConnector {

	private final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private final String USER = "MOVIE";
	private final String PASSWD = "MOVIE";
	private Connection connection;
	private CallableStatement callableStatement;

	protected DatabaseConnector() {

	}

	private static class LazyLoader {
		private static final DatabaseConnector database_connector = new DatabaseConnector();
	}

	public static DatabaseConnector getInstance() {
		return LazyLoader.database_connector;
	}

	/**
	 * create
	 * 
	 * @return
	 */
	public boolean createConnection() {
		boolean res = false;
		try {
			connection = connection == null ? DriverManager.getConnection(URL, USER, PASSWD) : connection;
			res = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			res = false;
		}
		return res;
	}

	/**
	 * close connection
	 * 
	 * @return
	 */
	public boolean closeConnection() {
		boolean res = false;
		try {
			if (connection != null) {
				connection.close();
				res = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			res = false;

		}
		return res;
	}

	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public CallableStatement getCallableStatement() {
		return callableStatement;
	}

	public List<Movie> getLatestMovieTrailers() {
		List<Movie> movieTrailerList = null;
		String statement = "{ ? = call GET_LATEST_MOVIE_TRAILERS()}";
		try {
			createCallableStatement(statement);
			callableStatement.registerOutParameter(1, OracleTypes.CURSOR);
			callableStatement.execute();
			ResultSet resultSet = (ResultSet) callableStatement.getObject(1);
			if (resultSet != null) {
				movieTrailerList = new ArrayList<>();
				while (resultSet.next()) {
					Movie movie = new Movie();
					movie.setMovieName(resultSet.getString("MOVIENAME"));
					movie.setTrailer(resultSet.getString("TRAILER"));
					movie.setImage(resultSet.getString("IMAGE"));
					movieTrailerList.add(movie);
				}
			}
			resultSet.close();
			closeCallableStatement();
		} catch (SQLException e) {
			e.printStackTrace();
			movieTrailerList = null;
		}
		return movieTrailerList;
	}

	public void closeCallableStatement() throws SQLException {
		if (!callableStatement.isClosed()) {
			callableStatement.clearBatch();
			callableStatement.close();
		}

	}

	public void createCallableStatement(String statement) throws SQLException {
		callableStatement = connection.prepareCall(statement);
	}

	public List<Movie> getMovieList(boolean nowShowingFlag) {
		List<Movie> movieList = null;
		String statement = "BEGIN get_movie_list(?, ?); END;";
		try {
			createCallableStatement(statement);
			callableStatement.setInt(1, (nowShowingFlag) ? 1 : 0);
			callableStatement.registerOutParameter(2, OracleTypes.CURSOR);
			callableStatement.execute();
			ResultSet resultSet = (ResultSet) callableStatement.getObject(2);
			if (resultSet != null) {
				movieList = new ArrayList<>();
				while (resultSet.next()) {
					Movie movie = new Movie();
					movie.setMovieName(resultSet.getString("MOVIENAME"));
					movie.setGenre(resultSet.getInt("GENRE"));
					movie.setMaturity(resultSet.getString("MATURITY"));
					movie.setTrailer(resultSet.getString("TRAILER"));
					movie.setImage(resultSet.getString("IMAGE"));
					movie.setReleaseDate(resultSet.getTimestamp("RELEASEDATE").getTime());
					movie.setDuration(resultSet.getInt("DURATION"));
					movieList.add(movie);
				}
			}
			resultSet.close();
			closeCallableStatement();
		} catch (SQLException e) {
			e.printStackTrace();
			movieList = null;
		}
		return movieList;
	}

	public Movie getMovieInfo(String movieName, boolean nowShowingFlag) {
		Movie movie = null;
		String statement = "BEGIN get_movie_info(?, ?); END;";
		try {
			createCallableStatement(statement);
			callableStatement.setNString(1, movieName);
			callableStatement.registerOutParameter(2, OracleTypes.CURSOR);
			callableStatement.execute();
			ResultSet resultSet = (ResultSet) callableStatement.getObject(2);
			if (resultSet != null) {
				movie = new Movie();
				while (resultSet.next()) {
					movie.setMovieName(resultSet.getString("MOVIENAME"));
					movie.setGenre(resultSet.getInt("GENRE"));
					movie.setMaturity(resultSet.getString("MATURITY"));
					movie.setTrailer(resultSet.getString("TRAILER"));
					movie.setImage(resultSet.getString("IMAGE"));
					movie.setReleaseDate(resultSet.getTimestamp("RELEASEDATE").getTime());
					movie.setDuration(resultSet.getInt("DURATION"));
					movie.setNowShowingFlag(nowShowingFlag);
					movie.setSummary(resultSet.getString("SUMMARY"));
				}
			}
			resultSet.close();
			closeCallableStatement();
		} catch (SQLException e) {
			e.printStackTrace();
			movie = null;
		}
		return movie;
	}

	public List<Movie> getMovieListBySearch(String searchWord) {
		List<Movie> movieList = null;
		String statement = "{ call search_movies.GET_MOVIES( '" + searchWord + "', ?)}";
		try {
			createCallableStatement(statement);
			callableStatement.registerOutParameter(1, OracleTypes.CURSOR);
			callableStatement.execute();
			ResultSet resultSet = (ResultSet) callableStatement.getObject(1);
			if (resultSet != null) {
				movieList = new ArrayList<>();
				while (resultSet.next()) {
					Movie movie = new Movie();
					movie.setMovieName(resultSet.getString("MOVIENAME"));
					movie.setGenre(resultSet.getInt("GENRE"));
					movie.setMaturity(resultSet.getString("MATURITY"));
					movie.setTrailer(resultSet.getString("TRAILER"));
					movie.setImage(resultSet.getString("IMAGE"));
					movie.setReleaseDate(resultSet.getTimestamp("RELEASEDATE").getTime());
					movie.setDuration(resultSet.getInt("DURATION"));
					movieList.add(movie);
				}
			}
			resultSet.close();
			closeCallableStatement();
		} catch (SQLException e) {
			e.printStackTrace();
			movieList = null;
		}
		return movieList;
	}

	public List<Movie> getMovieListBySearch(String searchKey, String searchValue) {
		List<Movie> movieList = null;
		String statement = null;
		switch (searchKey) {
		case "release-date":
		case "maturity":
			statement = "{ call search_movies.GET_MOVIES('" + searchValue + "', '" + searchKey + "', ?)}";
			break;
		case "release-year":
		case "genre":
			statement = "{ call search_movies.GET_MOVIES(" + searchValue + ", '" + searchKey + "', ?)}";
			break;
		default:
			break;
		}
		try {
			createCallableStatement(statement);
			callableStatement.registerOutParameter(1, OracleTypes.CURSOR);
			callableStatement.execute();
			ResultSet resultSet = (ResultSet) callableStatement.getObject(1);
			if (resultSet != null) {
				movieList = new ArrayList<>();
				while (resultSet.next()) {
					Movie movie = new Movie();
					movie.setMovieName(resultSet.getString("MOVIENAME"));
					movie.setGenre(resultSet.getInt("GENRE"));
					movie.setMaturity(resultSet.getString("MATURITY"));
					movie.setTrailer(resultSet.getString("TRAILER"));
					movie.setImage(resultSet.getString("IMAGE"));
					movie.setReleaseDate(resultSet.getTimestamp("RELEASEDATE").getTime());
					movie.setDuration(resultSet.getInt("DURATION"));
					movieList.add(movie);
				}
			}
			resultSet.close();
			closeCallableStatement();
		} catch (SQLException e) {
			e.printStackTrace();
			movieList = null;
		}
		return movieList;
	}

	public MovieShowTimeSchedule getMovieSchedule(String movieName, String date) throws ParseException {
		List<ShowTime> showTime2D = null;
		List<ShowTime> showTime3D = null;
		MovieShowTimeSchedule movieShowTimeSchedule = new MovieShowTimeSchedule();
		String statement = "{ call P_GET_SCHEDULE.FOR_MOVIE('" + movieName + "', '" + date + "', ?)}";
		try {
			createCallableStatement(statement);
			callableStatement.registerOutParameter(1, OracleTypes.CURSOR);
			callableStatement.execute();
			ResultSet resultSet = (ResultSet) callableStatement.getObject(1);
			if (resultSet != null) {
				while (resultSet.next()) {
					ShowTime showTime = new ShowTime();
					showTime.setMovieName(movieName);
					DateFormat dateFormat = new SimpleDateFormat("dd-MMM-yy");
					showTime.setDate(dateFormat.parse(date));
					showTime.setFormat(resultSet.getInt("FORMAT"));
					showTime.setHallNo(resultSet.getInt("HALLNO"));
					showTime.setCategory(resultSet.getInt("CATEGORY"));
					showTime.setTime(resultSet.getString("SHOWTIME"));
					if (showTime.getFormat() == 2) {
						showTime2D = showTime2D == null ? new ArrayList<>() : showTime2D;
						showTime2D.add(showTime);
						System.out.println(showTime2D.size());
					} else {
						showTime3D = showTime3D == null ? new ArrayList<>() : showTime3D;
						showTime3D.add(showTime);
					}
				}
			}
			resultSet.close();
			closeCallableStatement();
		} catch (SQLException e) {
			e.printStackTrace();
			showTime2D = null;
			showTime3D = null;
		}
		movieShowTimeSchedule.setShowTime2D(showTime2D);
		movieShowTimeSchedule.setShowTime3D(showTime3D);
		return movieShowTimeSchedule;
	}

	public boolean isMoviePlaying(String movieName, String showDate, String showTime, int movieFormat, int hallNo) {
		String statement = "{ ? = call about_movies.is_movie_playing( '" + movieName + "', '" + showDate + "', '"
				+ showTime + "', " + movieFormat + ", " + hallNo + ")}";
		boolean isPlaying = false;
		try {
			createCallableStatement(statement);
			callableStatement.registerOutParameter(1, OracleTypes.NUMBER);
			callableStatement.execute();
			int result = callableStatement.getInt(1);
			isPlaying = result == 1 ? true : false;
			System.out.println("movie is playing");
			closeCallableStatement();
		} catch (SQLException e) {
			e.printStackTrace();
			isPlaying = false;
		}
		return isPlaying;
	}

	public boolean isMoviePlaying(String movieName, String showDate, String showTime, int movieFormat, int hallNo,
			int category) {
		String statement = "{ ? = call about_movies.is_movie_playing( '" + movieName + "', '" + showDate + "', '"
				+ showTime + "', " + movieFormat + ", " + hallNo + ", " + category + ")}";
		boolean isPlaying = false;
		try {
			createCallableStatement(statement);
			callableStatement.registerOutParameter(1, OracleTypes.NUMBER);
			callableStatement.execute();
			int result = callableStatement.getInt(1);
			isPlaying = result == 1 ? true : false;
			System.out.println("movie is playing");
			closeCallableStatement();
		} catch (SQLException e) {
			e.printStackTrace();
			isPlaying = false;
		}
		System.out.println(isPlaying);
		return isPlaying;
	}

	public boolean isHouseFull(String showDate, String showTime, int hallNo) {
		String statement = "{ call seat_booking.is_hall_full( '" + showDate + "', '" + showTime + "', " + hallNo
				+ ", ?)}";
		boolean isHouseFull = false;
		try {
			createCallableStatement(statement);
			callableStatement.registerOutParameter(1, OracleTypes.NUMBER);
			callableStatement.execute();
			int result = callableStatement.getInt(1);
			isHouseFull = result == 1 ? true : false;
			closeCallableStatement();
		} catch (SQLException e) {
			e.printStackTrace();
			isHouseFull = false;
		}
		return isHouseFull;
	}

	public Map<String, Double> getBookedSeatsWithPrices(int hallNo, String showDate, String showTime, int movieFormat) {
		String statement = "{ call seat_booking.get_booked_seats_with_prices( " + hallNo + ", '" + showDate + "', '"
				+ showTime + "', " + movieFormat + ", ?)}";
		Map<String, Double> seatPriceMap = null;
		try {
			createCallableStatement(statement);
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

	public List<String> getBookedSeats(String movieName, int format, String showDate, String showTime) {
		String statement = "{ call seat_booking.get_booked_seats( '" + movieName + "', " + format + ", '" + showDate
				+ "', '" + showTime + "', ?)}";
		List<String> seatList = null;
		try {
			createCallableStatement(statement);
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

	public boolean areSeatsAvailable(String showDate, String showTime, int hallNo, String seatNoList) {
		String statement = "{ call seat_booking.are_seats_available( '" + showDate + "', '" + showTime + "', " + hallNo
				+ ", '" + seatNoList + "', ?, ?)}";
		boolean areAvailable = false;
		try {
			createCallableStatement(statement);
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

	public boolean isSeatAvailable(String showDate, String showTime, int hallNo, String seatNo) {
		String statement = "{ call seat_booking.are_seats_available( '" + showDate + "', '" + showTime + "', " + hallNo
				+ ", '" + seatNo + "', ?, ?)}";
		boolean isAvailable = false;
		try {
			createCallableStatement(statement);
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
			createCallableStatement(statement);
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

	public void getReflectedRow(String tableName, String inputData) {
		try {
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "MOVIE", "MOVIE");
			CallableStatement call = null;
			call = conn.prepareCall("{ call edit_data.get_reflection( '" + tableName + "', '" + inputData + "', ?)}");
			call.registerOutParameter(1, OracleTypes.CURSOR);
			call.execute();
			ResultSet rs = (ResultSet) call.getObject(1);
			while (rs.next()) {
				System.out.println("New Entry:\nID: " + rs.getString("CUSTOMERID") + " Name: " + rs.getString("NAME")
						+ " Email: " + rs.getString("EMAILID") + " Phone: " + rs.getString("PHONE"));
			}
			rs.close();
			call.close();
			conn.close();
		} catch (SQLException e) {
			printSQLERRM(e);
		} catch (Exception e) {
			System.out.println(e.getLocalizedMessage());
		}

	}

	public void instertRow(String tableName, String inputData) {
		try {
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "MOVIE", "MOVIE");
			CallableStatement call = null;
			call = conn.prepareCall("{ call edit_data.insert_row( '" + tableName + "', '" + inputData + "', ?)}");
			call.registerOutParameter(1, OracleTypes.CURSOR);
			call.execute();
			ResultSet rs = (ResultSet) call.getObject(1);
			while (rs.next()) {
				System.out.println("New Entry:\nID: " + rs.getString("CUSTOMERID") + " Name: " + rs.getString("NAME")
						+ " Email: " + rs.getString("EMAILID") + " Phone: " + rs.getString("PHONE"));
			}
			rs.close();
			call.close();
			conn.close();
		} catch (SQLException e) {
			printSQLERRM(e);
		} catch (Exception e) {
			System.out.println(e.getLocalizedMessage());
		}

	}

	public void printSQLERRM(SQLException e) {
		if (e.getErrorCode() == 00001)
			System.out.println("ORA-00001: unique constraint (MOVIE.SYS_C007563) violated");
		else if (e.getErrorCode() == 20007)
			System.out.println("ORA-20007: There is more or less than enough data for inserting into CUSTOMERS table.");
		else
			System.out.println(e.getMessage());

	}

	public double getTicketPrice(int hallNo, int format) {
		String statement = "{ call seat_booking.get_ticket_price( " + hallNo + ", " + format + ", ?)}";
		double ticketPrice = 0.0;
		try {
			createCallableStatement(statement);
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

}
