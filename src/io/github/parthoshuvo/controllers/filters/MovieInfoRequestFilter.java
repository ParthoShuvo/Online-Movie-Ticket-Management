package io.github.parthoshuvo.controllers.filters;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

public class MovieInfoRequestFilter implements Filter {

	public void destroy() {

	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		String movieName = request.getParameter("movie_name");
		String date = request.getParameter("date");
		System.out.println(movieName);
		if (movieName != null && !movieName.contains(" ") && (movieName.endsWith("_1") || movieName.endsWith("_2"))) {
			if (date == null || (date != null && !date.matches("\\d{2}/\\d{2}/\\d{4}"))) {
				request.setAttribute("date",
						new SimpleDateFormat("dd-MMM-yy").format(new Date()).toString().toUpperCase());
			} else if (date != null) {
				try {
					String givenDate = (new SimpleDateFormat("dd-MMM-yy")
							.format(new SimpleDateFormat("MM/dd/yyyy").parse(request.getParameter("date"))))
									.toUpperCase();
					request.setAttribute("date", givenDate);
				} catch (ParseException e) {
					e.printStackTrace();
					System.out.println("error");
					HttpServletResponse servletResponse = (HttpServletResponse) response;
					servletResponse.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
					servletResponse.sendError(404);
					return;
				}
			}
			request.setAttribute("nowShowingFlag", movieName.charAt(movieName.length() - 1) == '1' ? true : false);
			movieName = (movieName.substring(0, movieName.length() - 2)).replace("^", " ");
			System.out.println(movieName);
			request.setAttribute("movieName", movieName);
			chain.doFilter(request, response);
		} else {
			System.out.println("error");
			HttpServletResponse servletResponse = (HttpServletResponse) response;
			servletResponse.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
			servletResponse.sendError(404);
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {

	}
}
