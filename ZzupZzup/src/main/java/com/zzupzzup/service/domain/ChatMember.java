package com.zzupzzup.service.domain;

public class ChatMember {
	
	///Field
	private int chatNo; //채팅방no
	private Member member; //멤버 도메인
	private boolean readyCheck; //모임확정 체크
	private boolean chatLeaderCheck; //개설자 체크
	private boolean inOutCheck; //채팅방 참여 체크
	private boolean onConnected; //접속 멤버
	private boolean forbiddenMember; //강퇴 멤버
	
	///Constructor
	public ChatMember() {
	}

	///Method
	public int getChatNo() {
		return chatNo;
	}


	public void setChatNo(int chatNo) {
		this.chatNo = chatNo;
	}


	public Member getMember() {
		return member;
	}


	public void setMember(Member member) {
		this.member = member;
	}


	public boolean isReadyCheck() {
		return readyCheck;
	}


	public void setReadyCheck(boolean readyCheck) {
		this.readyCheck = readyCheck;
	}


	public boolean isChatLeaderCheck() {
		return chatLeaderCheck;
	}


	public void setChatLeaderCheck(boolean chatLeaderCheck) {
		this.chatLeaderCheck = chatLeaderCheck;
	}
	
	public boolean isInOutCheck() {
		return inOutCheck;
	}

	public void setInOutCheck(boolean inOutcheck) {
		this.inOutCheck = inOutcheck;
	}
	public boolean isOnConnected() {
		return onConnected;
	}

	public void setOnConnected(boolean onConnected) {
		this.onConnected = onConnected;
	}

	public boolean isForbiddenMember() {
		return forbiddenMember;
	}

	public void setForbiddenMember(boolean forbiddenMember) {
		this.forbiddenMember = forbiddenMember;
	}

	@Override
	public String toString() {
		return "ChatMember [chatNo=" + chatNo + ", member=" + member + ", readyCheck=" + readyCheck
				+ ", chatLeaderCheck=" + chatLeaderCheck + ", inOutCheck=" + inOutCheck + ", onConnected=" + onConnected
				+ ", forbiddenMember=" + forbiddenMember + "]";
	}

	

	
}