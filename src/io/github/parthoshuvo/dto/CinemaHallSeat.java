package io.github.parthoshuvo.dto;

public class CinemaHallSeat {

	private String row;
	private String seat_position;
	private int total_seat;
	private int start_seat_no;
	private int end_seat_no;
	private int total_columns;
	private boolean is_extended;

	{
		total_columns = 0;
		total_seat = 0;
		is_extended = false;
	}

	public CinemaHallSeat() {

	}

	public String getRow() {
		return row;
	}

	public void setRow(String row) {
		this.row = row;
	}

	public String getSeat_position() {
		return seat_position;
	}

	public void setSeat_position(String seat_position) {
		this.seat_position = seat_position;
	}

	public int getTotal_seat() {
		return (end_seat_no - start_seat_no) + 1;
	}

	public int getStart_seat_no() {
		return start_seat_no;
	}

	public void setStart_seat_no(int start_seat_no) {
		this.start_seat_no = start_seat_no;
	}

	public int getEnd_seat_no() {
		return end_seat_no;
	}

	public void setEnd_seat_no(int end_seat_no) {
		this.end_seat_no = end_seat_no;
	}

	public int getTotal_columns() {
		return total_columns;
	}

	public void setTotal_columns(int total_columns) {
		this.total_columns = total_columns;
	}

	public boolean is_extended() {
		return is_extended;
	}

	public void setIs_extended(boolean is_extended) {
		this.is_extended = is_extended;
	}

}
