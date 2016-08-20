package io.github.parthoshuvo.controllers;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import io.github.parthoshuvo.SimpleServlet;
import io.github.parthoshuvo.database.DatabaseConnector;
import io.github.parthoshuvo.dto.Movie;
import io.github.parthoshuvo.dto.MovieShowTimeSchedule;
import io.github.parthoshuvo.service.internal.database_interaction.DatabaseInteractionServiceFactory;
import io.github.parthoshuvo.service.internal.database_interaction.interfaces.MovieInfoService;
import io.github.parthoshuvo.service.internal.database_interaction.interfaces.MovieScheduleService;

public class MovieListControllerServlet extends SimpleServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher requestDispatcher = null;
	private MovieInfoService movieInfoService = null;
	private MovieScheduleService movieScheduleService = null;

	{
		DatabaseInteractionServiceFactory databaseInteractionServiceFactory = new DatabaseInteractionServiceFactory();
		movieInfoService = (MovieInfoService) databaseInteractionServiceFactory
				.getService(DatabaseInteractionServiceFactory.SERVICE_MOVIE_INFO);
		movieInfoService.openService();
		movieScheduleService = (MovieScheduleService) databaseInteractionServiceFactory
				.getService(DatabaseInteractionServiceFactory.SERVICE_MOVIE_SCHEDULE);
		movieScheduleService.openService();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession httpSession = request.getSession(false);
		if (httpSession != null) {
			httpSession.invalidate();
		}
		String requestedURI = new String(request.getRequestURI());
		System.out.println(requestedURI);
		List<Movie> nowShowingMovie = null;
		List<Movie> upComingMovie = null;
		Map<String, String[]> requestParams = request.getParameterMap();
		if (requestParams.isEmpty()) {
			switch (requestedURI) {
			case "/OnlineMovieTicketManagement/movielist":
				nowShowingMovie = movieInfoService.getMovieList(true);
				upComingMovie = movieInfoService.getMovieList(false);
				try {
					respondWithMovieListPageView(nowShowingMovie, upComingMovie, request, response);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				break;
			case "/OnlineMovieTicketManagement/movie-trailer":
				respondWithTrailerView(request, response);
				break;
			case "/OnlineMovieTicketManagement/home":
			case "/OnlineMovieTicketManagement/":
				respondWithHomePageView(request, response);
				break;
			default:
				break;
			}
		} else {
			if (requestParams.containsKey("release-date")) {
				SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
				try {
					Date date = dateFormat.parse(requestParams.get("release-date")[0]);
					dateFormat = new SimpleDateFormat("dd-MMM-yy");
					System.out.println(dateFormat.format(date).toUpperCase());
					nowShowingMovie = movieInfoService.getMovieListBySearch("release-date",
							dateFormat.format(date).toUpperCase());
					System.out.println(nowShowingMovie);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			} else if (requestParams.containsKey("genre")) {
				System.out.println(requestParams.get("genre")[0]);
				nowShowingMovie = movieInfoService.getMovieListBySearch("genre", requestParams.get("genre")[0]);
				System.out.println(nowShowingMovie.size());
			} else if (requestParams.containsKey("maturity")) {
				nowShowingMovie = movieInfoService.getMovieListBySearch("maturity", requestParams.get("maturity")[0]);
			} else if (requestParams.containsKey("search")) {
				System.out.println(requestParams.get("search")[0]);
				nowShowingMovie = movieInfoService.getMovieListBySearch(requestParams.get("search")[0]);
			}
			upComingMovie = movieInfoService.getMovieList(false);
			try {
				respondWithMovieListPageView(nowShowingMovie, upComingMovie, request, response);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		/*
		 * switch (requestedURI) { case "/SimpleJSPProject/movielist":
		 * respondWithMovieListPageView(request, response); break; default:
		 * break; }
		 */
	}

	private void respondWithMovieListPageView(List<Movie> nowShowingMovie, List<Movie> upComingMovie,
			HttpServletRequest request, HttpServletResponse response) throws ParseException {
		/*
		 * List<Movie> nowShowingMovie = dbConnector.getMovieList(true);
		 * List<Movie> upComingMovie = dbConnector.getMovieList(false);
		 */
		List<MovieShowTimeSchedule> dupNowShowingMovie = null;
		if (nowShowingMovie != null && !nowShowingMovie.isEmpty()) {
			dupNowShowingMovie = new ArrayList<>();
			Iterator<Movie> iterator = nowShowingMovie.iterator();
			Date date = new Date();
			while (iterator.hasNext()) {
				Movie movie = iterator.next();
				MovieShowTimeSchedule movieShowTimeSchedule = movieScheduleService
						.getMovieSchedule(movie.getMovieName(), new SimpleDateFormat("dd-MMM-yy").format(date));
				movieShowTimeSchedule.setMovie(movie);
				// iterator.remove();
				dupNowShowingMovie.add(movieShowTimeSchedule);
			}
			System.out.println(dupNowShowingMovie.size());
		}
		request.setAttribute("Now_Showing_Movie_List", dupNowShowingMovie);
		request.setAttribute("Up_Coming_Movie_List", upComingMovie);
		request.setAttribute("validEntry", true);
		requestDispatcher = request.getRequestDispatcher("movie_list_page");
		try {
			requestDispatcher.forward(request, response);
		} catch (ServletException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	private void respondWithTrailerView(HttpServletRequest request, HttpServletResponse response) {
		List<Movie> movieTrailerList = movieInfoService.getLatestMovieTrailers();
		request.setAttribute("Movie_Trailer_List", movieTrailerList);
		request.setAttribute("validEntry", true);
		requestDispatcher = request.getRequestDispatcher("movie_trailer_page");
		try {
			requestDispatcher.forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}

	private void respondWithHomePageView(HttpServletRequest request, HttpServletResponse response) {
		List<Movie> nowShowingMovie = movieInfoService.getMovieList(true);
		List<Movie> upComingMovie = movieInfoService.getMovieList(false);
		/*
		 * dbConnector.bookSeats("hola,hola@gmail.com,12345",
		 * "L#B6,L#C6,L#D6,L#E6,U#F6,U#G6,U#H6,U#H7,U#H8,U#H9,U#H10,U#H11,U#H12,U#H13,U#G13,U#F13,L#E13,L#D13,L#C13,L#B13,U#G7,U#F8,L#E9,L#D10,L#C11,L#B12,L#B7,L#C8,L#D9,L#E10,U#F11,U#G12",
		 * "20-AUG-2016", "11: 40 AM", 5, "Captain America: Civil War", 2);
		 */
		try {
			if (nowShowingMovie != null && !nowShowingMovie.isEmpty() && upComingMovie != null
					&& !upComingMovie.isEmpty()) {
				request.setAttribute("Now_Showing_Movie_List", nowShowingMovie);
				request.setAttribute("Up_Coming_Movie_List", upComingMovie);
				request.setAttribute("validEntry", true);
				requestDispatcher = request.getRequestDispatcher("home_page");
				requestDispatcher.forward(request, response);
			} else {
				NullPointerException exp = new NullPointerException();
				throw exp;
			}
		} catch (ServletException | IOException | NullPointerException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void destroy() {
		movieInfoService.closeService();
		movieScheduleService.closeService();
		super.destroy();
	}

}
