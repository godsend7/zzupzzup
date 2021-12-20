package com.zzupzzup.service.restaurant.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.domain.RestaurantMenu;
import com.zzupzzup.service.domain.RestaurantTime;
import com.zzupzzup.service.restaurant.RestaurantDAO;
import com.zzupzzup.service.restaurant.RestaurantService;

//@Service("restaurantServiceImpl")
public class RestaurantServiceImpl implements RestaurantService {
	
	///Field
	//@Autowired
	//@Qualifier("restaurantDaoImpl")
	private RestaurantDAO restaurantDAO;
	public void setRestaurantDAO(RestaurantDAO restaurantDAO) {
		this.restaurantDAO = restaurantDAO;
	}
	
	
	///Constructor
	public RestaurantServiceImpl() {
		System.out.println(this.getClass());
	}
	
	
	///Method
	@Override
	public int addRestaurant(Restaurant restaurant) throws Exception {
		return restaurantDAO.addRestaurant(restaurant);
	}

	@Override
	public Restaurant getRestaurant(int restaurantNo) throws Exception {
		
		
		return null;
	}

	@Override
	public Map<String, Object> listRestaurant(Search search) throws Exception {
		List<Restaurant> list = restaurantDAO.listRestaurant(search);
		int totalCount = restaurantDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override
	public int updateRestaurant(Restaurant restaurant) throws Exception {
		return restaurantDAO.updateRestaurant(restaurant);
	}

	@Override
	public int deleteRestaurant(Restaurant restaurant) throws Exception {
		return restaurantDAO.deleteRestaurant(restaurant);
	}

	@Override
	public RestaurantMenu getRestaurantMenu(RestaurantMenu restaurantMenu) throws Exception {
		return null;
	}

	@Override
	public RestaurantTime getRestaurantTime(RestaurantTime restaurantTime) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public void listCallDibs() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void checkCallDibs() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void cancelCallDibs() throws Exception {
		// TODO Auto-generated method stub
		
	}

}
