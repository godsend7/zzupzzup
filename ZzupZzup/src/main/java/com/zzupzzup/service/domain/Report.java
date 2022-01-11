package com.zzupzzup.service.domain;

import java.sql.Timestamp;
import java.util.Date;

import com.zzupzzup.common.util.CommonUtil;

public class Report {

	private int reportNo;
	private int reportCategory;
	private String memberId;
	private Chat reportChat;
	private Member reportChatMember;
	private Review reportReview;
	private Community reportPost;
	private Restaurant reportRestaurant;
	private Timestamp reportRegDate;
	private int reportType;
	private String reportDetail;
	private boolean reportCheck;
	
	//신고 대상 번호(id)
	private String toReport;
	
	//신고 대상 타이틀(닉네임)
	private String toReportTitle;
	
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

	public Chat getReportChat() {
		return reportChat;
	}

	public void setReportChat(Chat reportChat) {
		this.reportChat = reportChat;
	}

	public Member getReportChatMember() {
		return reportChatMember;
	}

	public void setReportChatMember(Member reportChatMember) {
		this.reportChatMember = reportChatMember;
	}

	public Review getReportReview() {
		return reportReview;
	}

	public void setReportReview(Review reportReview) {
		this.reportReview = reportReview;
	}

	public Community getReportPost() {
		return reportPost;
	}

	public void setReportPost(Community reportPost) {
		this.reportPost = reportPost;
	}

	public Restaurant getReportRestaurant() {
		return reportRestaurant;
	}

	public void setReportRestaurant(Restaurant reportRestaurant) {
		this.reportRestaurant = reportRestaurant;
	}

	public String getReportRegDate() {
		return CommonUtil.getDate(reportRegDate);
	}

	public void setReportRegDate(Timestamp reportRegDate) {
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
	
	public boolean isReportCheck() {
		return reportCheck;
	}

	public void setReportCheck(boolean reportCheck) {
		this.reportCheck = reportCheck;
	}
	
	public String getToReport() {
		if (reportChat != null) {
			toReportTitle = reportChat.getChatTitle();
			return toReport = Integer.toString(reportChat.getChatNo());
		} else if (reportChatMember != null) {
			toReportTitle = reportChatMember.getNickname();
			return toReport = reportChatMember.getMemberId();
		} else if (reportReview != null) {
			toReportTitle = reportReview.getMember().getNickname();
			return toReport = Integer.toString(reportReview.getReviewNo());
		} else if (reportPost != null) {
			toReportTitle = reportPost.getPostTitle();
			return toReport = Integer.toString(reportPost.getPostNo());
		} else if (reportRestaurant != null) {
			toReportTitle = reportRestaurant.getRestaurantName();
			return toReport = Integer.toString(reportRestaurant.getRestaurantNo());
		} else {
			return toReport;
		}
	}

	public void setToReport(String toReport) {
		//this.toReport = toReport;
		if (reportCategory == 1) {
			reportChat = new Chat();
			reportChat.setChatNo(Integer.parseInt(toReport));
			System.out.println(reportChat.getChatNo());
		} else if (reportCategory == 2) {
			reportChatMember = new Member();
			reportChatMember.setMemberId(toReport);
			System.out.println(reportChatMember.getMemberId());
		} else if (reportCategory == 3) {
			reportReview = new Review();
			reportReview.setReviewNo(Integer.parseInt(toReport));
			System.out.println(reportReview.getReviewNo());
		} else if (reportCategory == 4) {
			reportPost = new Community();
			reportPost.setPostNo(Integer.parseInt(toReport));
			System.out.println(reportPost.getPostNo());
		} else if (reportCategory == 5) {
			reportRestaurant = new Restaurant();
			reportRestaurant.setRestaurantNo(Integer.parseInt(toReport));
			System.out.println(reportRestaurant.getRestaurantNo());
		}
	}
	
	public String getToReportTitle() {
		return toReportTitle;
	}
	
	public String getReturnReportType() {
		return CommonUtil.returnReportData(reportCategory, reportType);
	}

	@Override
	public String toString() {
		return "Report [reportNo=" + reportNo + ", reportCategory=" + reportCategory + ", memberId=" + memberId
				+ ", reportChat=" + reportChat + ", reportChatMember=" + reportChatMember + ", reportReview="
				+ reportReview + ", reportPost=" + reportPost + ", reportRestaurant=" + reportRestaurant
				+ ", reportRegDate=" + reportRegDate + ", reportType=" + reportType + ", reportDetail=" + reportDetail
				+ ", reportCheck=" + reportCheck + ", toReport=" + toReport + "]";
	}
}
