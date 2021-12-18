package com.zzupzzup.service.restaurant;

import java.util.List;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.domain.RestaurantMenu;
import com.zzupzzup.service.domain.RestaurantTime;

public interface RestaurantDAO {
	
	public int addRestaurant(Restaurant restaurant) throws Exception;
	
	public Restaurant getRestaurant(int restaurantNo) throws Exception;
	
	public RestaurantMenu getRestaurantMenu(RestaurantMenu restaurantMenu) throws Exception;
	
	public RestaurantTime getRestaurantTime(RestaurantTime restaurantTime) throws Exception;
	
	public List<Restaurant> listRestaurant(Search search) throws Exception;
	
	public int updateRestaurant(Restaurant restaurant) throws Exception;
	
	public int deleteRestaurant(Restaurant restaurant) throws Exception;
	
	public int getTotalCount(Search search) throws Exception;
	
	public void listCallDibs() throws Exception;
	
	public void checkCallDibs() throws Exception;
	
	public void cancelCallDibs() throws Exception;
	
}
