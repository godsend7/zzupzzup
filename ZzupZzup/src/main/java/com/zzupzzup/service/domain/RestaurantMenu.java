package com.zzupzzup.service.domain;

public class RestaurantMenu {
	
	///Field
	private int menuNo;
	private Restaurant restaurant;
	private String menuTitle;
	private int menuPrice;
	private boolean mainMenuStatus;
	
	
	///Constructor
	public RestaurantMenu() {
		// TODO Auto-generated constructor stub
	}
	
	
	///Method
	public int getMenuNo() {
		return menuNo;
	}

	public void setMenuNo(int menuNo) {
		this.menuNo = menuNo;
	}
	
	public Restaurant getRestaurant() {
		return restaurant;
	}

	public void setRestaurant(Restaurant restaurant) {
		this.restaurant = restaurant;
	}

	public boolean isMainMenuStatus() {
		return mainMenuStatus;
	}

	public void setMainMenuStatus(boolean mainMenuStatus) {
		this.mainMenuStatus = mainMenuStatus;
	}
	
	public String getMenuTitle() {
		return menuTitle;
	}

	public void setMenuTitle(String menuTitle) {
		this.menuTitle = menuTitle;
	}

	public int getMenuPrice() {
		return menuPrice;
	}

	public void setMenuPrice(int menuPrice) {
		this.menuPrice = menuPrice;
	}

	@Override
	public String toString() {
		return "RestaurantMenu [menuNo=" + menuNo + ", restaurantNo=" + restaurant + ", menuTitle=" + menuTitle
				+ ", menuPrice=" + menuPrice + ", mainMenuStatus=" + mainMenuStatus + "]";
	}
	
	
}
