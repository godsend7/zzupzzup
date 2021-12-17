package com.zzupzzup.service.restaurant;

import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.domain.RestaurantMenu;
import com.zzupzzup.service.domain.RestaurantTime;

public interface RestaurantDAO {
	
	public void addRestaurant(Restaurant restaurant) throws Exception;
	
	public Restaurant getRestaurant(int restaurantNo) throws Exception;
	
	public void listRestaurant() throws Exception;
	
	public void updateRestaurant(Restaurant restaurant) throws Exception;
	
	public void deleteRestaurant(Restaurant restaurant) throws Exception;
	
	public void listCallDibs() throws Exception;
	
	public void checkCallDibs() throws Exception;
	
	public void cancelCallDibs() throws Exception;
	
	public void getRestaurantMenu(RestaurantMenu restaurantMenu) throws Exception;
	
	public void getRestaurantTime(RestaurantTime restaurantTime) throws Exception;
	
}
