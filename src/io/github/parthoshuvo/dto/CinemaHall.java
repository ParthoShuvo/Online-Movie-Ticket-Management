package io.github.parthoshuvo.dto;

import java.util.List;

public class CinemaHall {

	private int hallNo;
	private int category;
	private int format;
	private double ticket_price;
	private int no_of_upper_seats;
	private int no_of_lower_seats;
	private int total_seats;
	private int no_of_columns;
	private int no_of_rows;
	private List<CinemaHallSeat> seatList;
	

	{
		no_of_lower_seats = 0;
		no_of_upper_seats = 0;
		total_seats = 0;
		no_of_columns = 0;
	}

	public int getHallNo() {
		return hallNo;
	}

	public void setHallNo(int hallNo) {
		this.hallNo = hallNo;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public int getFormat() {
		return format;
	}

	public void setFormat(int format) {
		this.format = format;
	}

	public double getTicket_price() {
		return ticket_price;
	}

	public void setTicket_price(double ticket_price) {
		this.ticket_price = ticket_price;
	}

	public int getNo_of_upper_seats() {
		return no_of_upper_seats;
	}

	public void setNo_of_upper_seats(int no_of_upper_seats) {
		this.no_of_upper_seats = no_of_upper_seats;
	}

	public int getNo_of_lower_seats() {
		return no_of_lower_seats;
	}

	public void setNo_of_lower_seats(int no_of_lower_seats) {
		this.no_of_lower_seats = no_of_lower_seats;
	}

	public int getTotal_seats() {
		return total_seats = no_of_lower_seats + no_of_upper_seats;
	}

	public int getNo_of_columns() {
		return no_of_columns;
	}

	public void setNo_of_columns(int no_of_columns) {
		this.no_of_columns = no_of_columns;
	}

	public List<CinemaHallSeat> getSeatList() {
		return seatList;
	}

	public void setSeatList(List<CinemaHallSeat> seatList) {
		this.seatList = seatList;
	}

	public int getNo_of_rows() {
		no_of_rows =  seatList != null ? seatList.size() : 0;
		return no_of_rows;
	}
	
	

}
