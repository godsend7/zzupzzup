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
import com.zzupzzup.service.domain.HashTag;
import com.zzupzzup.service.domain.Member;
import com.zzupzzup.service.domain.Reservation;
import com.zzupzzup.service.domain.Restaurant;
import com.zzupzzup.service.domain.Review;
import com.zzupzzup.service.member.MemberService;
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
	
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	
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
		
		List<HashTag> hashTag = new ArrayList<HashTag>();
		List<String> reviewImage = new ArrayList<String>();
		
		HashTag h1 = new HashTag();
		h1.setHashTagNo(1);
		HashTag h2 = new HashTag();
		h2.setHashTagNo(2);
		
		hashTag.add(h1);
		hashTag.add(h2);
		
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
		review.setHashTag(hashTag);
		review.setReviewImage(reviewImage);
		review.setScopeTaste(4);
		review.setScopeKind(5);
		review.setScopeClean(4);
		review.setAvgScope((4+5+4)/3d);	
		
		if(reviewService.addReview(review) == 1) {
			System.out.println("review insert success " + review.getAvgScope());
			memberService.addActivityScore(member.getMemberId(), 2, 5); //리뷰 작성 시 5
		}
	}
	
	//@Test
	public void testUpdateReview() throws Exception {
		
		List<HashTag> hashTag = new ArrayList<HashTag>();
		List<String> reviewImage = new ArrayList<String>();
		
//		hashTag.add(1);
//		hashTag.add(5);
//		hashTag.add(4);
//		hashTag.add(3);
//		hashTag.add(7);
		
		HashTag h1 = new HashTag();
		h1.setHashTagNo(5);
		HashTag h2 = new HashTag();
		h2.setHashTagNo(3);
		
		hashTag.add(h1);
		hashTag.add(h2);
		
		reviewImage.add("d.jpg");
		reviewImage.add("e.jpg");
		reviewImage.add("f.jpg");
		
		Review review = new Review();
		
		review.setReviewNo(25);
		review.setReviewDetail("최고에요~~");
		review.setHashTag(hashTag);
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
		
		review.setReviewNo(5);
		
		if(reviewService.deleteReview(review.getReviewNo()) == 1) {
			System.out.println("review delete success");
		}
	}
	
	//@Test
	public void testGetReview() throws Exception {
		
		Review review = new Review();
		
		review.setReviewNo(25);
		
		review = reviewService.getReview(review.getReviewNo());
		
		System.out.println("review get success" + review);
		
		for (int i = 0; i<review.getHashTag().size(); i++) {
			System.out.println(review.getHashTag().get(i) + " : " + review.getHashTag().get(i));
		}
	}
	
	@Test
	public void testListReview() throws Exception {
		Search search = new Search();
		
		search.setCurrentPage(1);		
		search.setPageSize(pageSize);
		
		//해당 음식점의 리뷰 출력
		String restaurantNo = "1";
		//내가 작성한 리뷰 출력 
		String memberId = "hihi@a.com";
		
		Map<String, Object> map = reviewService.listReview(search, restaurantNo, memberId);
		
		List<Review> list = (List<Review>) map.get("list");
		
		System.out.println("review list success");
		
		for (Review r : list) {
			System.out.println(r.getReviewNo());
			System.out.println(r);
		}
		
		 Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		 System.out.println(resultPage);
		 System.out.println(map.get("avgTotalScope")); 
	}
	
	//@Test
	public void testListMyLikeReview() throws Exception {
		Search search = new Search();
		
		search.setCurrentPage(1);		
		search.setPageSize(pageSize);
		
		String memberId = "user02@zzupzzup.com";
			
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
		
		List<HashTag> list = reviewService.listHashTag(search);
			
		System.out.println("review listHashTag success");
		
		for (HashTag r : list) {
			//System.out.println(r);
			System.out.println(r.getHashTagNo());
			System.out.println(r.getHashTag());
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
		if(reviewService.deleteLike("hihi@a.com", 7) == 1) {
			System.out.println("review delete success");
		}
	}
}