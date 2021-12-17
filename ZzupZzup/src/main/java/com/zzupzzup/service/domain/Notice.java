package com.zzupzzup.service.domain;

import java.sql.Date;

public class Notice {
	
	//Field
	private int postNo;
	private String postTitle;
	private Date postRegDate;
	private int postCategory;
	private String postMemberType;
	private String postText; 
	
	//Constructor
	public Notice() {
	}

	public int getPostNo() {
		return postNo;
	}

	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}

	public String getPostTitle() {
		return postTitle;
	}

	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}

	public Date getPostRegDate() {
		return postRegDate;
	}

	public void setPostRegDate(Date postRegDate) {
		this.postRegDate = postRegDate;
	}

	public int getPostCategory() {
		return postCategory;
	}

	public void setPostCategory(int postCategory) {
		this.postCategory = postCategory;
	}

	public String getPostMemberType() {
		return postMemberType;
	}

	public void setPostMemberType(String postMemberType) {
		this.postMemberType = postMemberType;
	}

	public String getPostText() {
		return postText;
	}

	public void setPostText(String postText) {
		this.postText = postText;
	}

	//Method
	@Override
	public String toString() {
		return "Notice [postNo=" + postNo + ", postTitle=" + postTitle + ", postRegDate=" + postRegDate
				+ ", postCategory=" + postCategory + ", postMemberType=" + postMemberType + ", postText=" + postText
				+ "]";
	}
	
}
