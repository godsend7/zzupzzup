package com.zzupzzup.web.restaurant;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.restaurant.RestaurantService;

@Controller
@RequestMapping("/restaurant/*")
public class RestaurantController {
	
	///Field
	@Autowired
	@Qualifier("restaurantServiceImpl")
	private RestaurantService restaurantService;
	
	
	///Constructor
	public RestaurantController() {
		System.out.println(this.getClass());
	}
	
	
	///Method
	@RequestMapping(value="addRestaurant", method=RequestMethod.GET)
	public String addRestaurant() throws Exception {
		
		System.out.println("restaurant/addRestaurant : GET");
		
		return "forward:/restaurant/addRestaurantView.jsp";
	}
	
	@RequestMapping(value="addRestaurant", method=RequestMethod.POST)
	public String addRestaurant(@ModelAttribute("restaurant") Restaurant restaurant) throws Exception {
		
		System.out.println("restaurant/addRestaurant : POST");
		
		restaurantService.addRestaurant(restaurant);
		
		return "redirect:/restaurant/addRestaurant.jsp";
	}
	
	@RequestMapping(value="getRestaurant", method=RequestMethod.GET)
	public String getRestaurant(@RequestParam() int restaurantNo, Model model) throws Exception {
		
		System.out.println("restaurant/getRestaurant : GET");
		
		Restaurant restaurant = restaurantService.getRestaurant(restaurantNo);
		
		model.addAttribute("restaurant", restaurant);
		
		return "forward:/restaurant/getRestaurant.jsp";
	}
	
	
}
