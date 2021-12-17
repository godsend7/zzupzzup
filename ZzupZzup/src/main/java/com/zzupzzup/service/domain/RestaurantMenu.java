package com.zzupzzup.service.domain;

public class RestaurantMenu {
	
	///Field
	private String menuTitle;
	private int menuPrice;
	private boolean mainMenuStauts;
	
	
	///Constructor
	public RestaurantMenu() {
		// TODO Auto-generated constructor stub
	}
	
	
	///Method
	public boolean isMainMenuStauts() {
		return mainMenuStauts;
	}

	public void setMainMenuStauts(boolean mainMenuStauts) {
		this.mainMenuStauts = mainMenuStauts;
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
		return "RestaurantMenu [menuTitle=" + menuTitle + ", menuPrice=" + menuPrice + "]";
	}
	
	
}
