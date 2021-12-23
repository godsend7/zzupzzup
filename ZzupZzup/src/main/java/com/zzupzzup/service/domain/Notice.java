package com.zzupzzup.service.domain;

import java.sql.Date;

public class Notice {
	
	//Field
	private Member member; //회원
	private int postNo;		// 게시글 번호
	private String postTitle;	// 공지사항 게시글 제목
	private Date postRegDate;	// 공지사항 게시글 게시 날짜
	private int postCategory;	// 공지사항 이벤트 업데이트
	private String postMemberType;	//공지사항 게시글을 볼 수 있는 유형
	private String postText;  // 공지사항 게시글 내용
	
	//Constructor
	public Notice() {
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
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
		return "Notice [member=" + member + ", postNo=" + postNo + ", postTitle=" + postTitle + ", postRegDate="
				+ postRegDate + ", postCategory=" + postCategory + ", postMemberType=" + postMemberType + ", postText="
				+ postText + "]";
	}
	
	
}
