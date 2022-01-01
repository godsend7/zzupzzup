package com.zzupzzup.service.domain;

import lombok.Data;

@Data
public class Mark {

	private int markNo;
	private String memberId;
	private int postNo;
	private int reviewNo;
	private int restaurantNo;
	
	public int getMarkNo() {
		return markNo;
	}
	public void setMarkNo(int markNo) {
		this.markNo = markNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public int getPostNo() {
		return postNo;
	}
	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public int getRestaurantNo() {
		return restaurantNo;
	}
	public void setRestaurantNo(int restaurantNo) {
		this.restaurantNo = restaurantNo;
	}
	
	@Override
	public String toString() {
		return "Mark [markNo=" + markNo + ", memberId=" + memberId + ", postNo=" + postNo + ", reviewNo=" + reviewNo
				+ ", restaurantNo=" + restaurantNo + "]";
	}
	
}
