package io.github.parthoshuvo.controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import io.github.parthoshuvo.SimpleServlet;
import io.github.parthoshuvo.database.DatabaseConnector;
import io.github.parthoshuvo.dto.Movie;


@WebServlet(description = "This servlet controller manages trailers of the movies", urlPatterns = { "/movie_trailer" })
public class TrailerControllerServlet extends SimpleServlet {
	private static final long serialVersionUID = 1L;
	private DatabaseConnector dbConnector = null;
	private RequestDispatcher requestDispatcher = null;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession httpSession = request.getSession(false);
		if (httpSession != null) {
			httpSession.invalidate();
		}
		dbConnector = getDatabaseConnectorInstance();
		String requestedURI = new String(request.getRequestURI());
		/* System.out.println(requestedURI); */
		switch (requestedURI) {
		case "/SimpleJSPProject/movie_trailer":
			System.out.print("Hello");
			respondWithTrailerView(request, response);
			break;
		case "/OnlineMovieTicketManagement/":
		case "/OnlineMovieTicketManagement/home":
			respondWithHomePageView(request, response);
			break;
		case "/OnlineMovieTicketManagement/movielist":
			respondWithMovieListPageView(request, response);
			break;
		default:
			break;
		}

		/* System.out.println(movieTrailerList.size()); */

	}

	private void respondWithTrailerView(HttpServletRequest request, HttpServletResponse response) {
		List<Movie> movieTrailerList = dbConnector.getLatestMovieTrailers();
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
		List<Movie> nowShowingMovie = dbConnector.getMovieList(true);
		List<Movie> upComingMovie = dbConnector.getMovieList(false);
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

	private void respondWithMovieListPageView(HttpServletRequest request, HttpServletResponse response) {
		List<Movie> nowShowingMovie = dbConnector.getMovieList(true);
		List<Movie> upComingMovie = dbConnector.getMovieList(false);
		try {
			if (nowShowingMovie != null && !nowShowingMovie.isEmpty() && upComingMovie != null
					&& !upComingMovie.isEmpty()) {
				request.setAttribute("Now_Showing_Movie_List", nowShowingMovie);
				request.setAttribute("Up_Coming_Movie_List", upComingMovie);
				request.setAttribute("validEntry", true);
				requestDispatcher = request.getRequestDispatcher("movie_list_page");
				requestDispatcher.forward(request, response);
			} else {
				NullPointerException exp = new NullPointerException();
				throw exp;
			}
		} catch (ServletException | IOException | NullPointerException e) {
			e.printStackTrace();
		}
	}

}
