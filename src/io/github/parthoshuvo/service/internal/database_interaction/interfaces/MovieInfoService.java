package io.github.parthoshuvo.service.internal.database_interaction.interfaces;

import java.util.List;

import io.github.parthoshuvo.dto.Movie;

public interface MovieInfoService extends DatabaseInteractionService {
	public List<Movie> getLatestMovieTrailers();

	public List<Movie> getMovieList(boolean nowShowingFlag);
	
	public Movie getMovieInfo(String movieName, boolean nowShowingFlag);
	
	public List<Movie> getMovieListBySearch(String searchWord);
	
	public List<Movie> getMovieListBySearch(String searchKey, String searchValue);
	
	
}
