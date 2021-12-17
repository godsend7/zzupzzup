package com.zzupzzup.service.domain;

import java.util.Date;

public class Alarm {

	//*Field
	private int alarmNo;
	private int alarmType;
	private Date alarmRegDate;
	private String alarmContents;
	private boolean alarmCheck;
	private int postNo;
	private int chatNo;
	private int reservationNo;
	private int reviewNo;
	
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

	public int getPostNo() {
		return postNo;
	}

	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}

	public int getChatNo() {
		return chatNo;
	}

	public void setChatNo(int chatNo) {
		this.chatNo = chatNo;
	}

	public int getReservationNo() {
		return reservationNo;
	}

	public void setReservationNo(int reservationNo) {
		this.reservationNo = reservationNo;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	
}
