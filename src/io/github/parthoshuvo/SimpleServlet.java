package io.github.parthoshuvo;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import io.github.parthoshuvo.database.DatabaseConnector;

/**
 * Servlet implementation class SimpleServlet
 */

public abstract class SimpleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DatabaseConnector dbConnector = null;
	private RequestDispatcher reqDispatcher = null;

	protected SimpleServlet() {

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 *//*
		 * protected void doGet(HttpServletRequest request, HttpServletResponse
		 * response) throws ServletException, IOException { // TODO
		 * Auto-generated method stub String text = "Simple Servlet Works";
		 * PrintWriter writer = response.getWriter(); writer.append(text);
		 * DatabaseConnector dbConn = DatabaseConnector.getInstance(); if
		 * (dbConn.createConnection()) { writer.append(
		 * "Database succesfully connected"); writer.append(
		 * "<br/>Latest Trailers" + dbConn.getLatestMovieTrailers().size()); }
		 * dbConn.closeConnection(); response.sendRedirect("home"); }
		 */
	protected void createDatabaseConnectorInstance() {
		dbConnector = DatabaseConnector.getInstance();
		dbConnector.createConnection();
	}

	protected void distoryDatabaseConnectorInstance() {
		dbConnector = null;
	}

	@Override
	public void destroy() {
		super.destroy();
		dbConnector.closeConnection();
		distoryDatabaseConnectorInstance();
	}

	protected DatabaseConnector getDatabaseConnectorInstance() {
		if (dbConnector == null) {
			dbConnector = DatabaseConnector.getInstance();
			dbConnector.createConnection();
		}
		return dbConnector;
	}

	protected void setRequestDispatcher(RequestDispatcher reqDispatcher) {
		this.reqDispatcher = reqDispatcher;
	}

	protected RequestDispatcher getRequestDispatcher() {
		return reqDispatcher;
	}
}
