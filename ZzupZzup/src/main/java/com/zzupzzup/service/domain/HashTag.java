package com.zzupzzup.service.domain;

public class HashTag {
	
	private int hashTagNo;
	private String hashTag;
	
	public int getHashTagNo() {
		return hashTagNo;
	}
	public void setHashTagNo(int hashTagNo) {
		this.hashTagNo = hashTagNo;
	}
	public String getHashTag() {
		return hashTag;
	}
	public void setHashTag(String hashTag) {
		this.hashTag = hashTag;
	}
	
	@Override
	public String toString() {
		return "HashTag [hashTagNo=" + hashTagNo + ", hashTag=" + hashTag + "]";
	}
}