package com.zzupzzup.service.review.test;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.aspectj.apache.bcel.generic.ReturnaddressType;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zzupzzup.common.Page;
import com.zzupzzup.common.Search;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Reservation;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.domain.Review;
import com.zzupzzup.service.reservation.ReservationService;
import com.zzupzzup.service.review.ReviewService;


@RunWith(SpringJUnit4ClassRunner.class)

//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
										"classpath:config/context-aspect.xml",
										"classpath:config/context-mybatis.xml",
										"classpath:config/context-transaction.xml" })

public class ReviewServiceTest {

	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	
	@Autowired
	@Qualifier("reservationServiceImpl")
	private ReservationService reservationService;
	
	@Value("#{commonProperties['pageUnit']?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']?: 2}")
	int pageSize;

	//@Test
	public void testAddReview() throws Exception {
		Review review = new Review();
		Member member = new Member();
		Reservation reservation = new Reservation();
		Restaurant restaurant = new Restaurant();
		
		List<Integer> hashTag = new ArrayList<Integer>();
		List<String> reviewImage = new ArrayList<String>();
		
		hashTag.add(1);
		hashTag.add(2);
		hashTag.add(3);
		
		reviewImage.add("a.jpg");
		reviewImage.add("b.jpg");
		reviewImage.add("c.jpg");
		
		//reservation = reservationService.getReservation("20211220123934_928193028");
		restaurant.setRestaurantNo(1);
		
		member.setMemberId("user02@zzupzzup.com");
		reservation.setReservationNo(1);
		reservation.setRestaurant(restaurant);
		review.setMember(member);
		review.setReservation(reservation);
		review.setReviewDetail("맛있어요~~");
		review.setHashTagNo(hashTag);
		review.setReviewImage(reviewImage);
		review.setScopeTaste(4);
		review.setScopeKind(5);
		review.setScopeClean(4);
		review.setAvgScope((4+5+4)/3d);	
		
		if(reviewService.addReview(review) == 1) {
			System.out.println("review insert success " + review.getAvgScope());
		}
	}
	
	//@Test
	public void testUpdateReview() throws Exception {
		
		List<Integer> hashTag = new ArrayList<Integer>();
		List<String> reviewImage = new ArrayList<String>();
		
		hashTag.add(1);
		hashTag.add(5);
		hashTag.add(4);
		hashTag.add(3);
		hashTag.add(7);
		
		reviewImage.add("d.jpg");
		reviewImage.add("e.jpg");
		reviewImage.add("f.jpg");
		
		Review review = new Review();
		
		review.setReviewNo(5);
		review.setReviewDetail("최고에요~~");
		review.setHashTagNo(hashTag);
		review.setReviewImage(reviewImage);
		review.setScopeTaste(5);
		review.setScopeKind(5);
		review.setScopeClean(5);
		review.setAvgScope((5+5+5)/3d);
		//reviewShowStatus (관리자만 변경 가능)
		review.setReviewShowStatus(false);
		
		if(reviewService.updateReview(review) == 1) {
			System.out.println("review update success");
		}
	}
	
	//@Test
	public void testDeleteReview() throws Exception {
		
		Review review = new Review();
		
		review.setReviewNo(8);
		
		if(reviewService.deleteReview(review.getReviewNo()) == 1) {
			System.out.println("review delete success");
		}
	}
	
	//@Test
	public void testGetReview() throws Exception {
		
		Review review = new Review();
		
		review.setReviewNo(5);
		
		review = reviewService.getReview(review.getReviewNo());
		
		System.out.println("review get success" + review);
		
		for (int i = 0; i<review.getHashTagNo().size(); i++) {
			System.out.println(review.getHashTagNo().get(i) + " : " + review.getHashTag().get(i));
		}
	}
	
	@Test
	public void testListReview() throws Exception {
		Search search = new Search();
		
		search.setCurrentPage(3);		
		search.setPageSize(pageSize);
		
		//해당 음식점의 리뷰 출력
		String restaurantNo = null;
		//내가 작성한 리뷰 출력 
		String memberId = null;
		
		Map<String, Object> map = reviewService.listReview(search, restaurantNo, memberId);
		
		List<Review> list = (List<Review>) map.get("list");
		
		System.out.println("review list success");
		
		for (Review r : list) {
			System.out.println(r.getReviewNo());
		}
		
		 Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		 System.out.println(resultPage);
	}
	
	//@Test
	public void testListMyLikeReview() throws Exception {
		Search search = new Search();
			
		String memberId = "user";
			
		Map<String, Object> map = reviewService.listMyLikeReview(search, memberId);
			
		List<Review> list = (List<Review>) map.get("list");
			
		System.out.println("review list success");
			
		for (Review r : list) {
			System.out.println(r);
		}
	}
	
	//@Test
	public void testListHashTag() throws Exception {
		String search = "#";
		
		List<Map<String, Object>> list = reviewService.listHashTag(search);
			
		System.out.println("review listHashTag success");
		
		for (Map r : list) {
			//System.out.println(r);
			System.out.println(r.get("testHashtagNo"));
			System.out.println(r.get("testHashtag"));
		}
	}
	
	//@Test
	public void testAddLike() throws Exception {
		if(reviewService.addLike("hihi@a.com", 7) == 1) {
			System.out.println("review insert success");
		}
	}
	
	//@Test
	public void testDeleteLike() throws Exception {
		if(reviewService.deleteLike("hihi@a.com", 5) == 1) {
			System.out.println("review delete success");
		}
	}
}