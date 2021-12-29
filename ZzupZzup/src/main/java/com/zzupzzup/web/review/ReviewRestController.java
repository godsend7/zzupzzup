package com.zzupzzup.web.review;

import java.net.URLDecoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.zzupzzup.service.domain.HashTag;
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
	
	@RequestMapping(value = "json/getReview/{reviewNo}", method = RequestMethod.GET)
	public Review getReview(@PathVariable("reviewNo") int reviewNo) throws Exception {
		
		System.out.println("/review/json/getReview : GET");
		
		return reviewService.getReview(reviewNo);
	}
}
