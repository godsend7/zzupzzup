package com.zzupzzup.service.domain;

public class RestaurantTime {
	
	///Field
	private int restaurantTimeNo;
	private Community postNo;
	private Restaurant restaurantNo;
	private String restaurantDay;
	private int restaurantOpen;
	private int restaurantClose;
	private int restaurantBreak;
	private int restaurantLastOrder;
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

	public Community getPostNo() {
		return postNo;
	}

	public void setPostNo(Community postNo) {
		this.postNo = postNo;
	}

	public Restaurant getRestaurantNo() {
		return restaurantNo;
	}

	public void setRestaurantNo(Restaurant restaurantNo) {
		this.restaurantNo = restaurantNo;
	}
	
	public String getRestaurantDay() {
		return restaurantDay;
	}


	public void setRestaurantDay(String restaurantDay) {
		this.restaurantDay = restaurantDay;
	}


	public int getRestaurantOpen() {
		return restaurantOpen;
	}


	public void setRestaurantOpen(int restaurantOpen) {
		this.restaurantOpen = restaurantOpen;
	}


	public int getRestaurantClose() {
		return restaurantClose;
	}


	public void setRestaurantClose(int restaurantClose) {
		this.restaurantClose = restaurantClose;
	}


	public int getRestaurantBreak() {
		return restaurantBreak;
	}


	public void setRestaurantBreak(int restaurantBreak) {
		this.restaurantBreak = restaurantBreak;
	}


	public int getRestaurantLastOrder() {
		return restaurantLastOrder;
	}


	public void setRestaurantLastOrder(int restaurantLastOrder) {
		this.restaurantLastOrder = restaurantLastOrder;
	}


	public boolean isRestaurantDayOff() {
		return restaurantDayOff;
	}


	public void setRestaurantDayOff(boolean restaurantDayOff) {
		this.restaurantDayOff = restaurantDayOff;
	}
	
	
}
