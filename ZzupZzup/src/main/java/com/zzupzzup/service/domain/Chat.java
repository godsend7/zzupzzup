package com.zzupzzup.service.domain;

import java.sql.Date;
import java.util.List;

import com.zzupzzup.common.ChatAge;
import com.zzupzzup.common.ChatMember;

public class Chat {
	
	///Field
	private int chatNo; //채팅방no
	private String chatTitle; //채팅방 제목
	//private String chatContents; //채팅방 대화 내용
	//private Date chatTime; //채팅방 대화 시간
	private String chatImage; //채팅방 대표 이미지
	private String chatText; //채팅방 소개글
	private Date chatRegDate; //채팅방 개설일
	private String chatAge; //채팅방 참여가능 연령대 리스트
	private int chatGender; //채팅방 참여가능 성별
	private int chatMemberCount; //채팅방 참여 인원수
	private int chatState; //채팅방 모집상태
	private String chatLeaderId; //채팅방 개설자 아이디
	private boolean chatShowStatus; //채팅방 노출 여부
	private Restaurant chatRestaurant; //음식점 도메인
	private List<ChatMember> chatMember; //채팅방 참여자 리스트
	private int reportCount; //누적 신고횟수

	///Constructor
	public Chat() {
	}

	//Method
	public int getChatNo() {
		return chatNo;
	}

	public void setChatNo(int chatNo) {
		this.chatNo = chatNo;
	}

	public String getChatTitle() {
		return chatTitle;
	}

	public void setChatTitle(String chatTitle) {
		this.chatTitle = chatTitle;
	}

	/*
	 * public String getChatContents() { return chatContents; }
	 * 
	 * public void setChatContents(String chatContents) { this.chatContents =
	 * chatContents; }
	 * 
	 * public Date getChatTime() { return chatTime; }
	 * 
	 * public void setChatTime(Date chatTime) { this.chatTime = chatTime; }
	 */

	public String getChatImage() {
		return chatImage;
	}

	public void setChatImage(String chatImage) {
		this.chatImage = chatImage;
	}

	public String getChatText() {
		return chatText;
	}

	public void setChatText(String chatText) {
		this.chatText = chatText;
	}

	public Date getChatRegDate() {
		return chatRegDate;
	}

	public void setChatRegDate(Date chatRegDate) {
		this.chatRegDate = chatRegDate;
	}

	public String getChatAge() {
		return chatAge;
	}

	public void setChatAge(String string) {
		this.chatAge = string;
	}

	public int getChatGender() {
		return chatGender;
	}

	public void setChatGender(int chatGender) {
		this.chatGender = chatGender;
	}

	public int getChatMemberCount() {
		return chatMemberCount;
	}

	public void setChatMemberCount(int chatCount) {
		this.chatMemberCount = chatCount;
	}

	public int getChatState() {
		return chatState;
	}

	public void setChatState(int chatState) {
		this.chatState = chatState;
	}

	public String getChatLeaderId() {
		return chatLeaderId;
	}

	public void setChatLeaderId(String chatLeaderId) {
		this.chatLeaderId = chatLeaderId;
	}

	public boolean isChatShowStatus() {
		return chatShowStatus;
	}

	public void setChatShowStatus(boolean chatShowStatus) {
		this.chatShowStatus = chatShowStatus;
	}

	public Restaurant getChatRestaurant() {
		return chatRestaurant;
	}

	public void setChatRestaurant(Restaurant chatRestaurant) {
		this.chatRestaurant = chatRestaurant;
	}

	public List<ChatMember> getChatMember() {
		return chatMember;
	}

	public void setChatMember(List<ChatMember> chatMember) {
		this.chatMember = chatMember;
	}

	public int getReportCount() {
		return reportCount;
	}

	public void setReportCount(int reportCount) {
		this.reportCount = reportCount;
	}

	@Override
	public String toString() {
		return "Chat [chatNo=" + chatNo + ", chatTitle=" + chatTitle + ", chatImage=" + chatImage + ", chatText="
				+ chatText + ", chatRegDate=" + chatRegDate + ", chatAge=" + chatAge + ", chatGender=" + chatGender
				+ ", chatMemberCount=" + chatMemberCount + ", chatState=" + chatState + ", chatLeaderId=" + chatLeaderId
				+ ", chatShowStatus=" + chatShowStatus + ", chatRestaurant=" + chatRestaurant + ", chatMember="
				+ chatMember + ", reportCount=" + reportCount + "]";
	}
	
	

}
