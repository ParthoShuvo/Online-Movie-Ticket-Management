package io.github.parthoshuvo.dto;

import java.util.Date;

public class Movie {

	/***
	 * Movie Genres 1- > Action 2-> Comedy 3-> Animation 4-> Horror 5-> Drama
	 * 6-> Romantic 7-> Adventure 8-> Sports 9-> War
	 */

	private int movieId;
	private String movieName;
	private Date releaseDate;
	private int duration;
	private int genre;
	private String maturity;
	private String summary;
	private String trailer;
	private String image;
	private boolean nowShowingFlag;

	{
		nowShowingFlag = false;
	}

	public Movie() {

	}

	public int getMovieId() {
		return movieId;
	}

	public void setMovieId(int movieId) {
		this.movieId = movieId;
	}

	public String getMovieName() {
		return movieName;
	}

	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}

	public Date getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(long releaseDate) {
		this.releaseDate = new Date(releaseDate);
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public int getGenre() {
		return genre;
	}

	public void setGenre(int i) {
		this.genre = i;
	}

	public String getMaturity() {
		return maturity;
	}

	public void setMaturity(String maturity) {
		this.maturity = maturity;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getTrailer() {
		return trailer;
	}

	public void setTrailer(String trailer) {
		this.trailer = trailer;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public boolean isNowShowingFlag() {
		return nowShowingFlag;
	}

	public void setNowShowingFlag(boolean nowShowingFlag) {
		this.nowShowingFlag = nowShowingFlag;
	}

}
