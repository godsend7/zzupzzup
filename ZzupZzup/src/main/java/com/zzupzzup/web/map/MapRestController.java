package com.zzupzzup.web.map;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.restaurant.RestaurantService;

@RestController
@RequestMapping("/map/*")
public class MapRestController {
	
	@Autowired
	@Qualifier("restaurantServiceImpl")
	RestaurantService restaurantService;
	
	public MapRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(getClass());
	}
	
	@RequestMapping(value = "json/listRestaurant/")
	public Map<String, Object> listRestaurant(HttpServletRequest request, @RequestParam Search search) throws Exception {
		
		System.out.println("/map/json/listRestaurant : Service");
		
		Map<String, Object> resultMap = restaurantService.listRestaurant(search);
		
		return resultMap;
	}
	
	@RequestMapping(value = "json/getSimpleRestaurant/{restaurantNo}")
	public Restaurant getSimpleRestaurant(int restaurantNo) throws Exception {
		
		System.out.println("/map/json/listRestaurant : Service");
		
		Restaurant restaurant = restaurantService.getRestaurant(restaurantNo);
		
		return restaurant;
	}
}
