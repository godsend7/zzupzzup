package com.zzupzzup.service.domain;

import java.util.Date;

public class Report {

	private int reportNo;
	private int reportCategory;
	private String memberId;
	private int reportChatNo;
	private String reportMemberId;
	private int reportReviewNo;
	private int reportPostNo;
	private int reportRestaurantNo;
	private Date reportRegDate;
	private int reportType;
	private String reportDetail;
	
	public Report() {
		// TODO Auto-generated constructor stub
	}

	public int getReportNo() {
		return reportNo;
	}

	public void setReportNo(int reportNo) {
		this.reportNo = reportNo;
	}

	public int getReportCategory() {
		return reportCategory;
	}

	public void setReportCategory(int reportCategory) {
		this.reportCategory = reportCategory;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getReportChatNo() {
		return reportChatNo;
	}

	public void setReportChatNo(int reportChatNo) {
		this.reportChatNo = reportChatNo;
	}

	public String getReportMemberId() {
		return reportMemberId;
	}

	public void setReportMemberId(String reportMemberId) {
		this.reportMemberId = reportMemberId;
	}

	public int getReportReviewNo() {
		return reportReviewNo;
	}

	public void setReportReviewNo(int reportReviewNo) {
		this.reportReviewNo = reportReviewNo;
	}

	public int getReportPostNo() {
		return reportPostNo;
	}

	public void setReportPostNo(int reportPostNo) {
		this.reportPostNo = reportPostNo;
	}

	public int getReportRestaurantNo() {
		return reportRestaurantNo;
	}

	public void setReportRestaurantNo(int reportRestaurantNo) {
		this.reportRestaurantNo = reportRestaurantNo;
	}

	public Date getReportRegDate() {
		return reportRegDate;
	}

	public void setReportRegDate(Date reportRegDate) {
		this.reportRegDate = reportRegDate;
	}

	public int getReportType() {
		return reportType;
	}

	public void setReportType(int reportType) {
		this.reportType = reportType;
	}

	public String getReportDetail() {
		return reportDetail;
	}

	public void setReportDetail(String reportDetail) {
		this.reportDetail = reportDetail;
	}

	@Override
	public String toString() {
		return "Report [reportNo=" + reportNo + ", reportCategory=" + reportCategory + ", memberId=" + memberId
				+ ", reportChatNo=" + reportChatNo + ", reportMemberId=" + reportMemberId + ", reportReviewNo="
				+ reportReviewNo + ", reportPostNo=" + reportPostNo + ", reportRestaurantNo=" + reportRestaurantNo
				+ ", reportRegDate=" + reportRegDate + ", reportType=" + reportType + ", reportDetail=" + reportDetail
				+ "]";
	}
}
