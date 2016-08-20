package io.github.parthoshuvo.service.internal.database_interaction.utility;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import io.github.parthoshuvo.database.DatabaseConnector;
import io.github.parthoshuvo.dto.MovieShowTimeSchedule;
import io.github.parthoshuvo.dto.ShowTime;
import io.github.parthoshuvo.service.internal.database_interaction.interfaces.MovieScheduleService;
import oracle.jdbc.internal.OracleTypes;

public class MovieScheduleServiceUtility extends DatabaseServiceUtility implements MovieScheduleService {

	public MovieScheduleServiceUtility(DatabaseConnector dbConnector) {
		super(dbConnector);

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

	@Override
	public MovieShowTimeSchedule getMovieSchedule(String movieName, String date) throws ParseException {
		List<ShowTime> showTime2D = null;
		List<ShowTime> showTime3D = null;
		MovieShowTimeSchedule movieShowTimeSchedule = new MovieShowTimeSchedule();
		String statement = "{ call P_GET_SCHEDULE.FOR_MOVIE('" + movieName + "', '" + date + "', ?)}";
		try {
			getDbConnector().createCallableStatement(statement);
			CallableStatement callableStatement = getDbConnector().getCallableStatement();
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
			getDbConnector().closeCallableStatement();
		} catch (SQLException e) {
			e.printStackTrace();
			showTime2D = null;
			showTime3D = null;
		}
		movieShowTimeSchedule.setShowTime2D(showTime2D);
		movieShowTimeSchedule.setShowTime3D(showTime3D);
		return movieShowTimeSchedule;
	}

	@Override
	public boolean isMoviePlaying(String movieName, String showDate, String showTime, int movieFormat, int hallNo) {
		String statement = "{ ? = call about_movies.is_movie_playing( '" + movieName + "', '" + showDate + "', '"
				+ showTime + "', " + movieFormat + ", " + hallNo + ")}";
		boolean isPlaying = false;
		try {
			getDbConnector().createCallableStatement(statement);
			CallableStatement callableStatement = getDbConnector().getCallableStatement();
			callableStatement.registerOutParameter(1, OracleTypes.NUMBER);
			callableStatement.execute();
			int result = callableStatement.getInt(1);
			isPlaying = result == 1 ? true : false;
			System.out.println("movie is playing");
			getDbConnector().closeCallableStatement();
		} catch (SQLException e) {
			e.printStackTrace();
			isPlaying = false;
		}
		return isPlaying;
	}

	@Override
	public boolean isMoviePlaying(String movieName, String showDate, String showTime, int movieFormat, int hallNo,
			int category) {
		String statement = "{ ? = call about_movies.is_movie_playing( '" + movieName + "', '" + showDate + "', '"
				+ showTime + "', " + movieFormat + ", " + hallNo + ", " + category + ")}";
		boolean isPlaying = false;
		try {
			getDbConnector().createCallableStatement(statement);
			CallableStatement callableStatement = getDbConnector().getCallableStatement();
			callableStatement.registerOutParameter(1, OracleTypes.NUMBER);
			callableStatement.execute();
			int result = callableStatement.getInt(1);
			isPlaying = result == 1 ? true : false;
			System.out.println("movie is playing");
			getDbConnector().closeCallableStatement();
		} catch (SQLException e) {
			e.printStackTrace();
			isPlaying = false;
		}
		System.out.println(isPlaying);
		return isPlaying;
	}
}
