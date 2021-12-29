package com.zzupzzup.service.domain;

import java.util.Date;
import java.util.List;

public class Community {
	
	///Field
	private Member member;
	private int postNo;
	private String postTitle;
	private String postText;
	private String streetAddress;
	private String areaAddress;
	private String restAddress;
	private String latitude;
	private String longitude;
	private String restaurantName;
	private String restaurantTel;
	////////////EL 적용 ////////////
	private String restaurantTel1;
	private String restaurantTel2;
	private String restaurantTel3;
	///////////////////////////////
	private String receiptImage;
	private Date postRegDate;
	private int likeCount; // Column 없음
	private boolean postShowStatus;
	private Date officialDate;
	private int menuType;
	private String mainMenuTitle;
	private int mainMenuPrice;
	private int postReportCount; // Column 없음
	private List<RestaurantTime> restaurantTimes;
	private List<String> postImage;
	
	
	///Constructor
	public Community() {
		// TODO Auto-generated constructor stub
	}
	
	
	///Method
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

	public String getPostText() {
		return postText;
	}
	
	public String getStreetAddress() {
		return streetAddress;
	}

	public void setStreetAddress(String streetAddress) {
		this.streetAddress = streetAddress;
	}

	public String getAreaAddress() {
		return areaAddress;
	}

	public void setAreaAddress(String areaAddress) {
		this.areaAddress = areaAddress;
	}

	public String getRestAddress() {
		return restAddress;
	}
	
	public void setRestAddress(String restAddress) {
		this.restAddress = restAddress;
	}
	
	public String getLatitude() {
		return latitude;
	}


	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}


	public String getLongitude() {
		return longitude;
	}


	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}


	public String getRestaurantName() {
		return restaurantName;
	}

	public void setRestaurantName(String restaurantName) {
		this.restaurantName = restaurantName;
	}

	public String getRestaurantTel() {
		return restaurantTel;
	}

	public void setRestaurantTel(String restaurantTel) {
		this.restaurantTel = restaurantTel;
	}

	public String getRestaurantTel1() {
		return restaurantTel1;
	}

	public void setRestaurantTel1(String restaurantTel1) {
		this.restaurantTel1 = restaurantTel1;
	}

	public String getRestaurantTel2() {
		return restaurantTel2;
	}

	public void setRestaurantTel2(String restaurantTel2) {
		this.restaurantTel2 = restaurantTel2;
	}

	public String getRestaurantTel3() {
		return restaurantTel3;
	}

	public void setRestaurantTel3(String restaurantTel3) {
		this.restaurantTel3 = restaurantTel3;
	}

	public void setPostText(String postText) {
		this.postText = postText;
	}

	public String getReceiptImage() {
		return receiptImage;
	}

	public void setReceiptImage(String receiptImage) {
		this.receiptImage = receiptImage;
	}

	public Date getPostRegDate() {
		return postRegDate;
	}

	public void setPostRegDate(Date postRegDate) {
		this.postRegDate = postRegDate;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public boolean isPostShowStatus() {
		return postShowStatus;
	}

	public void setPostShowStatus(boolean postShowStatus) {
		this.postShowStatus = postShowStatus;
	}

	public Date getOfficialDate() {
		return officialDate;
	}

	public void setOfficialDate(Date officialDate) {
		this.officialDate = officialDate;
	}

	public int getMenuType() {
		return menuType;
	}

	public void setMenuType(int menuType) {
		this.menuType = menuType;
	}

	public String getMainMenuTitle() {
		return mainMenuTitle;
	}

	public void setMainMenuTitle(String mainMenuTitle) {
		this.mainMenuTitle = mainMenuTitle;
	}

	public int getMainMenuPrice() {
		return mainMenuPrice;
	}

	public void setMainMenuPrice(int mainMenuPrice) {
		this.mainMenuPrice = mainMenuPrice;
	}

	public int getPostReportCount() {
		return postReportCount;
	}

	public void setPostReportCount(int postReportCount) {
		this.postReportCount = postReportCount;
	}


	public List<RestaurantTime> getRestaurantTimes() {
		return restaurantTimes;
	}


	public void setRestaurantTimes(List<RestaurantTime> restaurantTimes) {
		this.restaurantTimes = restaurantTimes;
	}


	public List<String> getPostImage() {
		return postImage;
	}


	public void setPostImage(List<String> postImage) {
		this.postImage = postImage;
	}


	@Override
	public String toString() {
		return "Community [member=" + member + ", postNo=" + postNo + ", postTitle=" + postTitle + ", postText="
				+ postText + ", streetAddress=" + streetAddress + ", areaAddress=" + areaAddress + ", restAddress="
				+ restAddress + ", restaurantName=" + restaurantName + ", restaurantTel=" + restaurantTel
				+ ", restaurantTel1=" + restaurantTel1 + ", restaurantTel2=" + restaurantTel2 + ", restaurantTel3="
				+ restaurantTel3 + ", receiptImage=" + receiptImage + ", postRegDate=" + postRegDate + ", likeCount="
				+ likeCount + ", postShowStatus=" + postShowStatus + ", officialDate=" + officialDate + ", menuType="
				+ menuType + ", mainMenuTitle=" + mainMenuTitle + ", mainMenuPrice=" + mainMenuPrice
				+ ", postReportCount=" + postReportCount + ", restaurantTimes=" + restaurantTimes + ", postImage="
				+ postImage + "]";
	}
	
	
}