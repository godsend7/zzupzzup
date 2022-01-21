package com.zzupzzup.service.restaurant;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Mark;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.domain.RestaurantMenu;
import com.zzupzzup.service.domain.RestaurantTime;

public interface RestaurantDAO {
	
	public int addRestaurant(Restaurant restaurant) throws Exception;
	
	public Restaurant getRestaurant(int restaurantNo) throws Exception;
	
	public RestaurantMenu getRestaurantMenu(RestaurantMenu restaurantMenu) throws Exception;
	
	public RestaurantTime getRestaurantTime(RestaurantTime restaurantTime) throws Exception;
	
	public List<Restaurant> listRestaurant(Search search) throws Exception;
	
	public List<Restaurant> listMyRestaurant(Map<String, Object> map) throws Exception;
	
	public List<Restaurant> listRequestRestaurant(Search search) throws Exception;
	
	public int updateRestaurant(Restaurant restaurant) throws Exception;
	
	public int judgeRestaurant(Restaurant restaurant) throws Exception;
	
	public int deleteRestaurant(int restaurantNo) throws Exception;
	
	public int getTotalCount(Search search) throws Exception;
	
	public int getRequestTotalCount(Search search) throws Exception;
	
	public List<Mark> listCallDibs(String memberId) throws Exception;
	
	public List<Restaurant> listMyCallDibs(Map<String, Object> map) throws Exception;
	
	public int checkCallDibs(Map<String, Object> map) throws Exception;
	
	public int cancelCallDibs(Map<String, Object> map) throws Exception;
	
	public List<Restaurant> listRestaurantName(Map<String, Object> map);
	
	public List<Restaurant> listReservationRestaurantName(Map<String, Object> map);
	
	// MAIN MAP
	public List<Restaurant> listMainRestaurant(Search search) throws Exception;
	
	public int getMyRestaurantTotalCount(Map<String, Object> map) throws Exception;
	
}
