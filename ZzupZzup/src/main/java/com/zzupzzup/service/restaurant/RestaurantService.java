package com.zzupzzup.service.restaurant;

import java.util.List;
import java.util.Map;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Mark;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.domain.RestaurantMenu;
import com.zzupzzup.service.domain.RestaurantTime;

public interface RestaurantService {
	
	public int addRestaurant(Restaurant restaurant) throws Exception;
	
	public Restaurant getRestaurant(int restaurantNo) throws Exception;
	
	public RestaurantMenu getRestaurantMenu(RestaurantMenu restaurantMenu) throws Exception;
	
	public RestaurantTime getRestaurantTime(RestaurantTime restaurantTime) throws Exception;
	
	public Map<String, Object> listRestaurant(Search search) throws Exception;
	
	public Map<String, Object> listMyRestaurant(Search search, String memberId) throws Exception;
	
	public Map<String, Object> listRequestRestaurant(Search search) throws Exception;
	
	public int updateRestaurant(Restaurant restaurant) throws Exception;
	
	public int judgeRestaurant(Restaurant restaurant) throws Exception;
	
	public int deleteRestaurant(int restaurantNo) throws Exception;
	
	public List<Mark> listCallDibs(String memberId) throws Exception;
	
	public int checkCallDibs(String memberId, int restaurantNo) throws Exception;
	
	public int cancelCallDibs(String memberId, int restaurantNo) throws Exception;
	
	public Map<String, Object> listMyCallDibs(Search search, Member member) throws Exception;
	
	// Select List
	public Map<String, Object> listRestaurantName(Search search) throws Exception;

	public Map<String, Object> listReservationRestaurantName(Search search) throws Exception;
	
	// Select List Main
	public List<Restaurant> listMainRestaurant(Search search) throws Exception;
	
}
