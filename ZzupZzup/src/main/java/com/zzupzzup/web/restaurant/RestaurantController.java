package com.zzupzzup.web.restaurant;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.domain.RestaurantMenu;
import com.zzupzzup.service.domain.RestaurantTime;
import com.zzupzzup.service.restaurant.RestaurantService;

@Controller
@RequestMapping("/restaurant/*")
public class RestaurantController {
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
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
		
		System.out.println("/restaurant/addRestaurant : GET");
		
		return "forward:/restaurant/addRestaurantView.jsp";
	}
	
	@RequestMapping(value="addRestaurant", method=RequestMethod.POST)
	public String addRestaurant(@ModelAttribute("restaurant") Restaurant restaurant, 
			@ModelAttribute("restaurantMenus") Restaurant restaurantMenus,
			@ModelAttribute("restaurantTimes") Restaurant restaurantTimes,
			/*@ModelAttribute("restaurantImage") Restaurant restaurantImage*/
			MultipartHttpServletRequest uploadFile,
			HttpServletRequest request) throws Exception {
		
		String empty = request.getServletContext().getRealPath("/resources/images/uploadImages");
		
		System.out.println("/restaurant/addRestaurant : POST");
		
		
		
		restaurantService.addRestaurant(restaurant);
		
		for(RestaurantMenu rm : restaurantMenus.getRestaurantMenus()) {
			System.out.println(rm);
		}
		
		for(RestaurantTime rt : restaurantTimes.getRestaurantTimes()) {
			System.out.println(rt);
		}
		
		/*
		 * for(String ri : restaurantImage.getRestaurantImage()) {
		 * System.out.println(ri); }
		 */
		
		//System.out.println("Restaurant Menu : " + restaurant.getRestaurantMenus());
		
		return "forward:/restaurant/addRestaurant.jsp";
	}
	
	@RequestMapping(value="getRestaurant", method=RequestMethod.GET)
	public String getRestaurant(@RequestParam("restaurantNo") int restaurantNo, Model model) throws Exception {
		
		System.out.println("/restaurant/getRestaurant : GET");
		
		Restaurant restaurant = restaurantService.getRestaurant(restaurantNo);
		
		model.addAttribute("restaurant", restaurant);
		
		return "forward:/restaurant/getRestaurant.jsp";
	}
	
	@RequestMapping(value="updateRestaurant", method=RequestMethod.POST)
	public String updateRestaurant(@ModelAttribute("restaurant") Restaurant restaurant, HttpSession session) throws Exception {
		
		System.out.println("/restaurant/updateRestaurant : POST");
		
		restaurantService.updateRestaurant(restaurant);
		
		int sessionNo = restaurant.getRestaurantNo();
		String sessionNum = Integer.toString(sessionNo);
		
		if(sessionNum.equals(restaurant.getRestaurantNo())) {
			session.setAttribute("restaurant", restaurant);
		}
		
		return "redirect:/restaurant/getRestaurant?restaurantNo=" + restaurant.getRestaurantNo();
	}
	
	
	
	@RequestMapping(value="listRestaurant")
	public String listRestaurant(@ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception {
		
		System.out.println("/restaurant/listRestaurant : SERVICE");
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		
		if(request.getParameter("page") != null) {
			search.setCurrentPage(Integer.parseInt(request.getParameter("page")));
		}
		
		search.setPageSize(pageSize);
		
		Map<String, Object> map = restaurantService.listRestaurant(search);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("search", search);
		
		return "forward:/restaurant/listRestaurant.jsp";
		
	}
	
	
}
