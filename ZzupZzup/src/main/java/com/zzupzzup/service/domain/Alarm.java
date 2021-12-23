package com.zzupzzup.service.domain;

import java.util.Date;

public class Alarm {

	//*Field
	private int alarmNo;
	private Member member;
	private int alarmType;
	private Date alarmRegDate;
	private String alarmContents;
	private boolean alarmCheck;
	private Community community;
	private Chat chat;
	private Reservation reservation;
	private Review review;
	
	//*Constructor
	public Alarm() {
		// TODO Auto-generated constructor stub
	}

	//*Method
	public int getAlarmNo() {
		return alarmNo;
	}

	public void setAlarmNo(int alarmNo) {
		this.alarmNo = alarmNo;
	}

	public int getAlarmType() {
		return alarmType;
	}

	public void setAlarmType(int alarmType) {
		this.alarmType = alarmType;
	}

	public Date getAlarmRegDate() {
		return alarmRegDate;
	}

	public void setAlarmRegDate(Date alarmRegDate) {
		this.alarmRegDate = alarmRegDate;
	}

	public String getAlarmContents() {
		return alarmContents;
	}

	public void setAlarmContents(String alarmContents) {
		this.alarmContents = alarmContents;
	}

	public boolean isAlarmCheck() {
		return alarmCheck;
	}

	public void setAlarmCheck(boolean alarmCheck) {
		this.alarmCheck = alarmCheck;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Community getCommunity() {
		return community;
	}

	public void setCommunity(Community community) {
		this.community = community;
	}

	public Chat getChat() {
		return chat;
	}

	public void setChat(Chat chat) {
		this.chat = chat;
	}

	public Reservation getReservation() {
		return reservation;
	}

	public void setReservation(Reservation reservation) {
		this.reservation = reservation;
	}

	public Review getReview() {
		return review;
	}

	public void setReview(Review review) {
		this.review = review;
	}

//	@Override
//	public String toString() {
//		// TODO Auto-generated method stub
//		return "Alarm [ alarmNo : "+alarmNo+", memberId : "+member.getMemberId()+", alarmType : "+alarmType+", alarmRegDate : "+alarmRegDate
//				+", alarmContents : "+alarmContents+", alarmCheck : "+alarmCheck+", communityNo : "+community.getPostNo()+", chatNo : "+chat.getChatNo()
//				+", reservationNo : "+reservation.getReservationNo()+", reviewNo : "+review.getReviewNo();
//	}
	
}
