package com.zzupzzup.web.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.zzupzzup.service.domain.HashTag;
import com.zzupzzup.service.domain.Mark;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Review;
import com.zzupzzup.service.review.ReviewService;

@RestController
@RequestMapping("/review/*")
public class ReviewRestController {
	
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	
	@Value("#{commonProperties['pageUnit']?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']?: 2}")
	int pageSize;

	public ReviewRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	@RequestMapping(value = "json/listHashTag", method = RequestMethod.GET)
	public List<HashTag> listHashTag(@RequestParam("keyWord") String keyword) throws Exception {
		
		System.out.println("/review/json/listHashTag : GET");
		
		return reviewService.listHashTag(keyword);
	}
	
//	@RequestMapping(value = "json/getReview/{reviewNo}", method = RequestMethod.GET)
//	public boolean getReview(@PathVariable("reviewNo") int reviewNo, HttpSession session) throws Exception {
//		
//		System.out.println("/review/json/getReview : GET");
//		
//		Review review = reviewService.getReview(reviewNo);
//		
//		session.removeAttribute("review");
//		
//		if (review != null) {
//			System.out.println("성공 :: " + review );
//			session.setAttribute("review", review);
//			return true;
//		}
//		
//		return false;
//	}
	
	@RequestMapping(value = "json/getReview/{reviewNo}", method = RequestMethod.GET)
	public Map<String, Object> getReview(@PathVariable("reviewNo") int reviewNo, HttpSession session) throws Exception {
		
		System.out.println("/review/json/getReview : GET");
		
		Member member = (Member) session.getAttribute("member");
		
		List<Mark> listLike = null;
		
		String memberId = null;
		
		if (member != null && member.getMemberRole().equals("user")) {
			memberId = member.getMemberId();
			listLike = reviewService.listLike(memberId);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", reviewService.getReview(reviewNo));
		map.put("listLike", listLike);
		
		return map;
	}
	
	@RequestMapping(value = "json/addLike/{reviewNo}", method = RequestMethod.GET)
	public Review addLike(@PathVariable("reviewNo") int reviewNo, HttpSession session) throws Exception {
		
		System.out.println("/review/json/addLike : GET");
		
		Member member = (Member) session.getAttribute("member");
		
		System.out.println(member);
		
		if (member != null) {
			reviewService.addLike(member.getMemberId(), reviewNo);
		}

		return reviewService.getReview(reviewNo);
	}
	
	@RequestMapping(value = "json/deleteLike/{reviewNo}", method = RequestMethod.GET)
	public Review deleteLike(@PathVariable("reviewNo") int reviewNo, HttpSession session) throws Exception {
		
		System.out.println("/review/json/deleteLike : GET");
		
		Member member = (Member) session.getAttribute("member");
		
		System.out.println(member);
		
		if (member != null) {
			reviewService.deleteLike(member.getMemberId(), reviewNo);
		}

		return reviewService.getReview(reviewNo);
	}
}
