package io.github.parthoshuvo.service.internal.database_interaction.utility;

import java.sql.SQLException;

import io.github.parthoshuvo.database.DatabaseConnector;

public abstract class DatabaseServiceUtility {
	private DatabaseConnector dbConnector;

	protected DatabaseServiceUtility(DatabaseConnector dbConnector) {
		this.dbConnector = dbConnector;
	}

	protected void printSQLERRM(SQLException e) {
		if (e.getErrorCode() == 00001)
			System.out.println("ORA-00001: unique constraint (MOVIE.SYS_C007563) violated");
		else if (e.getErrorCode() == 20007)
			System.out.println("ORA-20007: There is more or less than enough data for inserting into CUSTOMERS table.");
		else
			System.out.println(e.getMessage());

	}

	public void setDbConnector(DatabaseConnector dbConnector) {
		this.dbConnector = dbConnector;
	}

	public DatabaseConnector getDbConnector() {
		return dbConnector;
	}
	
	
}
