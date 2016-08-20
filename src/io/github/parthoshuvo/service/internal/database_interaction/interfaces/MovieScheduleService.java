package io.github.parthoshuvo.service.internal.database_interaction.interfaces;

import java.text.ParseException;

import io.github.parthoshuvo.dto.MovieShowTimeSchedule;

public interface MovieScheduleService extends DatabaseInteractionService {
	public MovieShowTimeSchedule getMovieSchedule(String movieName, String date) throws ParseException;

	public boolean isMoviePlaying(String movieName, String showDate, String showTime, int movieFormat, int hallNo);

	public boolean isMoviePlaying(String movieName, String showDate, String showTime, int movieFormat, int hallNo,
			int category);

}
