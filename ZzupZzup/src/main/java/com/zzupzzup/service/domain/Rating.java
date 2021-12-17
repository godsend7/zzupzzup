package com.zzupzzup.service.domain;

import java.sql.Date;

public class Rating {
	
	///Field
	private int ratingNo;
	private int chatNo;
	private int ratingScore;
	private String ratingValue;
	private String ratingFromId;
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

	public Date getRatingRegDate() {
		return ratingRegDate;
	}

	public void setRatingRegDate(Date ratingRegDate) {
		this.ratingRegDate = ratingRegDate;
	}
	
	@Override
	public String toString() {
		return "Rating : [ratingNo] "+ratingNo+" [chatNo] "+chatNo+" [ratingScore] "+ratingScore+" [ratingValue] "+ ratingValue+" [ratingFromId] "+ratingFromId+" [ratingRegDate] "+ratingRegDate;
	}

}
