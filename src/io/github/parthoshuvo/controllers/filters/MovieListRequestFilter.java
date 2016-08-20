package io.github.parthoshuvo.controllers.filters;

import java.io.IOException;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MovieListRequestFilter implements Filter {

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		Map<String, String[]> requestParams = request.getParameterMap();
		HttpServletResponse servletResponse = (HttpServletResponse) response;
		if (requestParams.isEmpty()) {
			System.out.println("Filter");
			switch (((HttpServletRequest)request).getRequestURI()) {
			case "/OnlineMovieTicketManagement/movielist":
			case "/OnlineMovieTicketManagement/movie-trailer":	
			case "/OnlineMovieTicketManagement/home":
			case "/OnlineMovieTicketManagement/":
				chain.doFilter(request, response);
				break;
			default:
				break;
			}
		} else {
			System.out.println("Filter1");
			if (requestParams.containsKey("release-date")
					&& requestParams.get("release-date")[0].matches("\\d{2}/\\d{2}/\\d{4}")) {
				chain.doFilter(request, response);
			} else if (requestParams.containsKey("genre") && Pattern.matches("[1-9]", requestParams.get("genre")[0])) {
				chain.doFilter(request, response);
			} else if (requestParams.containsKey("maturity")) {
				switch (requestParams.get("maturity")[0]) {
				case "G":
				case "PG":
				case "PG-13":
				case "R":
				case "NC-17":
					chain.doFilter(request, response);
					break;
				default:
					System.out.println("error");
					servletResponse.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
					servletResponse.sendError(404);
					break;
				}
			} else if (requestParams.containsKey("search")) {
				chain.doFilter(request, response);
			} else {
				System.out.println("error");
				servletResponse.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
				servletResponse.sendError(404);
			}
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
