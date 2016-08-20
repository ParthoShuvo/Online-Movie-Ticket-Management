package io.github.parthoshuvo.service.internal.database_interaction.utility;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import io.github.parthoshuvo.database.DatabaseConnector;
import io.github.parthoshuvo.dto.Movie;
import io.github.parthoshuvo.service.internal.database_interaction.interfaces.MovieInfoService;
import oracle.jdbc.internal.OracleTypes;

public class MovieInfoServiceUtility extends DatabaseServiceUtility implements MovieInfoService {

	public MovieInfoServiceUtility(DatabaseConnector dbConnector) {
		super(dbConnector);
	}

	@Override
	public List<Movie> getLatestMovieTrailers() {
		List<Movie> movieTrailerList = null;
		String statement = "{ ? = call GET_LATEST_MOVIE_TRAILERS()}";
		try {
			getDbConnector().createCallableStatement(statement);
			CallableStatement callableStatement = getDbConnector().getCallableStatement();
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
			getDbConnector().closeCallableStatement();
		} catch (SQLException e) {
			e.printStackTrace();
			movieTrailerList = null;
		}
		return movieTrailerList;
	}

	@Override
	public List<Movie> getMovieList(boolean nowShowingFlag) {
		List<Movie> movieList = null;
		String statement = "BEGIN get_movie_list(?, ?); END;";
		try {
			getDbConnector().createCallableStatement(statement);
			CallableStatement callableStatement = getDbConnector().getCallableStatement();
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
			getDbConnector().closeCallableStatement();
		} catch (SQLException e) {
			e.printStackTrace();
			movieList = null;
		}
		return movieList;
	}

	@Override
	public Movie getMovieInfo(String movieName, boolean nowShowingFlag) {
		Movie movie = null;
		String statement = "BEGIN get_movie_info(?, ?); END;";
		try {
			getDbConnector().createCallableStatement(statement);
			CallableStatement callableStatement = getDbConnector().getCallableStatement();
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
			getDbConnector().closeCallableStatement();
		} catch (SQLException e) {
			e.printStackTrace();
			movie = null;
		}
		return movie;
	}

	@Override
	public List<Movie> getMovieListBySearch(String searchWord) {
		List<Movie> movieList = null;
		String statement = "{ call search_movies.GET_MOVIES( '" + searchWord + "', ?)}";
		try {
			getDbConnector().createCallableStatement(statement);
			CallableStatement callableStatement = getDbConnector().getCallableStatement();
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
			getDbConnector().closeCallableStatement();
		} catch (SQLException e) {
			e.printStackTrace();
			movieList = null;
		}
		return movieList;
	}

	@Override
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
			getDbConnector().createCallableStatement(statement);
			CallableStatement callableStatement = getDbConnector().getCallableStatement();
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
			getDbConnector().closeCallableStatement();
		} catch (SQLException e) {
			e.printStackTrace();
			movieList = null;
		}
		return movieList;
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
