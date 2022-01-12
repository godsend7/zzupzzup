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

@Service("restaurantServiceImpl")
public class RestaurantServiceImpl implements RestaurantService {
	
	///Field
	@Autowired
	@Qualifier("restaurantDaoImpl")
	private RestaurantDAO restaurantDAO;
	
	/*
	 * public void setRestaurantDAO(RestaurantDAO restaurantDAO) {
	 * this.restaurantDAO = restaurantDAO; }
	 */
	
	
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
		return restaurantDAO.getRestaurant(restaurantNo);
	}

	@Override
	public Map<String, Object> listRestaurant(Search search) throws Exception {
		
		System.out.println("ddddd");
		System.out.println("search : " + search);
		
		List<Restaurant> list = restaurantDAO.listRestaurant(search);
		int totalCount = restaurantDAO.getTotalCount(search);
		
		System.out.println("ddddd8888");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	@Override
	public Map<String, Object> listMyRestaurant(Search search, String memberId) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("memberId", memberId);
		
		map.put("list", restaurantDAO.listMyRestaurant(map));
		map.put("totalCount", restaurantDAO.getTotalCount(search));
		
		return map;
	}
	
	@Override
	public int updateRestaurant(Restaurant restaurant) throws Exception {
		return restaurantDAO.updateRestaurant(restaurant);
	}
	
	@Override
	public int judgeRestaurant(Restaurant restaurant) throws Exception {
		return restaurantDAO.judgeRestaurant(restaurant);
	}

	@Override
	public int deleteRestaurant(int restaurantNo) throws Exception {
		return restaurantDAO.deleteRestaurant(restaurantNo);
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
	public Map<String, Object> listCallDibs(Search search, String memberId) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("memberId", memberId);
		
		map.put("list", restaurantDAO.listCallDibs(map));
		map.put("totalCount", restaurantDAO.getTotalCount(search));
		
		return map;
	}

	@Override
	public int checkCallDibs(String memberId, int restaurantNo) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("restaurantNo", restaurantNo);
		
		return restaurantDAO.checkCallDibs(map);
	}

	@Override
	public int cancelCallDibs(String memberId, int restaurantNo) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("restaurantNo", restaurantNo);
		
		return restaurantDAO.cancelCallDibs(map);
	}


	@Override
	public Map<String, Object> listRestaurantName(Search search) throws Exception {
		
		System.out.println("restaurantServiceImpl listRestaurantName");
		System.out.println("search : " + search);
	      
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		
		System.out.println("map : " + map);
		
		map.put("list", restaurantDAO.listRestaurantName(map));
		
		return map;
	}
	
	
	@Override
	public Map<String, Object> listReservationRestaurantName(Search search) throws Exception {
		
		System.out.println("restaurantServiceImpl listReservationRestaurantName");
		System.out.println("search : " + search);
	      
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		
		System.out.println("map : " + map);
		
		map.put("list", restaurantDAO.listReservationRestaurantName(map));
		
		return map;
	}

	
	@Override
	public List<Restaurant> listMainRestaurant(Search search) throws Exception {
		// TODO Auto-generated method stub
		return restaurantDAO.listMainRestaurant(search);
	}
	
	
}
