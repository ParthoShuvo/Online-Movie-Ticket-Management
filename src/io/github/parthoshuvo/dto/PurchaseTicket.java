package io.github.parthoshuvo.dto;

import java.util.Arrays;
import java.util.List;

public class PurchaseTicket {

	private String purchaseTicketId;
	private String showTime;
	private String showDate;
	private List<String> seats;
	private Customer customer;
	private String movie;
	private String purchaseDate;
	private String purchaseTime;
	private int movieFormat;
	private int no_of_tickets;
	private double totalCost;
	private int hallNo;
	private double eachTicketPrice;

	public String getPurchaseTicketId() {
		return purchaseTicketId;
	}

	public void setPurchaseTicketId(String purchaseTicketId) {
		this.purchaseTicketId = purchaseTicketId;
	}

	public String getShowTime() {
		return showTime;
	}

	public void setShowTime(String showTime) {
		this.showTime = showTime;
	}

	public String getShowDate() {
		return showDate;
	}

	public void setShowDate(String showDate) {
		this.showDate = showDate;
	}

	public List<String> getSeats() {
		return seats;
	}

	public void setSeats(List<String> seats) {
		this.seats = seats;
	}

	public void setSeats(String seats) {
		if (seats != null && !seats.equals("")) {
			this.seats = Arrays.asList(seats.split(","));
		}
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public String getMovie() {
		return movie;
	}

	public void setMovie(String movie) {
		this.movie = movie;
	}

	public String getPurchaseDate() {
		return purchaseDate;
	}

	public void setPurchaseDate(String purchaseDate) {
		this.purchaseDate = purchaseDate;
	}

	public String getPurchaseTime() {
		return purchaseTime;
	}

	public void setPurchaseTime(String purchaseTime) {
		this.purchaseTime = purchaseTime;
	}

	public int getMovieFormat() {
		return movieFormat;
	}

	public void setMovieFormat(int movieFormat) {
		this.movieFormat = movieFormat;
	}

	public int getNo_of_tickets() {
		return no_of_tickets = (seats == null || seats.isEmpty()) ? 0 : seats.size();
	}

	public double getTotalCost() {
		return totalCost;
	}

	public void setTotalCost(double totalCost) {
		this.totalCost = totalCost;
	}

	public int getHallNo() {
		return hallNo;
	}

	public void setHallNo(int hallNo) {
		this.hallNo = hallNo;
	}

	public double getEachTicketPrice() {
		return eachTicketPrice;
	}

	public void setEachTicketPrice(double eachTicketPrice) {
		this.eachTicketPrice = eachTicketPrice;
	}

}
