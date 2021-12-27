package com.zzupzzup.web.review;

import java.util.Iterator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.zzupzzup.service.domain.Review;
import com.zzupzzup.service.review.ReviewService;


@Controller
@RequestMapping("/review/*")
public class ReviewController {
	
	///Field
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService resviewService;
	
	
	///Constructor
	public ReviewController() {
		System.out.println(this.getClass());
	}
	
	
	///Method
	@RequestMapping(value="addReview", method=RequestMethod.GET)
	public String addReview() throws Exception {
		
		System.out.println("review/addReview : GET");
		
		return "forward:/review/addReviewView.jsp";
	}
	
	@RequestMapping(value="addReview", method=RequestMethod.POST)
	public String addReview(@ModelAttribute("review") Review review, @RequestParam(value="fileName", required = false) MultipartFile uploadFile) throws Exception {
		
		System.out.println("review/addReview : POST");
		
		System.out.println(review);
		
		for (int i=0; i<uploadFile.getSize(); i++) {
			System.out.println(uploadFile.getOriginalFilename());
		}
		
		return "redirect:/review/addReviewView.jsp";
	}
	
//	@RequestMapping(value="getRestaurant", method=RequestMethod.GET)
//	public String getRestaurant(@RequestParam() int restaurantNo, Model model) throws Exception {
//		
//		System.out.println("restaurant/getRestaurant : GET");
//		
//		Restaurant restaurant = restaurantService.getRestaurant(restaurantNo);
//		
//		model.addAttribute("restaurant", restaurant);
//		
//		return "forward:/restaurant/getRestaurant.jsp";
//	}
	
	
}