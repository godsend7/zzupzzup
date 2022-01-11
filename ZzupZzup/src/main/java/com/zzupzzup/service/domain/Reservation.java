package com.zzupzzup.service.domain;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import com.zzupzzup.common.util.CommonUtil;

public class Reservation {
	
	//Field
	private Chat chat;
	private Restaurant restaurant;
	private Member member;
	private int reservationNo;
	private String reservationNumber;
	private int payOption;
	private String payMethod; //api 환불
	private String planTime;
	private Date planDate;
	private String fixedTime;
	private Timestamp fixedDate;
	private int memberCount;
	private int reservationStatus;
	private boolean fixedStatus;
	private Date reservationDate;
	private int reservationCancelReason;
	private String reservationCancelDetail;
	private boolean refundStatus;
	private Date reservationCancelDate;
	private int totalPrice;
	private int orderCount; //주문메뉴수량
	private int orderTotal; //주문메뉴 총수량
	private List<Order> order;
	
	private String reviewNo; //리뷰 작성 여부 확인
	
	//Constructor
	public Reservation() {
	}

	//Method
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

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public int getReservationNo() {
		return reservationNo;
	}

	public void setReservationNo(int reservationNo) {
		this.reservationNo = reservationNo;
	}

	public String getReservationNumber() {
		return reservationNumber;
	}

	public void setReservationNumber(String reservationNumber) {
		this.reservationNumber = reservationNumber;
	}

	public int getPayOption() {
		return payOption;
	}

	public void setPayOption(int payOption) {
		this.payOption = payOption;
	}

	public String getPayMethod() {
		return payMethod;
	}

	public void setPayMethod(String payMethod) {
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

	public Timestamp getFixedDate() {
		return fixedDate;
	}

	public void setFixedDate(Timestamp fixedDate) {
		this.fixedDate = fixedDate;
	}

	public int getMemberCount() {
		return memberCount;
	}

	public void setMemberCount(int memberCount) {
		this.memberCount = memberCount;
	}

	public int getReservationStatus() {
		return reservationStatus;
	}

	public void setReservationStatus(int reservationStatus) {
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

	public String getReservationCancelDetail() {
		return reservationCancelDetail;
	}

	public void setReservationCancelDetail(String reservationCancelDetail) {
		this.reservationCancelDetail = reservationCancelDetail;
	}

	public boolean isRefundStatus() {
		return refundStatus;
	}

	public void setRefundStatus(boolean refundStatus) {
		this.refundStatus = refundStatus;
	}

	public Date getReservationCancelDate() {
		return reservationCancelDate;
	}

	public void setReservationCancelDate(Date reservationCancelDate) {
		this.reservationCancelDate = reservationCancelDate;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
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

	public List<Order> getOrder() {
		return order;
	}

	public void setOrder(List<Order> order) {
		this.order = order;
	}
	
	public String getReturnStatus() {
		return CommonUtil.reservationStatus(reservationStatus);
	}
	
	public String getReturnPayOption() {
		return CommonUtil.payOption(payOption);
	}
	
	public String getReturnReservationCancelReason() {
		return CommonUtil.reservationCancelReason(reservationCancelReason);
	}

	public String getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(String reviewNo) {
		this.reviewNo = reviewNo;
	}

	@Override
	public String toString() {
		return "Reservation [chat=" + chat + ", restaurant=" + restaurant + ",\n::: member=" + member + ",\n::: reservationNo="
				+ reservationNo + ", reservationNumber=" + reservationNumber + ", payOption=" + payOption
				+ ", payMethod=" + payMethod + ", planTime=" + planTime + ", planDate=" + planDate + ", fixedTime="
				+ fixedTime + ", fixedDate=" + fixedDate + ", memberCount=" + memberCount + ", reservationStatus="
				+ reservationStatus + ", fixedStatus=" + fixedStatus + ", reservationDate=" + reservationDate
				+ ", reservationCancelReason=" + reservationCancelReason + ", reservationCancelDetail="
				+ reservationCancelDetail + ", refundStatus=" + refundStatus + ", reservationCancelDate="
				+ reservationCancelDate + ", totalPrice=" + totalPrice + ", orderCount=" + orderCount + ", orderTotal="
				+ orderTotal + ", order=" + order + ", reviewNo=" + reviewNo + "]";
	}
}
