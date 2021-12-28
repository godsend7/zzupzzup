package com.zzupzzup.web.review;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Reservation;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.domain.Review;
import com.zzupzzup.service.member.MemberService;
import com.zzupzzup.service.reservation.ReservationService;
import com.zzupzzup.service.restaurant.RestaurantService;
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
	private ReservationService reservationService;
	
	///Field
	@Autowired
	@Qualifier("restaurantServiceImpl")
	private RestaurantService restaurantService;
	
	///Field
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	
	///Constructor
	public ReviewController() {
		System.out.println(this.getClass());
	}
	
	
	///Method
	@RequestMapping(value="addReview", method=RequestMethod.GET)
	public String addReview(@RequestParam("reservationNo") int reservationNo, Model model) throws Exception {
		
		System.out.println("review/addReview : GET");
		
		Review review = new Review();
		review.setReservation(reservationService.getReservation(reservationNo));
		review.setRestaurant(restaurantService.getRestaurant(review.getReservation().getRestaurant().getRestaurantNo()));
		
		System.out.println(review);
		model.addAttribute("review", review);
		
		return "forward:/review/addReviewView.jsp";
	}
	
	@RequestMapping(value="addReview", method=RequestMethod.POST)
	public String addReview(@ModelAttribute("review") Review review, MultipartHttpServletRequest uploadFile, Model model) throws Exception {
		
		System.out.println("review/addReview : POST");
		
		List<MultipartFile> fileList = uploadFile.getFiles("file");
		System.out.println(fileList.size());
		List<String> reviewImage = new ArrayList<String>();
		
		for (MultipartFile mf : fileList) {
			//image가 존재한다면(image의 name이 공백이 아닐경우)
			if (!mf.getOriginalFilename().equals("")) {
				reviewImage.add(mf.getOriginalFilename());
				review.setReviewImage(reviewImage);
			}
		}
		
		
		System.out.println(review);
		//System.out.println(review.getAvgScope());
		//리뷰 작성 성공 시 활동점수 추가 
		if(reviewService.addReview(review) == 1) {
			System.out.println("review insert success " + review.getAvgScope());
			memberService.addActivityScore(review.getMember().getMemberId(), 2, 5); //리뷰 작성 시 5
		}
		
		return "redirect:/listMyReview";
	}
	
	@RequestMapping(value="updateReview", method=RequestMethod.GET)
	public String updateReview(@RequestParam("reviewNo") int reviewNo, Model model) throws Exception {
		
		System.out.println("review/updateReview : GET");
		
		Review review = reviewService.getReview(reviewNo);
		
		model.addAttribute("review", review);
		
		return "forward:/review/updateReviewView.jsp";
	}
	
	
}