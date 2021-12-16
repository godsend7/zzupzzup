package com.zzupzzup.service.domain;

public class RestaurantTime {
	
	///Field
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
