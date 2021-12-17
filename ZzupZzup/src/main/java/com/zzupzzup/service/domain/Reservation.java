package com.zzupzzup.service.domain;

import java.sql.Date;
import java.util.List;

public class Reservation {
	
	//Field
	private Chat chat;
	private Restaurant restaurant;
	private int reservationNo;
	private int payOption;
	private int payMethod;
	private String planTime;
	private Date planDate;
	private String fixedTime;
	private Date fixedDate;
	private int memberCount;
	private boolean reservationStatus;
	private boolean fixedStatus;
	private Date reservationDate;
	private int reservationCancelReason;
	private int reservationCancelDate;
	private int totalPrice;
	private int restaurantNo;
	private List reservationMember;
	private String reservationLeader;
	private Member reservationPhone;
	private int orderCount;
	private int orderTotal;
	
	//Constructor
	public Reservation() {
	}

	public Chat getChat() {
		return chat;
	}

	public void setChat(Chat chat) {
		this.chat = chat;
	}

	public Restaurant getRestaurant() {
		return restaurant;
	}

	public void setRestaurant(Restaurant restaurant) {
		this.restaurant = restaurant;
	}

	public int getReservationNo() {
		return reservationNo;
	}

	public void setReservationNo(int reservationNo) {
		this.reservationNo = reservationNo;
	}

	public int getPayOption() {
		return payOption;
	}

	public void setPayOption(int payOption) {
		this.payOption = payOption;
	}

	public int getPayMethod() {
		return payMethod;
	}

	public void setPayMethod(int payMethod) {
		this.payMethod = payMethod;
	}

	public String getPlanTime() {
		return planTime;
	}

	public void setPlanTime(String planTime) {
		this.planTime = planTime;
	}

	public Date getPlanDate() {
		return planDate;
	}

	public void setPlanDate(Date planDate) {
		this.planDate = planDate;
	}

	public String getFixedTime() {
		return fixedTime;
	}

	public void setFixedTime(String fixedTime) {
		this.fixedTime = fixedTime;
	}

	public Date getFixedDate() {
		return fixedDate;
	}

	public void setFixedDate(Date fixedDate) {
		this.fixedDate = fixedDate;
	}

	public int getMemberCount() {
		return memberCount;
	}

	public void setMemberCount(int memberCount) {
		this.memberCount = memberCount;
	}

	public boolean isReservationStatus() {
		return reservationStatus;
	}

	public void setReservationStatus(boolean reservationStatus) {
		this.reservationStatus = reservationStatus;
	}

	public boolean isFixedStatus() {
		return fixedStatus;
	}

	public void setFixedStatus(boolean fixedStatus) {
		this.fixedStatus = fixedStatus;
	}
	
	public Date getReservationDate() {
		return reservationDate;
	}

	public void setReservationDate(Date reservationDate) {
		this.reservationDate = reservationDate;
	}

	public int getReservationCancelReason() {
		return reservationCancelReason;
	}

	public void setReservationCancelReason(int reservationCancelReason) {
		this.reservationCancelReason = reservationCancelReason;
	}

	public int getReservationCancelDate() {
		return reservationCancelDate;
	}

	public void setReservationCancelDate(int reservationCancelDate) {
		this.reservationCancelDate = reservationCancelDate;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getRestaurantNo() {
		return restaurantNo;
	}

	public void setRestaurantNo(int restaurantNo) {
		this.restaurantNo = restaurantNo;
	}

	public List getReservationMember() {
		return reservationMember;
	}

	public void setReservationMember(List reservationMember) {
		this.reservationMember = reservationMember;
	}

	public String getReservationLeader() {
		return reservationLeader;
	}

	public void setReservationLeader(String reservationLeader) {
		this.reservationLeader = reservationLeader;
	}

	public Member getReservationPhone() {
		return reservationPhone;
	}

	public void setReservationPhone(Member reservationPhone) {
		this.reservationPhone = reservationPhone;
	}

	public int getOrderCount() {
		return orderCount;
	}

	public void setOrderCount(int orderCount) {
		this.orderCount = orderCount;
	}

	public int getOrderTotal() {
		return orderTotal;
	}

	public void setOrderTotal(int orderTotal) {
		this.orderTotal = orderTotal;
	}
	
	//Method
	@Override
	public String toString() {
		return "Reservation [chat=" + chat + ", restaurant=" + restaurant + ", reservationNo=" + reservationNo
				+ ", payOption=" + payOption + ", payMethod=" + payMethod + ", planTime=" + planTime + ", planDate="
				+ planDate + ", fixedTime=" + fixedTime + ", fixedDate=" + fixedDate + ", memberCount=" + memberCount
				+ ", reservationStatus=" + reservationStatus + ", fixedStatus=" + fixedStatus + ", reservationDate="
				+ reservationDate + ", reservationCancelReason=" + reservationCancelReason + ", reservationCancelDate="
				+ reservationCancelDate + ", totalPrice=" + totalPrice + ", restaurantNo=" + restaurantNo
				+ ", reservationMember=" + reservationMember + ", reservationLeader=" + reservationLeader
				+ ", reservationPhone=" + reservationPhone + ", orderCount=" + orderCount + ", orderTotal=" + orderTotal
				+ "]";
	}
	
	
}
