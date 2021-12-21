package com.zzupzzup.service.domain;

import java.util.Date;
import java.util.List;

public class Restaurant {
	
	///Field
	private Member member;
	private int restaurantNo;
	private String restaurantName;
	private String restaurantTel;
	//////////// EL 적용 ////////////
	private String restaurantTel1;
	private String restaurantTel2;
	private String restaurantTel3;
	////////////////////////////////
	private List<String> restaurantImage;
	private int menuType;
	private boolean mainMenuStatus;
	private String ownerName;
	private String ownerImage;
	private String restaurantText;
	private boolean reservationStatus;
	private boolean parkable;
	private Date requestDate;
	private Date responseDate;
	private String streetAddress;
	private String areaAddress;
	private String restAddress;
	private Date restaurantRegDate; 
	
	
	//Constructor
	public Restaurant() {
		// TODO Auto-generated constructor stub
	}
	
	
	///Method
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	public int getRestaurantNo() {
		return restaurantNo;
	}


	public void setRestaurantNo(int restaurantNo) {
		this.restaurantNo = restaurantNo;
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


	public List<String> getRestaurantImage() {
		return restaurantImage;
	}


	public void setRestaurantImage(List<String> restaurantImage) {
		this.restaurantImage = restaurantImage;
	}


	public int getMenuType() {
		return menuType;
	}


	public void setMenuType(int menuType) {
		this.menuType = menuType;
	}


	public boolean isMainMenuStatus() {
		return mainMenuStatus;
	}


	public void setMainMenuStatus(boolean mainMenuStatus) {
		this.mainMenuStatus = mainMenuStatus;
	}


	public String getOwnerName() {
		return ownerName;
	}


	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}


	public String getOwnerImage() {
		return ownerImage;
	}


	public void setOwnerImage(String ownerImage) {
		this.ownerImage = ownerImage;
	}


	public String getRestaurantText() {
		return restaurantText;
	}


	public void setRestaurantText(String restaurantText) {
		this.restaurantText = restaurantText;
	}


	public boolean isReservationStatus() {
		return reservationStatus;
	}


	public void setReservationStatus(boolean reservationStatus) {
		this.reservationStatus = reservationStatus;
	}


	public boolean isParkable() {
		return parkable;
	}


	public void setParkable(boolean parkable) {
		this.parkable = parkable;
	}


	public Date getRequestDate() {
		return requestDate;
	}


	public void setRequestDate(Date requestDate) {
		this.requestDate = requestDate;
	}


	public Date getResponseDate() {
		return responseDate;
	}


	public void setResponseDate(Date responseDate) {
		this.responseDate = responseDate;
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
	
	public Date getRestaurantRegDate() {
		return restaurantRegDate;
	}

	public void setRestaurantRegDate(Date restaurantRegDate) {
		this.restaurantRegDate = restaurantRegDate;
	}


	@Override
	public String toString() {
		return "Restaurant [member=" + member + ", restaurantNo=" + restaurantNo + ", restaurantName=" + restaurantName
				+ ", restaurantTel=" + restaurantTel + ", restaurantTel1=" + restaurantTel1 + ", restaurantTel2="
				+ restaurantTel2 + ", restaurantTel3=" + restaurantTel3 + ", restaurantImage=" + restaurantImage
				+ ", menuType=" + menuType + ", mainMenuStatus=" + mainMenuStatus + ", ownerName=" + ownerName
				+ ", ownerImage=" + ownerImage + ", restaurantText=" + restaurantText + ", reservationStatus="
				+ reservationStatus + ", parkable=" + parkable + ", requestDate=" + requestDate + ", responseDate="
				+ responseDate + ", streetAddress=" + streetAddress + ", areaAddress=" + areaAddress + ", restAddress="
				+ restAddress + ", restaurantRegDate=" + restaurantRegDate + "]";
	}
	
	
}