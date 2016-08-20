package io.github.parthoshuvo.dto;

public class Customer {

	private String customerName;
	private String email;
	private String phone;

	public Customer() {

	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	@Override
	public String toString() {
		String msg = getCustomerName() + "," + getEmail() + "," +getPhone();
		return msg;
	}

}
