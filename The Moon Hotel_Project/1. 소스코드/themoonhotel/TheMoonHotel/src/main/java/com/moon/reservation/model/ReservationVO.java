package com.moon.reservation.model;

public class ReservationVO {
	private int reservNo;
	private int guestNo;
	private int roomNo;
	private int adult;
	private int kids;
	private String ci_date;
	private String co_date;
	private int totalPrice;
	
	public ReservationVO() {
		super();
	}

	public ReservationVO(int reservNo, int guestNo, int roomNo, int adult, int kids, String ci_date,
			String co_date, int totalPrice) {
		super();
		this.reservNo = reservNo;
		this.guestNo = guestNo;
		this.roomNo = roomNo;
		this.adult = adult;
		this.kids = kids;
		this.ci_date = ci_date;
		this.co_date = co_date;
		this.totalPrice = totalPrice;
	}

	public int getReservNo() {
		return reservNo;
	}

	public void setReservNo(int reservNo) {
		this.reservNo = reservNo;
	}

	public int getGuestNo() {
		return guestNo;
	}

	public void setGuestNo(int guestNo) {
		this.guestNo = guestNo;
	}

	public int getAdult() {
		return adult;
	}

	public void setAdult(int adult) {
		this.adult = adult;
	}

	public int getKids() {
		return kids;
	}

	public void setKids(int kids) {
		this.kids = kids;
	}

	public String getCi_date() {
		return ci_date;
	}

	public void setCi_date(String ci_date) {
		this.ci_date = ci_date;
	}

	public String getCo_date() {
		return co_date;
	}

	public void setCo_date(String co_date) {
		this.co_date = co_date;
	}
	
	public int getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	@Override
	public String toString() {
		return "ReservationVO [reservNo=" + reservNo + ", guestNo=" + guestNo + ", roomNo=" + roomNo
				+ ", adult=" + adult + ", kids=" + kids + ", ci_date=" + ci_date + ", co_date=" + co_date
				+ ", totalPrice=" + totalPrice + "]";
	}	
}
