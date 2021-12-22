package com.zzupzzup.service.domain;

import java.util.Date;
import java.util.List;

public class Review {
	
	private Member member;
	private Reservation reservation;
	private int reviewNo;
	private int scopeClean;
	private int scopeTaste;
	private int scopeKind;
	private List<String> reviewImage;
	private String reviewDetail;
	//private List<Integer> hashTagNo;
	//private List<String> hashTag;
	private List<HashTag> hashTag;
	private Date reviewRegDate;
	private int likeCount;
	private int reportCount;
	private double avgScope;
	private double avgTotalScope;
	private boolean reviewShowStatus;
	
	public Review() {
		// TODO Auto-generated constructor stub
		
		
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Reservation getReservation() {
		return reservation;
	}

	public void setReservation(Reservation reservation) {
		this.reservation = reservation;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public int getScopeClean() {
		return scopeClean;
	}

	public void setScopeClean(int scopeClean) {
		this.scopeClean = scopeClean;
	}

	public int getScopeTaste() {
		return scopeTaste;
	}

	public void setScopeTaste(int scopeTaste) {
		this.scopeTaste = scopeTaste;
	}

	public int getScopeKind() {
		return scopeKind;
	}

	public void setScopeKind(int scopeKind) {
		this.scopeKind = scopeKind;
	}

	public List<String> getReviewImage() {
		return reviewImage;
	}

	public void setReviewImage(List<String> reviewImage) {
		this.reviewImage = reviewImage;
	}

	public String getReviewDetail() {
		return reviewDetail;
	}

	public void setReviewDetail(String reviewDetail) {
		this.reviewDetail = reviewDetail;
	}

//	public List<String> getHashTag() {
//		return hashTag;
//	}
//
//	public void setHashTag(List<String> hashTag) {
//		this.hashTag = hashTag;
//	}
//
//	public List<Integer> getHashTagNo() {
//		return hashTagNo;
//	}
//
//	public void setHashTagNo(List<Integer> hashTagNo) {
//		this.hashTagNo = hashTagNo;
//	}
	
	public Date getReviewRegDate() {
		return reviewRegDate;
	}

	public List<HashTag> getHashTag() {
		return hashTag;
	}

	public void setHashTag(List<HashTag> hashTag) {
		this.hashTag = hashTag;
	}

	public void setReviewRegDate(Date reviewRegDate) {
		this.reviewRegDate = reviewRegDate;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	public int getReportCount() {
		return reportCount;
	}

	public void setReportCount(int reportCount) {
		this.reportCount = reportCount;
	}

	public double getAvgScope() {
		return avgScope;
	}

	public void setAvgScope(double d) {
		this.avgScope = Double.parseDouble(String.format("%.1f", d));
	}

	public double getAvgTotalScope() {
		return avgTotalScope;
	}

	public void setAvgTotalScope(double avgTotalScope) {
		this.avgTotalScope = avgTotalScope;
	}

	public boolean isReviewShowStatus() {
		return reviewShowStatus;
	}

	public void setReviewShowStatus(boolean reviewShowStatus) {
		this.reviewShowStatus = reviewShowStatus;
	}

	@Override
	public String toString() {
		return "Review [member=" + member + ", reservation=" + reservation + ", reviewNo=" + reviewNo + ", scopeClean="
				+ scopeClean + ", scopeTaste=" + scopeTaste + ", scopeKind=" + scopeKind + ", reviewImage="
				+ reviewImage + ", reviewDetail=" + reviewDetail + ", hashTag=" + hashTag + ", reviewRegDate="
				+ reviewRegDate + ", likeCount=" + likeCount + ", reportCount=" + reportCount + ", avgScope=" + avgScope
				+ ", avgTotalScope=" + avgTotalScope + ", reviewShowStatus=" + reviewShowStatus + "]";
	}
}
