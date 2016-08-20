package io.github.parthoshuvo.controllers;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import io.github.parthoshuvo.SimpleServlet;
import io.github.parthoshuvo.dto.Movie;
import io.github.parthoshuvo.dto.MovieShowTimeSchedule;
import io.github.parthoshuvo.service.internal.database_interaction.DatabaseInteractionServiceFactory;
import io.github.parthoshuvo.service.internal.database_interaction.interfaces.MovieInfoService;
import io.github.parthoshuvo.service.internal.database_interaction.interfaces.MovieScheduleService;

public class MovieInfoControllerServlet extends SimpleServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher requestDispatcher = null;
	MovieInfoService movieInfoService = null;

	{
		movieInfoService = (MovieInfoService) new DatabaseInteractionServiceFactory()
				.getService(DatabaseInteractionServiceFactory.SERVICE_MOVIE_INFO);
		movieInfoService.openService();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession httpSession = request.getSession(false);
		if (httpSession != null) {
			httpSession.invalidate();
		}
		MovieInfoService movieInfoService = (MovieInfoService) new DatabaseInteractionServiceFactory()
				.getService(DatabaseInteractionServiceFactory.SERVICE_MOVIE_INFO);
		String movieName = (String) request.getAttribute("movieName");
		boolean nowShowingFlag = (boolean) request.getAttribute("nowShowingFlag");
		Movie movie = movieInfoService.getMovieInfo(movieName, nowShowingFlag);
		try {
			respondWithMovieInfoPageView(movie, request, response);
		} catch (ParseException e) {
			e.printStackTrace();
		}

	}

	private void respondWithMovieInfoPageView(Movie movie, HttpServletRequest request, HttpServletResponse response)
			throws ParseException, NullPointerException {
		MovieShowTimeSchedule movieShowTimeSchedule = null;
		if (movie != null) {
			MovieScheduleService movieScheduleService = (MovieScheduleService) new DatabaseInteractionServiceFactory()
					.getService(DatabaseInteractionServiceFactory.SERVICE_MOVIE_SCHEDULE);
			String showDate = (String) request.getAttribute("date");
			movieShowTimeSchedule = movieScheduleService.getMovieSchedule(movie.getMovieName(), showDate);
			movieShowTimeSchedule.setShowDate(new SimpleDateFormat("dd-MMM-yy").parse(showDate));
			System.out.println(showDate);
			System.out.println(movieShowTimeSchedule.getShowTime2D());
			System.out.println(movieShowTimeSchedule.getShowTime3D());
			movieShowTimeSchedule.setMovie(movie);

		} else {
			NullPointerException exception = new NullPointerException();
			throw exception;
		}
		request.setAttribute("movie_info", movieShowTimeSchedule);
		request.setAttribute("validEntry", true);
		requestDispatcher = request.getRequestDispatcher("movie_page");
		try {
			requestDispatcher.forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void destroy() {
		movieInfoService.closeService();
		super.destroy();
	}
}
