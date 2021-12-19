package com.zzupzzup.service.domain;

import java.util.Date;

public class Community {
	
	///Field
	private int postNo;
	private String postTime;
	private String postText;
	private String receiptImage;
	private boolean receiptStatus;
	private Date postRegDate;
	private int likeCount;
	private boolean postShowStatus;
	private boolean officialStatus;
	private String mainMenuTitle;
	private int mainMenuPrice;
	private int postReportCount;
	
	
	///Constructor
	public Community() {
		// TODO Auto-generated constructor stub
	}
	
	
	///Method
	public int getPostNo() {
		return postNo;
	}

	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}

	public String getPostTime() {
		return postTime;
	}

	public void setPostTime(String postTime) {
		this.postTime = postTime;
	}

	public String getPostText() {
		return postText;
	}

	public void setPostText(String postText) {
		this.postText = postText;
	}

	public String getReceiptImage() {
		return receiptImage;
	}

	public void setReceiptImage(String receiptImage) {
		this.receiptImage = receiptImage;
	}

	public boolean isReceiptStatus() {
		return receiptStatus;
	}

	public void setReceiptStatus(boolean receiptStatus) {
		this.receiptStatus = receiptStatus;
	}

	public Date getPostRegDate() {
		return postRegDate;
	}

	public void setPostRegDate(Date postRegDate) {
		this.postRegDate = postRegDate;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public boolean isPostShowStatus() {
		return postShowStatus;
	}

	public void setPostShowStatus(boolean postShowStatus) {
		this.postShowStatus = postShowStatus;
	}

	public boolean isOfficialStatus() {
		return officialStatus;
	}

	public void setOfficialStatus(boolean officialStatus) {
		this.officialStatus = officialStatus;
	}

	public String getMainMenuTitle() {
		return mainMenuTitle;
	}

	public void setMainMenuTitle(String mainMenuTitle) {
		this.mainMenuTitle = mainMenuTitle;
	}

	public int getMainMenuPrice() {
		return mainMenuPrice;
	}

	public void setMainMenuPrice(int mainMenuPrice) {
		this.mainMenuPrice = mainMenuPrice;
	}

	public int getPostReportCount() {
		return postReportCount;
	}

	public void setPostReportCount(int postReportCount) {
		this.postReportCount = postReportCount;
	}
	
	

}
