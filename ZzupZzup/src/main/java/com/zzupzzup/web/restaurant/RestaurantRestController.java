package com.zzupzzup.web.restaurant;

import java.net.URLDecoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.restaurant.RestaurantService;

@RestController
@RequestMapping("/restaurant/*")
public class RestaurantRestController {
	
	///Field
	@Autowired
	@Qualifier("restaurantServiceImpl")
	private RestaurantService restaurantService;
	
	
	///Constructor
	public RestaurantRestController() {
		System.out.println(this.getClass());
	}
	
	
	///Method
	@RequestMapping(value="json/addRestaurant/searchKeyword={searchKeyword}", method=RequestMethod.GET)
	public Map<String, Object> addRestaurant(@ModelAttribute("search") Search search, 
			HttpServletRequest request) throws Exception {
		
		System.out.println("/restaurant/json/addRestaurant : GET");
		System.out.println("REQUEST KEYWORD : " + search.getSearchKeyword());
		
		String searchK2yword = search.getSearchKeyword();
		
		search.setSearchKeyword(null);
		
		String decodeText = URLDecoder.decode(searchK2yword, "UTF-8");
		System.out.println("decodeText : " + decodeText);
		search.setSearchKeyword(decodeText);
		
		Map<String, Object> map = restaurantService.listRestaurantName(search);
		
		Restaurant restaurant = new Restaurant();
		
		map.put("restaurant", restaurant);
		
		return map;
		
	}

}
