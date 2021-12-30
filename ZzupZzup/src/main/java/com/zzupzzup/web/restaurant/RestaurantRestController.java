package com.zzupzzup.web.restaurant;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

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
	@RequestMapping(value="json/addRestaurant", method=RequestMethod.GET)
	public Restaurant addRestaurant() {
		
		System.out.println("/restaurant/json/addRestaurant : GET");
		
		return null;
		
	}

}
