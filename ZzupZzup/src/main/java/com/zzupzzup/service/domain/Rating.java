package com.zzupzzup.service.domain;

import java.sql.Date;

public class Rating {
	
	///Field
	private int ratingNo; //평가no
	private int chatNo; //채팅방no
	private int ratingScore; //평가 점수
	private String ratingValue; //평가 내용
	private String ratingFromId; //평가한 사람 아이디
	private String ratingToId; //평가받은 사람 아이디
	private Date ratingRegDate;

	///Constructor
	public Rating() {
	}

	///Method
	public int getRatingNo() {
		return ratingNo;
	}

	public void setRatingNo(int ratingNo) {
		this.ratingNo = ratingNo;
	}

	public int getChatNo() {
		return chatNo;
	}

	public void setChatNo(int chatNo) {
		this.chatNo = chatNo;
	}

	public int getRatingScore() {
		return ratingScore;
	}

	public void setRatingScore(int ratingScore) {
		this.ratingScore = ratingScore;
	}

	public String getRatingValue() {
		return ratingValue;
	}

	public void setRatingValue(String ratingValue) {
		this.ratingValue = ratingValue;
	}

	public String getRatingFromId() {
		return ratingFromId;
	}

	public void setRatingFromId(String ratingFromId) {
		this.ratingFromId = ratingFromId;
	}
	
	public String getRatingToId() {
		return ratingToId;
	}

	public void setRatingToId(String ratingToId) {
		this.ratingToId = ratingToId;
	}

	public Date getRatingRegDate() {
		return ratingRegDate;
	}

	public void setRatingRegDate(Date ratingRegDate) {
		this.ratingRegDate = ratingRegDate;
	}
	
	@Override
	public String toString() {
		return "Rating : [ratingNo] "+ratingNo+" [chatNo] "+chatNo+" [ratingScore] "+ratingScore+" [ratingValue] "+ ratingValue+" [ratingFromId] "+ratingFromId+" [ratingToId] "+ratingToId+" [ratingRegDate] "+ratingRegDate;
	}

	

}
