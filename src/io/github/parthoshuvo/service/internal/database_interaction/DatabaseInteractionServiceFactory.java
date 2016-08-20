package io.github.parthoshuvo.service.internal.database_interaction;

import io.github.parthoshuvo.database.DatabaseConnector;
import io.github.parthoshuvo.service.internal.database_interaction.interfaces.DatabaseInteractionService;
import io.github.parthoshuvo.service.internal.database_interaction.utility.BookingTicketServiceUtility;
import io.github.parthoshuvo.service.internal.database_interaction.utility.MovieInfoServiceUtility;
import io.github.parthoshuvo.service.internal.database_interaction.utility.MovieScheduleServiceUtility;

public class DatabaseInteractionServiceFactory {

	public static final int SERVICE_MOVIE_INFO = 1;
	public static final int SERVICE_MOVIE_SCHEDULE = 2;
	public static final int SERVICE_BOOKING_TICKET = 3;

	public DatabaseInteractionServiceFactory() {
		System.out.println("##" + this.getClass().getName() + "##");
	}

	public DatabaseInteractionService getService(int service) {
		DatabaseInteractionService databaseInteractionService = null;
		DatabaseConnector dbConnector = DatabaseConnector.getInstance();
		switch (service) {
		case DatabaseInteractionServiceFactory.SERVICE_MOVIE_INFO:
			databaseInteractionService = new MovieInfoServiceUtility(dbConnector);
			break;
		case DatabaseInteractionServiceFactory.SERVICE_MOVIE_SCHEDULE:
			databaseInteractionService = new MovieScheduleServiceUtility(dbConnector);
			break;
		case DatabaseInteractionServiceFactory.SERVICE_BOOKING_TICKET:
			databaseInteractionService = new BookingTicketServiceUtility(dbConnector);
			break;
		default:
			break;
		}
		return databaseInteractionService;
	}

}
