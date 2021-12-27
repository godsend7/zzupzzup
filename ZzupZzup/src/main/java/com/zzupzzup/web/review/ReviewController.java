package com.zzupzzup.web.review;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.zzupzzup.service.domain.Reservation;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.domain.Review;
import com.zzupzzup.service.review.ReviewService;


@Controller
@RequestMapping("/review/*")
public class ReviewController {
	
	///Field
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	
	///Field
	@Autowired
	@Qualifier("reservationServiceImpl")
	private Reservation reservation;
	
	///Field
	@Autowired
	@Qualifier("restaurantServiceImpl")
	private Restaurant restaurant;
	
	///Field
	@Autowired
	@Qualifier("memberServiceImpl")
	private Member member;
	
	///Constructor
	public ReviewController() {
		System.out.println(this.getClass());
	}
	
	
	///Method
	@RequestMapping(value="addReview", method=RequestMethod.GET)
	public String addReview(@RequestParam("reservationNo") int reservationNo) throws Exception {
		
		System.out.println("review/addReview : GET");
		
		return "forward:/review/addReviewView.jsp";
	}
	
	@RequestMapping(value="addReview", method=RequestMethod.POST)
	public String addReview(@ModelAttribute("review") Review review, MultipartHttpServletRequest uploadFile) throws Exception {
		
		System.out.println("review/addReview : POST");
		
		List<MultipartFile> fileList = uploadFile.getFiles("file");
		List<String> reviewImage = new ArrayList<String>();
		
		for (MultipartFile mf : fileList) {
			reviewImage.add(mf.getOriginalFilename());
		}
		
		review.setReviewImage(reviewImage);
		System.out.println(review);

		if(reviewService.addReview(review) == 1) {
			System.out.println("review insert success " + review.getAvgScope());
			memberService.addActivityScore(member.getMemberId(), 2, 5); //리뷰 작성 시 5
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