package io.github.parthoshuvo.dto;

import java.util.Date;
import java.util.List;

public class MovieShowTimeSchedule {
	
	private List<ShowTime> showTime2D;
	private List<ShowTime> showTime3D;
	private Movie movie;
	private Date showDate;
	
	public List<ShowTime> getShowTime2D() {
		return showTime2D;
	}
	public void setShowTime2D(List<ShowTime> showTime2D) {
		this.showTime2D = showTime2D;
	}
	public List<ShowTime> getShowTime3D() {
		return showTime3D;
	}
	public void setShowTime3D(List<ShowTime> showTime3D) {
		this.showTime3D = showTime3D;
	}
	public Movie getMovie() {
		return movie;
	}
	public void setMovie(Movie movie) {
		this.movie = movie;
	}
	public Date getShowDate() {
		return showDate;
	}
	public void setShowDate(Date showDate) {
		this.showDate = showDate;
	}
	
	
}
