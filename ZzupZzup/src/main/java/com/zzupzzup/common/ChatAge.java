package com.zzupzzup.common;

public class ChatAge {
	
	///Field
	private int chatNo; //채팅방no
	private int ageType; //채팅방 연령대 타입
	private String Age; //연령대

	///Constructor
	public ChatAge() {
	}

	///Method
	public int getChatNo() {
		return chatNo;
	}

	public void setChatNo(int chatNo) {
		this.chatNo = chatNo;
	}

	public int getAgeType() {
		return ageType;
	}

	public void setAgeType(int ageType) {
		this.ageType = ageType;
	}

	public String getAge() {
		return Age;
	}

	public void setAge(String age) {
		Age = age;
	}
	
	@Override
	public String toString() {
		return "ChatAge : [chatNo] "+chatNo+" [ageType] "+ageType+" [Age] "+Age;
	}

}
