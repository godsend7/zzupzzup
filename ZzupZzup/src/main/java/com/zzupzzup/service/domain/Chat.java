package com.zzupzzup.service.domain;

import java.sql.Date;
import java.util.List;

import com.zzupzzup.common.ChatAge;
import com.zzupzzup.common.ChatMember;

public class Chat {
	
	///Field
	private int chatNo;
	private String chatTitle;
	private String chatContents;
	private Date chatTime;
	private String chatImage;
	private String chatText;
	private Date chatRegDate;
	private List<ChatAge> chatAge;
	private int chatGender;
	private int chatCount;
	private int chatState;
	private String chatLeaderId;
	private boolean chatShowStatus;
	private Restaurant chatRestaurant;
	private List<ChatMember> chatMember;
	private int reportCount;	

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

	public String getChatContents() {
		return chatContents;
	}

	public void setChatContents(String chatContents) {
		this.chatContents = chatContents;
	}

	public Date getChatTime() {
		return chatTime;
	}

	public void setChatTime(Date chatTime) {
		this.chatTime = chatTime;
	}

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

	public List<ChatAge> getChatAge() {
		return chatAge;
	}

	public void setChatAge(List<ChatAge> chatAge) {
		this.chatAge = chatAge;
	}

	public int getChatGender() {
		return chatGender;
	}

	public void setChatGender(int chatGender) {
		this.chatGender = chatGender;
	}

	public int getChatCount() {
		return chatCount;
	}

	public void setChatCount(int chatCount) {
		this.chatCount = chatCount;
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
		return "Chat : [chatNo] "+chatNo+" [chatTitle] "+chatTitle+" [chatContents] "+chatContents+" [chatTime] "+ chatTime+" [chatImage] "+chatImage+" [chatText] "+chatText+" [chatRegDate] "+chatRegDate+" [chatAge] "+chatAge+" [chatGender] "+chatGender+" [chatCount] "+chatCount+" [chatState] "+chatState+" [chatLeaderId] "+chatLeaderId+" [chatShowStatus] "+chatShowStatus+" [chatRestaurant] "+chatRestaurant+" [chatMember] "+chatMember+" [reportCount] "+reportCount;
	}

}
