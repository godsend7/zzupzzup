package com.zzupzzup.service.domain;

import com.zzupzzup.common.util.CommonUtil;

public class RestaurantTime {
	
	///Field
	private int restaurantTimeNo;
	private Community community;
	private Restaurant restaurant;
	private int restaurantDay;
	private String restaurantOpen;
	private String restaurantClose;
	private String restaurantBreak;
	private String restaurantLastOrder;
	private boolean restaurantDayOff;
	
	
	///Constructor
	public RestaurantTime() {
		// TODO Auto-generated constructor stub
	}
	
	
	///Method
	public int getRestaurantTimeNo() {
		return restaurantTimeNo;
	}
	

	public void setRestaurantTimeNo(int restaurantTimeNo) {
		this.restaurantTimeNo = restaurantTimeNo;
	}
	

	public Community getCommunity() {
		return community;
	}


	public void setCommunity(Community community) {
		this.community = community;
	}


	public Restaurant getRestaurant() {
		return restaurant;
	}


	public void setRestaurant(Restaurant restaurant) {
		this.restaurant = restaurant;
	}


	public int getRestaurantDay() {
		return restaurantDay;
	}


	public void setRestaurantDay(int restaurantDay) {
		this.restaurantDay = restaurantDay;
	}

	
	public String getRestaurantOpen() {
		return restaurantOpen;
	}


	public void setRestaurantOpen(String restaurantOpen) {
		this.restaurantOpen = restaurantOpen;
	}
	
	
	public String getRestaurantClose() {
		return restaurantClose;
	}


	public void setRestaurantClose(String restaurantClose) {
		this.restaurantClose = restaurantClose;
	}


	public String getRestaurantBreak() {
		return restaurantBreak;
	}


	public void setRestaurantBreak(String restaurantBreak) {
		this.restaurantBreak = restaurantBreak;
	}


	public String getRestaurantLastOrder() {
		return restaurantLastOrder;
	}


	public void setRestaurantLastOrder(String restaurantLastOrder) {
		this.restaurantLastOrder = restaurantLastOrder;
	}


	public boolean isRestaurantDayOff() {
		return restaurantDayOff;
	}


	public void setRestaurantDayOff(boolean restaurantDayOff) {
		this.restaurantDayOff = restaurantDayOff;
	}
	
	public String getReturnDay() {
		return CommonUtil.returnDay(restaurantDay);
	}
	
	public String getReturnDayOff() {
		return CommonUtil.returnDayOff(restaurantDayOff);
	}
	
	
	@Override
	public String toString() {
		return "RestaurantTime [restaurantTimeNo=" + restaurantTimeNo + ", community=" + community + ", restaurant="
				+ restaurant + ", restaurantDay=" + restaurantDay + ", restaurantOpen=" + restaurantOpen
				+ ", restaurantClose=" + restaurantClose + ", restaurantBreak=" + restaurantBreak
				+ ", restaurantLastOrder=" + restaurantLastOrder + ", restaurantDayOff=" + restaurantDayOff + "]";
	}
	
	
}
